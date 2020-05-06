WM('RxW3OperatorsZip', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local util = import 'RxW3Util'
  
  --- Runs a function each time this Observable has activity. Similar to subscribe but does not
  -- create a subscription.
  -- @arg {function=} onNext - Run when the Observable produces values.
  -- @arg {function=} onError - Run when the Observable encounters a problem.
  -- @arg {function=} onCompleted - Run when the Observable completes.
  -- @returns {Observable}
  default(function (_onNext, _onError, _onCompleted)
    _onNext = _onNext or util.noop
    _onError = _onError or util.noop
    _onCompleted = _onCompleted or util.noop

    return function (self)
      return Observable.create(function(observer)
        local function onNext(...)
          util.tryWithObserver(observer, function(...)
            _onNext(...)
          end, ...)

          return observer:onNext(...)
        end

        local function onError(message)
          util.tryWithObserver(observer, function()
            _onError(message)
          end)

          return observer:onError(message)
        end

        local function onCompleted()
          util.tryWithObserver(observer, function()
            _onCompleted()
          end)

          return observer:onCompleted()
        end

        return self:subscribe(onNext, onError, onCompleted)
      end)
    end
  end);
end);
