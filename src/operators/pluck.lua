WM('RxW3OperatorsPluck', function (import, export, default)
  local Observable = import 'RxW3Observable'

  --- Returns a new Observable that produces values computed by extracting the given keys from the
  -- tables produced by the original.
  -- @arg {string...} keys - The key to extract from the table. Multiple keys can be specified to
  --                         recursively pluck values from nested tables.
  -- @returns {Observable}
  local pluck = function (key, ...)
    return function (self)
      if not key then return self end

      if type(key) ~= 'string' and type(key) ~= 'number' then
        return Observable.throw('pluck key must be a string')
      end

      return Observable.create(function(observer)
        local function onNext(t)
          return observer:onNext(t[key])
        end

        local function onError(e)
          return observer:onError(e)
        end

        local function onCompleted()
          return observer:onCompleted()
        end

        return self:subscribe(onNext, onError, onCompleted)
      end):pipe(pluck(...));
    end
  end
  default(pluck);
end);
