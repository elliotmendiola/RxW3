WM('RxW3OperatorsSum', function (import, export, default)
  local reduce = import 'RxW3OperatorsReduce'

  --- Returns an Observable that produces a single value representing the sum of the values produced
  -- by the original.
  -- @returns {Observable}
  default(function ()
    return function (self)
      return self:pipe(reduce(function(x, y) return x + y end, 0))
    end
  end)
end);
