WM('RxW3OperatorsExhaust', function (import, export, default)
    local Observable = import 'RxW3Observable'
  
    --- Given an Observable that produces Observables, returns an Observable that produces the values
    -- produced by the last produced Observable while none was subscribed to.
    -- @returns {Observable}
    default(function ()
      return function (self)
        return Observable.create(function(observer)
          local innerSubscription
          local completed = false;
  
          local function onNext(...)
            return observer:onNext(...)
          end
  
          local function onError(message)
            return observer:onError(message)
          end
  
          local function onCompleted()
            completed = true;
          end

          local function exhausted()
            innerSubscription = nil;
            if (completed) then
                return observer:onCompleted()
            end
          end
  
          local function exhaust(source)
            if not innerSubscription then
                innerSubscription = source:subscribe(onNext, onError, exhausted);
            end
          end
  
          local subscription = self:subscribe(exhaust, onError, onCompleted)
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