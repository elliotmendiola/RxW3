WM('RxW3OperatorsPartition', function (import, export, default)

  --- Returns two Observables: one that produces values for which the predicate returns truthy for,
  -- and another that produces values for which the predicate returns falsy.
  -- @arg {function} predicate - The predicate used to partition the values.
  -- @returns {Observable}
  -- @returns {Observable}
  default(function (predicate)
    return function (self)
      return self:filter(predicate), self:reject(predicate)
    end
  end)
end);
