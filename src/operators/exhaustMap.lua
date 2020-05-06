WM('RxW3OperatorsExhaustMap', function (import, export, default)
    local util = import 'RxW3Util'
    local map = import 'RxW3OperatorsMap'
    local exhaust = import 'RxW3OperatorExhaust'
  
    --- Returns a new Observable that transform the items emitted by an Observable into Observables,
    -- then exhausts the emissions from those into a single Observable
    -- @arg {function} callback - The function to transform values from the original Observable.
    -- @returns {Observable}
    default(function (callback)
      callback = callback or util.identity
  
      return function (self)
        return self:pipe(map(callback), exhaust());
      end
    end);
  end);