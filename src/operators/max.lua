WM('RxW3OperatorsMax', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local reduce = import 'RxW3OperatorsReduce'


  --- Returns a new Observable that produces the maximum value produced by the original.
  -- @returns {Observable}
  default(function ()
    return function (self)
      return self:pipe(reduce(math.max))
    end
  end)
end);
