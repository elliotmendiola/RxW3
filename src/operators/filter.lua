WM('RxW3OperatorsFilter', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local util = import 'RxW3Util'


  --- Returns a new Observable that only produces values of the first that satisfy a predicate.
  -- @arg {function} predicate - The predicate used to filter values.
  -- @returns {Observable}
  default(function (predicate)
    predicate = predicate or util.identity

    return function (self)
      return Observable.create(function(observer)
        local function onNext(...)
          util.tryWithObserver(observer, function(...)
            if predicate(...) then
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
