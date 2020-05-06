WM('RxW3OperatorsSwitchMap', function (import, export, default)
    local map = import 'RxW3OperatorsMap'
    local switch = import 'RxW3OperatorsSwitch'
  
    --- Returns an Observable that produces a single value representing the sum of the values produced
    -- by the original.
    -- @returns {Observable}
    default(function (callback)
      return function (self)
        return self:pipe(map(callback), switch())
      end
    end)
  end);
  