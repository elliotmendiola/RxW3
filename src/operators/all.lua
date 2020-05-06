WM('RxW3OperatorsAll', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local util = import 'RxW3Util'

  --- Determine whether all items emitted by an Observable meet some criteria.
  -- @arg {function=identity} predicate - The predicate used to evaluate objects.
  default(function (predicate)
    predicate = predicate or util.identity

    return function (self)
      return Observable.create(function(observer)
        local function onNext(...)
          util.tryWithObserver(observer, function(...)
            if not predicate(...) then
              observer:onNext(false)
              observer:onCompleted()
            end
          end, ...)
        end

        local function onError(e)
          return observer:onError(e)
        end

        local function onCompleted()
          observer:onNext(true)
          return observer:onCompleted()
        end

        return self:subscribe(onNext, onError, onCompleted)
      end)
    end
  end);
end);