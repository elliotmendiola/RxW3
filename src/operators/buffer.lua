WM('RxW3OperatorsBuffer', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local util = import 'RxW3Util'

  --- Returns an Observable that buffers values from the original and produces them as multiple
  -- values.
  -- @arg {number} size - The size of the buffer.
  default(function (size)
    if not size or type(size) ~= 'number' then
      error('Expected a number')
    end

    return function (self)
      return Observable.create(function(observer)
        local buffer = {}

        local function emit()
          if #buffer > 0 then
            observer:onNext(util.unpack(buffer))
            buffer = {}
          end
        end

        local function onNext(...)
          local values = {...}
          for i = 1, #values do
            table.insert(buffer, values[i])
            if #buffer >= size then
              emit()
            end
          end
        end

        local function onError(message)
          emit()
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