WM('RxW3OperatorsStartWith', function (import, export, default)
  local Observable = import 'RxW3Observable'
  local util = import 'RxW3Util'

--- Returns a new Observable that produces the specified values followed by all elements produced by
-- the source Observable.
-- @arg {*...} values - The values to produce before the Observable begins producing values
--                      normally.
-- @returns {Observable}
  default(function (...)
    local values = util.pack(...)

    return function (self)
      return Observable.create(function(observer)
        observer:onNext(util.unpack(values))
        return self:subscribe(observer)
      end)
    end
  end);
end);
