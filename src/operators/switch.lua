WM('RxW3OperatorsSwitch', function (import, export, default)
  local Observable = import 'RxW3Observable'

  --- Given an Observable that produces Observables, returns an Observable that produces the values
  -- produced by the most recently produced Observable.
  -- @returns {Observable}
  default(function ()
    return function (self)
      return Observable.create(function(observer)
        local innerSubscription

        local function onNext(...)
          return observer:onNext(...)
        end

        local function onError(message)
          return observer:onError(message)
        end

        local function onCompleted()
          return observer:onCompleted()
        end

        local function switch(source)
          if innerSubscription then
            innerSubscription:unsubscribe()
          end

          innerSubscription = source:subscribe(onNext, onError, nil)
        end

        local subscription = self:subscribe(switch, onError, onCompleted)
        return Subscription.create(function()
          if innerSubscription then
            innerSubscription:unsubscribe()
          end

          if subscription then
            subscription:unsubscribe()
          end
        end)
      end)
    end
  end);
end);