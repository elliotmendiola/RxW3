WM('RxW3OperatorsFlatMapLatest', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local Subscription = import 'RxW3SubscriptionsSubscription'
  local util = import 'RxW3Util'


  --- Returns a new Observable that uses a callback to create Observables from the values produced by
  -- the source, then produces values from the most recent of these Observables.
  -- @arg {function=identity} callback - The function used to convert values to Observables.
  -- @returns {Observable}
  default(function (callback)
    callback = callback or util.identity
    return function (self)
      return Observable.create(function(observer)
        local innerSubscription

        local function onNext(...)
          observer:onNext(...)
        end

        local function onError(e)
          return observer:onError(e)
        end

        local function onCompleted()
          return observer:onCompleted()
        end

        local function subscribeInner(...)
          if innerSubscription then
            innerSubscription:unsubscribe()
          end

          return util.tryWithObserver(observer, function(...)
            innerSubscription = callback(...):subscribe(onNext, onError)
          end, ...)
        end

        local subscription = self:subscribe(subscribeInner, onError, onCompleted)
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
