WM('RxW3OperatorsExhaust', function (import, export, default)
    local Observable = import 'RxW3Observable'
    local map = import 'RxW3OperatorsMap'
  
    --- Returns a new Observable that transform the items emitted by an Observable into Observables,
    -- then concats the emissions from those into a single Observable
    -- @arg {function} callback - The function to transform values from the original Observable.
    -- @returns {Observable}
    default(function (callback)
      return function (self)
        return Observable.create(function(observer)
          local innerSubscription
          local sources = {};
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

          local function concatNext()
            if (#sources > 0) then
                innerSubscription = table.remove(sources, 1):subscribe(onNext, onError, concatNext);
            else
                innerSubscription = nil;
            end
            if (completed and not innerSubscription) then
                return observer:onCompleted()
            end
          end
  
          local function concat(source)
            if not innerSubscription then
                innerSubscription = source:subscribe(onNext, onError, concatNext);
            else
                table.insert(sources, source);
            end
          end
  
          local subscription = self:pipe(map(callback)):subscribe(concat, onError, onCompleted)
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