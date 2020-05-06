WM('RxW3OperatorsFlatMap', function (import, export, default)
  local util = import 'RxW3Util'
  local map = import 'RxW3OperatorsMap'
  local flatten = import 'RxW3OperatorFlatten'

  --- Returns a new Observable that transform the items emitted by an Observable into Observables,
  -- then flatten the emissions from those into a single Observable
  -- @arg {function} callback - The function to transform values from the original Observable.
  -- @returns {Observable}
  default(function (callback)
    callback = callback or util.identity

    return function (self)
      return self:pipe(map(callback), flatten());
    end
  end);
end);