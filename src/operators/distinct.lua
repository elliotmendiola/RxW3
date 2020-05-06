WM('RxW3OperatorsDistinct', function (import, export, default)
  local Observable = import 'RxW3Observable'

  --- Returns a new Observable that produces the values from the original with duplicates removed.
  -- @returns {Observable}
  default(function ()
    return function (self)
      return Observable.create(function(observer)
        local values = {}

        local function onNext(x)
          if not values[x] then
            observer:onNext(x)
          end

          values[x] = true
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
