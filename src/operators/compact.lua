WM('RxW3OperatorsCompact', function (import, export, default)
  local util = import 'RxW3Util'
  local filter = import 'RxW3OperatorsFilter'


  --- Returns a new Observable that produces the values of the first with falsy values removed.
  -- @returns {Observable}
  default(function ()
    return function (self)
      return self:pipe(filter(util.identity))
    end
  end);
end);
