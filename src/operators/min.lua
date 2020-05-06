WM('RxW3OperatorsZip', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local util = import 'RxW3Util'
  local reduce = import 'RxW3OperatorsReduce'

  --- Returns a new Observable that produces the minimum value produced by the original.
  -- @returns {Observable}
  default(function ()
    return function (self)
      return self:pipe(reduce(math.min))
    end
  end)
end);
