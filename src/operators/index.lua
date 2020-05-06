WM('RxW3Operators', function (import, export, default)
    local all = import 'RxW3OperatorsAll'
    local amb = import 'RxW3OperatorsAmb'
    local average = import 'RxW3OperatorsAverage'
    local buffer = import 'RxW3OperatorsBuffer'
    local catch = import 'RxW3OperatorsCatch'
    local combineLatest = import 'RxW3OperatorsCombineLatest'
    local compact = import 'RxW3OperatorsCompact'
    local concat = import 'RxW3OperatorsConcat'
    local concatMap = import 'RxW3OperatorsConcatMap'
    local contains = import 'RxW3OperatorsContains'
    local count = import 'RxW3OperatorsCount'
    local debounce = import 'RxW3OperatorsDebounce'
    local defaultIfEmpty = import 'RxW3OperatorsDefaultIfEmpty'
    local delay = import 'RxW3OperatorsDelay'
    local distinct = import 'RxW3OperatorsDistinct'
    local distinctUntilChanged = import 'RxW3OperatorsDistinctUntilChanged'
    local elementAt = import 'RxW3OperatorsElementAt'
    local exhaust = import 'RxW3OperatorsExhaust'
    local exhaustMap = import 'RxW3OperatorsExhaustMap'
    local filter = import 'RxW3OperatorsFilter'
    local find = import 'RxW3OperatorsFind'
    local first = import 'RxW3OperatorsFirst'
    local flatMap = import 'RxW3OperatorsFlatMap'
    local flatMapLatest = import 'RxW3OperatorsFlatMapLatest'
    local flatten = import 'RxW3OperatorsFlatten'
    local ignoreElements = import 'RxW3OperatorsIgnoreElements'
    local last = import 'RxW3OperatorsLast'
    local map = import 'RxW3OperatorsMap'
    local max = import 'RxW3OperatorsMax'
    local merge = import 'RxW3OperatorsMerge'
    local min = import 'RxW3OperatorsMin'
    local pack = import 'RxW3OperatorsPack'
    local partition = import 'RxW3OperatorsPartition'
    local pluck = import 'RxW3OperatorsPluck'
    local reduce = import 'RxW3OperatorsReduce'
    local reject = import 'RxW3OperatorsReject'
    local retry = import 'RxW3OperatorsRetry'
    local sample = import 'RxW3OperatorsSample'
    local scan = import 'RxW3OperatorsScan'
    local skip = import 'RxW3OperatorsSkip'
    local skipLast = import 'RxW3OperatorsSkipLast'
    local skipUntil = import 'RxW3OperatorsSkipUntil'
    local skipWhile = import 'RxW3OperatorsSkipWhile'
    local startWith = import 'RxW3OperatorsStartWith'
    local sum = import 'RxW3OperatorsSum'
    local switch = import 'RxW3OperatorsSwitch'
    local switchMap = import 'RxW3OperatorsSwitchMap'
    local take = import 'RxW3OperatorsTake'
    local takeLast = import 'RxW3OperatorsTakeLast'
    local takeUntil = import 'RxW3OperatorsTakeUntil'
    local takeWhile = import 'RxW3OperatorsTakeWhile'
    local tap = import 'RxW3OperatorsTap'
    local unpack = import 'RxW3OperatorsUnpack'
    local unwrap = import 'RxW3OperatorsUnwrap'
    local window = import 'RxW3OperatorsWindow'
    local with = import 'RxW3OperatorsWith'
    local zip = import 'RxW3OperatorsZip'
    
    export('All', all)
    export('Amb', amb)
    export('Average', average)
    export('Buffer', buffer)
    export('Catch', catch)
    export('CombineLatest', combineLatest)
    export('Compact', compact)
    export('Concat', concat)
    export('ConcatMap', concatMap)
    export('Contains', contains)
    export('Count', count)
    export('Debounce', debounce)
    export('DefaultIfEmpty', defaultIfEmpty)
    export('Delay', delay)
    export('Distinct', distinct)
    export('DistinctUntilChanged', distinctUntilChanged)
    export('ElementAt', elementAt)
    export('Exhaust', exhaust)
    export('ExhaustMap', exhaustMap)
    export('Filter', filter)
    export('Find', find)
    export('First', first)
    export('FlatMap', flatMap)
    export('FlatMapLatest', flatMapLatest)
    export('Flatten', flatten)
    export('IgnoreElements', ignoreElements)
    export('Last', last)
    export('Map', map)
    export('Max', max)
    export('Merge', merge)
    export('Min', min)
    export('Pack', pack)
    export('Partition', partition)
    export('Pluck', pluck)
    export('Reduce', reduce)
    export('Reject', reject)
    export('Retry', retry)
    export('Sample', sample)
    export('Scan', scan)
    export('Skip', skip)
    export('SkipLast', skipLast)
    export('SkipUntil', skipUntil)
    export('SkipWhile', skipWhile)
    export('StartWith', startWith)
    export('Sum', sum)
    export('Switch', switch)
    export('SwitchMap', switchMap)
    export('Take', take)
    export('TakeLast', takeLast)
    export('TakeUntil', takeUntil)
    export('TakeWhile', takeWhile)
    export('Tap', tap)
    export('Unpack', unpack)
    export('Unwrap', unwrap)
    export('Window', window)
    export('With', with)
    export('Zip', zip)
    
    default({
        ['All'] = all,
        ['Amb'] = amb,
        ['Average'] = average,
        ['Buffer'] = buffer,
        ['Catch'] = catch,
        ['CombineLatest'] = combineLatest,
        ['Compact'] = compact,
        ['Concat'] = concat,
        ['ConcatMap'] = concatMap,
        ['Contains'] = contains,
        ['Count'] = count,
        ['Debounce'] = debounce,
        ['DefaultIfEmpty'] = defaultIfEmpty,
        ['Delay'] = delay,
        ['Distinct'] = distinct,
        ['DistinctUntilChanged'] = distinctUntilChanged,
        ['ElementAt'] = elementAt,
        ['Exhaust'] = exhaust,
        ['ExhaustMap'] = exhaustMap,
        ['Filter'] = filter,
        ['Find'] = find,
        ['First'] = first,
        ['FlatMap'] = flatMap,
        ['FlatMapLatest'] = flatMapLatest,
        ['Flatten'] = flatten,
        ['IgnoreElements'] = ignoreElements,
        ['Last'] = last,
        ['Map'] = map,
        ['Max'] = max,
        ['Merge'] = merge,
        ['Min'] = min,
        ['Pack'] = pack,
        ['Partition'] = partition,
        ['Pluck'] = pluck,
        ['Reduce'] = reduce,
        ['Reject'] = reject,
        ['Retry'] = retry,
        ['Sample'] = sample,
        ['Scan'] = scan,
        ['Skip'] = skip,
        ['SkipLast'] = skipLast,
        ['SkipUntil'] = skipUntil,
        ['SkipWhile'] = skipWhile,
        ['StartWith'] = startWith,
        ['Sum'] = sum,
        ['Switch'] = switch,
        ['SwitchMap'] = switchMap,
        ['Take'] = take,
        ['TakeLast'] = takeLast,
        ['TakeUntil'] = takeUntil,
        ['TakeWhile'] = takeWhile,
        ['Tap'] = tap,
        ['Unpack'] = unpack,
        ['Unwrap'] = unwrap,
        ['Window'] = window,
        ['With'] = with,
        ['Zip'] = zip
    });
end)
