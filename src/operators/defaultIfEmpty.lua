WM('RxW3OperatorsDefaultIfEmpty', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local util = import 'RxW3Util'

  --- Returns a new Observable that produces a default set of items if the source Observable produces
  -- no values.
  -- @arg {*...} values - Zero or more values to produce if the source completes without emitting
  --                      anything.
  -- @returns {Observable}
  default(function (...)
    local defaults = util.pack(...)

    return function (self)
      return Observable.create(function(observer)
        local hasValue = false

        local function onNext(...)
          hasValue = true
          observer:onNext(...)
        end

        local function onError(e)
          observer:onError(e)
        end

        local function onCompleted()
          if not hasValue then
            observer:onNext(util.unpack(defaults))
          end

          observer:onCompleted()
        end

        return self:subscribe(onNext, onError, onCompleted)
      end)
    end
  end);
end);
