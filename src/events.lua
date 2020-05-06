WM('RxW3Events', function (import, export, default)
    export('AnyUnit', 'EVENT_TYPE_ANY_UNIT');
    default({
        ['EVENT_TYPE_ANY_UNIT'] = {
            ['init'] = TriggerRegisterAnyUnitEventBJ,
            ['args'] = { [0] = GetTriggerUnit, [1] = GetAbilityEffectById }
        },
        ['EVENT_TYPE_DEATH_EVENT'] = {
            ['init'] = TriggerRegisterDeathEvent,
            ['args'] = { [0] = GetTriggerUnit }
        }
    });
end)
