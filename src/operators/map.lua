WM('RxW3OperatorsMap', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local util = import 'RxW3Util'


  --- Returns a new Observable that produces the values of the original transformed by a function.
  -- @arg {function} callback - The function to transform values from the original Observable.
  -- @returns {Observable}
  default(function (callback)
    return function (self)
      return Observable.create(function(observer)
        callback = callback or util.identity

        local function onNext(...)
          return util.tryWithObserver(observer, function(...)
            return observer:onNext(callback(...))
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
