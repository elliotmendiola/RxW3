WM('RxW3OperatorsAverage', function (import, export, default)
  local Observable = import 'RxW3Observable'

  --- Returns an Observable that produces the average of all values produced by the original.
  -- @returns {Observable}
  default(function ()
    return function (self)
      return Observable.create(function(observer)
        local sum, count = 0, 0

        local function onNext(value)
          sum = sum + value
          count = count + 1
        end

        local function onError(e)
          observer:onError(e)
        end

        local function onCompleted()
          if count > 0 then
            observer:onNext(sum / count)
          end

          observer:onCompleted()
        end

        return self:subscribe(onNext, onError, onCompleted)
      end)
    end
  end);
end);
