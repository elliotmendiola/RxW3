WM('RxW3Subjects', function (import, export, default)
    local subject = import 'RxW3SubjectsSubject';
    local replaySubject = import 'RxW3SubjectsReplaySubject';
    local behaviorSubject = import 'RxW3SubjectsBehaviorSubject';
    local asyncSubject = import 'RxW3SubjectsAsyncSubject';

    export('Subject', subject);
    export('ReplaySubject', replaySubject);
    export('BehaviorSubject', behaviorSubject);
    export('AsyncSubject', asyncSubject);
    default({
        ['Subject'] = subject,
        ['ReplaySubject'] = replaySubject,
        ['BehaviorSubject'] = behaviorSubject,
        ['AsyncSubject'] = asyncSubject
    })
end)