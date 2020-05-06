WM('RxW3OperatorsFind', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local util = import 'RxW3Util'

  --- Returns a new Observable that produces the first value of the original that satisfies a
  -- predicate.
  -- @arg {function} predicate - The predicate used to find a value.
  default(function (predicate)
    predicate = predicate or util.identity

    return function (self)
      return Observable.create(function(observer)
        local function onNext(...)
          util.tryWithObserver(observer, function(...)
            if predicate(...) then
              observer:onNext(...)
              return observer:onCompleted()
            end
          end, ...)
        end

        local function onError(message)
          return observer:onError(message)
        end

        local function onCompleted()
          return observer:onCompleted()
        end

        return self:subscribe(onNext, onError, onCompleted)
      end)
    end
  end);
end);
