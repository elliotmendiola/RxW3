WM('RxW3OperatorsReject', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local util = import 'RxW3Util'


  --- Returns a new Observable that produces values from the original which do not satisfy a
  -- predicate.
  -- @arg {function} predicate - The predicate used to reject values.
  -- @returns {Observable}
  default(function (predicate)
    predicate = predicate or util.identity

    return function (self)
      return Observable.create(function(observer)
        local function onNext(...)
          util.tryWithObserver(observer, function(...)
            if not predicate(...) then
              return observer:onNext(...)
            end
          end, ...)
        end

        local function onError(e)
          return observer:onError(e)
        end

        local function onCompleted()
          return observer:onCompleted()
        end

        return self:subscribe(onNext, onError, onCompleted)
      end)
    end
  end);
end);
