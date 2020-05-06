WM('RxW3OperatorsSkipWhile', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local util = import 'RxW3Util'


  --- Returns a new Observable that skips elements until the predicate returns falsy for one of them.
  -- @arg {function} predicate - The predicate used to continue skipping values.
  -- @returns {Observable}
  default(function (predicate)
    predicate = predicate or util.identity

    return function (self)
      return Observable.create(function(observer)
        local skipping = true

        local function onNext(...)
          if skipping then
            util.tryWithObserver(observer, function(...)
              skipping = predicate(...)
            end, ...)
          end

          if not skipping then
            return observer:onNext(...)
          end
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
