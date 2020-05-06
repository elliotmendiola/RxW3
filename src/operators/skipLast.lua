WM('RxW3OperatorsSkipLast', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local util = import 'RxW3Util'

  --- Returns an Observable that omits a specified number of values from the end of the original
  -- Observable.
  -- @arg {number} count - The number of items to omit from the end.
  -- @returns {Observable}
  default(function (count)
    if not count or type(count) ~= 'number' then
      error('Expected a number')
    end

    return function (self)
      local buffer = {}
      return Observable.create(function(observer)
        local function emit()
          if #buffer > count and buffer[1] then
            local values = table.remove(buffer, 1)
            observer:onNext(util.unpack(values))
          end
        end

        local function onNext(...)
          emit()
          table.insert(buffer, util.pack(...))
        end

        local function onError(message)
          return observer:onError(message)
        end

        local function onCompleted()
          emit()
          return observer:onCompleted()
        end

        return self:subscribe(onNext, onError, onCompleted)
      end)
    end
  end);
end);
