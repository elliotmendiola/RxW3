WM('RxW3SchedulersTimeoutScheduler', function (import, export, default)
  local Subscription = import 'RxW3SubscriptionsSubscription'

  --- @class TimeoutScheduler
  -- @description A scheduler that uses luvit's timer library to schedule events on an event loop.
  local TimeoutScheduler = {}
  TimeoutScheduler.__index = TimeoutScheduler
  TimeoutScheduler.__tostring = util.constant('TimeoutScheduler')

  --- Creates a new TimeoutScheduler.
  -- @returns {TimeoutScheduler}
  function TimeoutScheduler.create()
    return setmetatable({}, TimeoutScheduler)
  end

  --- Schedules an action to run at a future point in time.
  -- @arg {function} action - The action to run.
  -- @arg {number=0} delay - The delay, in milliseconds.
  -- @returns {Subscription}
  function TimeoutScheduler:schedule(action, delay, ...)
    local timer = CreateTimer();

    TimerStart(timer, delay, false, action);
    return Subscription.create(function()
      DestroyTimer(timer);
    end)
  end

  default(TimeoutScheduler);
end);
