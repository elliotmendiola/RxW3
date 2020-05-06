WM('RxW3OperatorsFirst', function (import, export, default)
  local take = import 'RxW3OperatorsTake'

  --- Returns a new Observable that only produces the first result of the original.
  -- @returns {Observable}
  default(function ()
    return function (self)
      return self:pipe(take(1))
    end
  end);
end);
