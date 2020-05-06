# RxWarcraft3

This is a Warcraft 3 world editor implementation of RxLua originally created by bjornbytes at https://github.com/bjornbytes/RxLua

## Why?

Warcraft 3 like most web based systems is event based.  Most moddern frameworks for developing web products (Angular/React/etc) use Reactive Extensions as a way of developing that fits the asyncronous event based design better.  This library can hopefully make writing Warcraft 3 custom scripts and triggers considerably easier.

### Examples

Kill unit when casting animate dead

```Lua
function StartEffectOfAbility()
    local trigger = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trigger, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddAction(trigger, function()
        local caster = GetTriggerUnit() --GetTriggerUnit references the Triggering Unit
        if GetSpellAbilityId() == FourCC('AUan') then --If the ability being cast is equal to Animate Dead
            KillUnit(caster) --Kill the triggering unit (casting unit) to show that it worked
        end
    end)
end
```

This is the same script but using Rx instead to achieve the same functionality

```Lua
local Observable = importWM('RxW3', 'Observable');
local filter = importWM('RxW3', 'Operators/Filter');
local EVENT_TYPE_ANY_UNIT = importWM('RxW3', 'Events/AnyUnit');

Observable.fromEvent(EVENT_TYPE_ANY_UNIT, EVENT_PLAYER_UNIT_SPELL_EFFECT):pipe(
    filter(function (args) return args[1] == FourCC('AUan') end), --Filter for the animate dead ability (event args used to get spell ability id instead)
):subscribe(function (args) KillUnit(args[0]) end); --Kill the triggering unit (casting unit) to show it worked (event args used to get caster instead)
```