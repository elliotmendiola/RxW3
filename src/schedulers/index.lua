WM('RxW3Schedulers', function (import, export, default)
    local timeoutScheduler = import 'RxW3SchedulersTimeoutScheduler';
    local immediateScheduler = import 'RxW3SchedulersImmediateScheduler';
    local cooperativeScheduler = import 'RxW3SchedulersCooperativeScheduler';

    export('TimeoutScheduler', timeoutScheduler);
    export('ImmediateScheduler', immediateScheduler);
    export('CooperativeScheduler', cooperativeScheduler);
    default({
        ['TimeoutScheduler'] = timeoutScheduler,
        ['ImmediateScheduler'] = immediateScheduler,
        ['CooperativeScheduler'] = cooperativeScheduler
    })
end);
