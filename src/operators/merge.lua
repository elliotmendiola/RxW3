WM('RxW3OperatorsMerge', function (import, export, default)
  local Observable = import 'RxW3Observable'

  --- Returns a new Observable that produces the values produced by all the specified Observables in
  -- the order they are produced.
  -- @arg {Observable...} sources - One or more Observables to merge.
  -- @returns {Observable}
  default(function (...)
    return function (self)
      local sources = {...}
      table.insert(sources, 1, self)

      return Observable.create(function(observer)
        local completed = {}
        local subscriptions = {}

        local function onNext(...)
          return observer:onNext(...)
        end

        local function onError(message)
          return observer:onError(message)
        end

        local function onCompleted(i)
          return function()
            table.insert(completed, i)

            if #completed == #sources then
              observer:onCompleted()
            end
          end
        end

        for i = 1, #sources do
          subscriptions[i] = sources[i]:subscribe(onNext, onError, onCompleted(i))
        end

        return Subscription.create(function ()
          for i = 1, #sources do
            if subscriptions[i] then subscriptions[i]:unsubscribe() end
          end
        end)
      end)
    end
  end);
end);
