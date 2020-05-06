WM('RxW3OperatorsSkip', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local util = import 'RxW3Util'


  --- Returns a new Observable that skips over a specified number of values produced by the original
  -- and produces the rest.
  -- @arg {number=1} n - The number of values to ignore.
  -- @returns {Observable}
  default(function (n)
    n = n or 1

    return function (self)
      return Observable.create(function(observer)
        local i = 1

        local function onNext(...)
          if i > n then
            observer:onNext(...)
          else
            i = i + 1
          end
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