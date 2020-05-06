WM('RxW3OperatorsTakeUntil', function (import, export, default)
  local Observable = import 'RxW3Observable'

  --- Returns a new Observable that completes when the specified Observable fires.
  -- @arg {Observable} other - The Observable that triggers completion of the original.
  -- @returns {Observable}
  default(function (other)
    return function (self)
      return Observable.create(function(observer)
        local function onNext(...)
          return observer:onNext(...)
        end

        local function onError(e)
          return observer:onError(e)
        end

        local function onCompleted()
          return observer:onCompleted()
        end

        other:subscribe(onCompleted, onCompleted, onCompleted)

        return self:subscribe(onNext, onError, onCompleted)
      end)
    end
  end);
end);
