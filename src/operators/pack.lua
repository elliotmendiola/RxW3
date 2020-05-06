WM('RxW3OperatorsPack', function (import, export, default)
  local util = import 'RxW3Util'
  local map = import 'RxW3OperatorsMap'

  --- Returns an Observable that produces the values of the original inside tables.
  -- @returns {Observable}
  default(function ()
    return function (self)
      return self:pipe(map(util.pack))
    end
  end)
end);
