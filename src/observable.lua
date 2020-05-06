WM('RxW3Observable', function (import, export, default)
  local util = import 'RxW3Util'
  local events = import 'RxW3Events'

  --- @class Observable
  -- @description Observables push values to Observers.
  local Observable = {}
  Observable.__index = Observable
  Observable.__tostring = util.constant('Observable')
  Observable.__triggers = {};

  --- Creates a new Observable.
  -- @arg {function} subscribe - The subscription function that produces values.
  -- @returns {Observable}
  function Observable.create(subscribe)
    local self = {
      _subscribe = subscribe
    }

    return setmetatable(self, Observable)
  end

  --- Shorthand for creating an Observer and passing it to this Observable's subscription function.
  -- @arg {function} onNext - Called when the Observable produces a value.
  -- @arg {function} onError - Called when the Observable terminates due to an error.
  -- @arg {function} onCompleted - Called when the Observable completes normally.
  function Observable:subscribe(onNext, onError, onCompleted)
    if type(onNext) == 'table' then
      return self._subscribe(onNext)
    else
      return self._subscribe(Observer.create(onNext, onError, onCompleted))
    end
  end

  --- Returns an Observable that immediately completes without producing a value.
  function Observable.empty()
    return Observable.create(function(observer)
      observer:onCompleted()
    end)
  end

  --- Returns an Observable that never produces values and never completes.
  function Observable.never()
    return Observable.create(function(observer) end)
  end

  --- Returns an Observable that immediately produces an error.
  function Observable.throw(message)
    return Observable.create(function(observer)
      observer:onError(message)
    end)
  end

  --- Creates an Observable that produces a set of values.
  -- @arg {*...} values
  -- @returns {Observable}
  function Observable.of(...)
    local args = {...}
    local argCount = select('#', ...)
    return Observable.create(function(observer)
      for i = 1, argCount do
        observer:onNext(args[i])
      end

      observer:onCompleted()
    end)
  end

  --- Creates an Observable that produces emissions when an event is fired, each emission should include all event arguments.
  -- @arg {string} type - The event type
  -- @arg {...} additional arguments - Any additional arguments an event may take, IE: Unit event type for AnyUnit event observable
  -- @returns {Observable}
  function Observable.fromEvent(type, ...)
    local path = util.pack(...);
    if (not util.nest(Observable.__triggers[type], path, nil)) then
      local wrapper = util.nest(Observable.__triggers[type], path, { ['trigger'] = CreateTrigger(), ['observers'] = {} });
      events[type].init(wrapper.trigger);
      TriggerAddCondition(wrapper.trigger, function ()
        local args = {};
        local timer = CreateTimer()
        local observer = 0;

        for x = 0, #events[type].args, 1 do
          args[x] = events[type].args[x]();
        end

        -- In Lua (and most other languages too) the minimum interval is 4ms.
        -- Here we asyncronously emit to each observable from this event
        TimerStart(timer, 0.004, true, function ()
          wrapper.observers[observer]:onNext(args);
          observer = observer + 1;
          if not wrapper.observers[observer] then
            DestroyTimer(timer);
          end
        end);
      end)
    end
    return Observable.create(function (observer)
      table.insert(util.nest(Observable.__triggers[type], path, nil).observers, observer);
      -- Insert this observer into the list of observer to asyncronously dispatch emissions to
    end);
  end

  --- Creates an Observable that produces a range of values in a manner similar to a Lua for loop.
  -- @arg {number} initial - The first value of the range, or the upper limit if no other arguments
  --                         are specified.
  -- @arg {number=} limit - The second value of the range.
  -- @arg {number=1} step - An amount to increment the value by each iteration.
  -- @returns {Observable}
  function Observable.fromRange(initial, limit, step)
    if not limit and not step then
      initial, limit = 1, initial
    end

    step = step or 1

    return Observable.create(function(observer)
      for i = initial, limit, step do
        observer:onNext(i)
      end

      observer:onCompleted()
    end)
  end

  --- Creates an Observable that produces values from a table.
  -- @arg {table} table - The table used to create the Observable.
  -- @arg {function=pairs} iterator - An iterator used to iterate the table, e.g. pairs or ipairs.
  -- @arg {boolean} keys - Whether or not to also emit the keys of the table.
  -- @returns {Observable}
  function Observable.fromTable(t, iterator, keys)
    iterator = iterator or pairs
    return Observable.create(function(observer)
      for key, value in iterator(t) do
        observer:onNext(value, keys and key or nil)
      end

      observer:onCompleted()
    end)
  end

  --- Creates an Observable that produces values when the specified coroutine yields.
  -- @arg {thread|function} fn - A coroutine or function to use to generate values.  Note that if a
  --                             coroutine is used, the values it yields will be shared by all
  --                             subscribed Observers (influenced by the Scheduler), whereas a new
  --                             coroutine will be created for each Observer when a function is used.
  -- @returns {Observable}
  function Observable.fromCoroutine(fn, scheduler)
    return Observable.create(function(observer)
      local thread = type(fn) == 'function' and coroutine.create(fn) or fn
      return scheduler:schedule(function()
        while not observer.stopped do
          local success, value = coroutine.resume(thread)

          if success then
            observer:onNext(value)
          else
            return observer:onError(value)
          end

          if coroutine.status(thread) == 'dead' then
            return observer:onCompleted()
          end

          coroutine.yield()
        end
      end)
    end)
  end

  --- Creates an Observable that produces values from a file, line by line.
  -- @arg {string} filename - The name of the file used to create the Observable
  -- @returns {Observable}
  function Observable.fromFileByLine(filename)
    return Observable.create(function(observer)
      local file = io.open(filename, 'r')
      if file then
        file:close()

        for line in io.lines(filename) do
          observer:onNext(line)
        end

        return observer:onCompleted()
      else
        return observer:onError(filename)
      end
    end)
  end

  --- Creates an Observable that creates a new Observable for each observer using a factory function.
  -- @arg {function} factory - A function that returns an Observable.
  -- @returns {Observable}
  function Observable.defer(fn)
    if not fn or type(fn) ~= 'function' then
      error('Expected a function')
    end

    return setmetatable({
      subscribe = function(_, ...)
        local observable = fn()
        return observable:subscribe(...)
      end
    }, Observable)
  end

  --- Returns an Observable that repeats a value a specified number of times.
  -- @arg {*} value - The value to repeat.
  -- @arg {number=} count - The number of times to repeat the value.  If left unspecified, the value
  --                        is repeated an infinite number of times.
  -- @returns {Observable}
  function Observable.replicate(value, count)
    return Observable.create(function(observer)
      while count == nil or count > 0 do
        observer:onNext(value)
        if count then
          count = count - 1
        end
      end
      observer:onCompleted()
    end)
  end

  --- Subscribes to this Observable and prints values it produces.
  -- @arg {string=} name - Prefixes the printed messages with a name.
  -- @arg {function=tostring} formatter - A function that formats one or more values to be printed.
  function Observable:dump(name, formatter)
    name = name and (name .. ' ') or ''
    formatter = formatter or tostring

    local onNext = function(...) print(name .. 'onNext: ' .. formatter(...)) end
    local onError = function(e) print(name .. 'onError: ' .. e) end
    local onCompleted = function() print(name .. 'onCompleted') end

    return self:subscribe(onNext, onError, onCompleted)
  end

  function Observable:pipe(...)
    local operators = util.pack(...);
    local current = self;
    for x = 0, operators.n, 1 do
      current = operators[x](current);
    end

    return current;
  end

  default(Observable);
end);