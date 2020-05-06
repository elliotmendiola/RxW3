WM('RxW3OperatorsTake', function (import, export, default)
  local Observable = import 'RxW3Observable'

  --- Returns a new Observable that only produces the first n results of the original.
  -- @arg {number=1} n - The number of elements to produce before completing.
  -- @returns {Observable}
  default(function (n)
    n = n or 1

    return function (self)
      return Observable.create(function(observer)
        if n <= 0 then
          observer:onCompleted()
          return
        end

        local i = 1

        local function onNext(...)
          observer:onNext(...)

          i = i + 1

          if i > n then
            observer:onCompleted()
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
