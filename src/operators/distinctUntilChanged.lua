WM('RxW3OperatorsDistinctUntilChanged', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local util = import 'RxW3Util'

  --- Returns an Observable that only produces values from the original if they are different from
  -- the previous value.
  -- @arg {function} comparator - A function used to compare 2 values. If unspecified, == is used.
  -- @returns {Observable}
  default(function (comparator)
    comparator = comparator or util.eq

    return function (self)
      return Observable.create(function(observer)
        local first = true
        local currentValue = nil

        local function onNext(value, ...)
          local values = util.pack(...)
          util.tryWithObserver(observer, function()
            if first or not comparator(value, currentValue) then
              observer:onNext(value, util.unpack(values))
              currentValue = value
              first = false
            end
          end)
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
