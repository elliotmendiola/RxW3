WM('RxW3OperatorsConcat', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local util = import 'RxW3Util'

  --- Returns a new Observable that produces the values produced by all the specified Observables in
  -- the order they are specified.
  -- @arg {Observable...} sources - The Observables to concatenate.
  -- @returns {Observable}
  local concat = function (other, ...)
    if not other then return self end

    local others = {...}

    return function (self)
      return Observable.create(function(observer)
        local function onNext(...)
          return observer:onNext(...)
        end

        local function onError(message)
          return observer:onError(message)
        end

        local function onCompleted()
          return observer:onCompleted()
        end

        local function chain()
          return other:pipe(concat(util.unpack(others))):subscribe(onNext, onError, onCompleted)
        end

        return self:subscribe(onNext, onError, chain)
      end)
    end
  end

  default(concat);
end);
