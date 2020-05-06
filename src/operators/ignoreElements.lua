WM('RxW3OperatorsIgnoreElements', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local util = import 'RxW3Util'

  --- Returns an Observable that terminates when the source terminates but does not produce any
  -- elements.
  -- @returns {Observable}
  default(function ()
    return function (self)
      return Observable.create(function(observer)
        local function onError(message)
          return observer:onError(message)
        end

        local function onCompleted()
          return observer:onCompleted()
        end

        return self:subscribe(nil, onError, onCompleted)
      end)
    end
  end);
end);
