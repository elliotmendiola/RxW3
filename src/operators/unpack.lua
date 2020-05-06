WM('RxW3OperatorsUnpack', function (import, export, default)
  local util = import 'RxW3Util'
  local map = import 'RxW3OperatorsMap'

  --- Returns an Observable that unpacks the tables produced by the original.
  -- @returns {Observable}
  default(function ()
    return self:pipe(map(util.unpack))
  end);
end);
