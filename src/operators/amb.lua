WM('RxW3OperatorsAmb', function (import, export, default)
  local Observable = import 'RxW3Observable'

  --- Given a set of Observables, produces values from only the first one to produce a value.
  -- @arg {Observable...} observables
  -- @returns {Observable}
  local amb = function (a, b, ...)
    if not a or not b then return a end

    return function (self)
      return Observable.create(function(observer)
        local subscriptionA, subscriptionB

        local function onNextA(...)
          if subscriptionB then subscriptionB:unsubscribe() end
          observer:onNext(...)
        end

        local function onErrorA(e)
          if subscriptionB then subscriptionB:unsubscribe() end
          observer:onError(e)
        end

        local function onCompletedA()
          if subscriptionB then subscriptionB:unsubscribe() end
          observer:onCompleted()
        end

        local function onNextB(...)
          if subscriptionA then subscriptionA:unsubscribe() end
          observer:onNext(...)
        end

        local function onErrorB(e)
          if subscriptionA then subscriptionA:unsubscribe() end
          observer:onError(e)
        end

        local function onCompletedB()
          if subscriptionA then subscriptionA:unsubscribe() end
          observer:onCompleted()
        end

        subscriptionA = a:subscribe(onNextA, onErrorA, onCompletedA)
        subscriptionB = b:subscribe(onNextB, onErrorB, onCompletedB)

        return Subscription.create(function()
          subscriptionA:unsubscribe()
          subscriptionB:unsubscribe()
        end)
      end):pipe(amb(...));
    end
  end

  default(amb);
end);