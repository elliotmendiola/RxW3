WM('RxW3OperatorsDelay', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local Subscription = import 'RxW3SubscriptionsSusbscription'
  local util = import 'RxW3Util'


  --- Returns a new Observable that produces the values of the original delayed by a time period.
  -- @arg {number|function} time - An amount in milliseconds to delay by, or a function which returns
  --                                this value.
  -- @arg {Scheduler} scheduler - The scheduler to run the Observable on.
  -- @returns {Observable}
  default(function (time, scheduler)
    time = type(time) ~= 'function' and util.constant(time) or time
    
    return function (self)
      return Observable.create(function(observer)
        local actions = {}

        local function delay(key)
          return function(...)
            local arg = util.pack(...)
            local handle = scheduler:schedule(function()
              observer[key](observer, util.unpack(arg))
            end, time())
            table.insert(actions, handle)
          end
        end

        local subscription = self:subscribe(delay('onNext'), delay('onError'), delay('onCompleted'))

        return Subscription.create(function()
          if subscription then subscription:unsubscribe() end
          for i = 1, #actions do
            actions[i]:unsubscribe()
          end
        end)
      end)
    end
  end);
end);
