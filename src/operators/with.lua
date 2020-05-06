WM('RxW3OperatorsWith', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local util = import 'RxW3Util'

  --- Returns an Observable that produces values from the original along with the most recently
  -- produced value from all other specified Observables. Note that only the first argument from each
  -- source Observable is used.
  -- @arg {Observable...} sources - The Observables to include the most recent values from.
  -- @returns {Observable}
  default(function (...)
    local sources = {...}

    return function (self)
      return Observable.create(function(observer)
        local latest = setmetatable({}, {__len = util.constant(#sources)})
        local subscriptions = {}

        local function setLatest(i)
          return function(value)
            latest[i] = value
          end
        end

        local function onNext(value)
          return observer:onNext(value, util.unpack(latest))
        end

        local function onError(e)
          return observer:onError(e)
        end

        local function onCompleted()
          return observer:onCompleted()
        end

        for i = 1, #sources do
          subscriptions[i] = sources[i]:subscribe(setLatest(i), util.noop, util.noop)
        end

        subscriptions[#sources + 1] = self:subscribe(onNext, onError, onCompleted)
        return Subscription.create(function ()
          for i = 1, #sources + 1 do
            if subscriptions[i] then subscriptions[i]:unsubscribe() end
          end
        end)
      end)
    end
  end);
end);
