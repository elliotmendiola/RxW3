local Observable = importWM 'RxW3Observable'

Observable.wrap = Observable.buffer
Observable['repeat'] = Observable.replicate
