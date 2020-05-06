WM('RxW3OperatorsZip', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local util = import 'RxW3Util'

  --- Returns a new Observable that only produces the last result of the original.
  -- @returns {Observable}
  function Observable:last()
    return Observable.create(function(observer)
      local value
      local empty = true

      local function onNext(...)
        value = {...}
        empty = false
      end

      local function onError(e)
        return observer:onError(e)
      end

      local function onCompleted()
        if not empty then
          observer:onNext(util.unpack(value or {}))
        end

        return observer:onCompleted()
      end

      return self:subscribe(onNext, onError, onCompleted)
    end)
  end
end);
