WM('RxW3OperatorsTakeLast', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local util = import 'RxW3Util'

  --- Returns an Observable that produces a specified number of elements from the end of a source
  -- Observable.
  -- @arg {number} count - The number of elements to produce.
  -- @returns {Observable}
  default(function (count)
    if not count or type(count) ~= 'number' then
      error('Expected a number')
    end

    return function (self)
      return Observable.create(function(observer)
        local buffer = {}

        local function onNext(...)
          table.insert(buffer, util.pack(...))
          if #buffer > count then
            table.remove(buffer, 1)
          end
        end

        local function onError(message)
          return observer:onError(message)
        end

        local function onCompleted()
          for i = 1, #buffer do
            observer:onNext(util.unpack(buffer[i]))
          end
          return observer:onCompleted()
        end

        return self:subscribe(onNext, onError, onCompleted)
      end)
    end
  end);
end);
