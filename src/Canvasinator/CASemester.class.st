Class {
	#name : 'CASemester',
	#superclass : 'CABase',
	#instVars : [
		'name',
		'fromSnippet',
		'canvasCourses',
		'weekday'
	],
	#category : 'Canvasinator',
	#package : 'Canvasinator'
}

{ #category : 'accessing' }
CASemester >> addCanvasCourse: aCourseId day: aString for: aString1 [ 
	| course |
	course := (CACanvasCourse courseId: aCourseId fromSnippet: fromSnippet)
		weekday: aString; 
		yourself.
	self canvasCourses add: course

]

{ #category : 'accessing' }
CASemester >> addCanvasCourse: aCourseId for: aString [ 
	self canvasCourses add: (CACanvasCourse courseId: aCourseId fromSnippet: fromSnippet)
]

{ #category : 'as yet unclassified' }
CASemester >> allPages [
	"SHOULD BE DONE NICER (but not now)"
	| allPages |
	allPages := OrderedCollection new.
	fromSnippet database parent databases do: [ :db |
		allPages addAll: db pages
	].
	^ allPages
]

{ #category : 'accessing' }
CASemester >> canvasCourses [
	^canvasCourses ifNil: [ canvasCourses := OrderedCollection new]
]

{ #category : 'as yet unclassified' }
CASemester >> contextName [
	^ self printString asRopedText background: self defaultColor
]

{ #category : 'as yet unclassified' }
CASemester >> defaultColor [
	^ Color yellow
]

{ #category : 'accessing' }
CASemester >> fromSnippet: aSnippet [ 
	"store snippet for now, although at this moment I only need the database, which I can get from this snippet"
	fromSnippet := aSnippet
]

{ #category : 'as yet unclassified' }
CASemester >> gtCoursesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Courses';
		priority: 5;
		items: canvasCourses;
		column: 'day'  text: [ :each | each weekday ] weight: 0.1;
		column: 'name' text: [ :each | each printString ]

]

{ #category : 'as yet unclassified' }
CASemester >> gtDirectoriesFor: aView [
	<gtView>
	^ aView forward
		title: 'Dirs';
		priority: 8;
		object: [ | buf |
			buf := 'cohort'.
			self contextName do: [ :char |
				char isDigit ifTrue: [ buf := buf, char asString ]].
				FileLocator home / buf];
		view: #gtTreeFor:

]

{ #category : 'as yet unclassified' }
CASemester >> gtLiveFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Live';
		priority: 4;
		items: self canvasCourses , '-' , self todos sorted;
		column: 'key'
			text: [ :each | 
				[ each contextName ]
					onErrorDo: [ '-' asRopedText background: Color gray ] ]
			weight: 0.1;
		column: 'name' text: [ :each | each asString ]
]

{ #category : 'as yet unclassified' }
CASemester >> gtPagesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Pages';
		priority: 8;
		items: self relatedPages; 
		column: 'name' text: [ :each | each asString ]

]

{ #category : 'as yet unclassified' }
CASemester >> gtTodosFor: aView [
	<gtView>
	| thisWk currentDay currentDayString |
	thisWk := 'wk07'.
	currentDay := Date today weekdayIndex - 1.
	currentDayString := 'd0' , currentDay asString.
	^ aView columnedList
		title: 'Todos';
		priority: 10;
		items: [ self todosSorted ];
		column: 'co'
			text: [ :page | (page title splitOn: $.) at: 1 ]
			width: 55;
		column: 'wk'
			text: [ :page | 
				| text |
				text := (self titleParts: page) at: 2.
				((text splitOn: $_) at: 1) asRopedText
					background: ((text matchesRegexIgnoringCase: thisWk , '.*')
							ifTrue: [ Color purple muchLighter ]
							ifFalse: [ Color gray muchLighter ]) ]
			width: 55;
		column: 'd'
			text: [ :page | 
				| text dayString |
				text := (page title splitOn: $.) at: 2 ifAbsent: 'x'.
				dayString := (text splitOn: $_) at: 2 ifAbsent: '-'.
				dayString asRopedText
					background: ((text matchesRegexIgnoringCase: thisWk , '.*')
							ifTrue: [ currentDayString = dayString
									ifTrue: [ Color green lighter ]
									ifFalse: [ Color purple muchLighter ] ]
							ifFalse: [ Color gray muchLighter ]) ]
			width: 65;
		column: 'name'
			text: [ :page | 
				| parts part1 partsWithColor result |
				parts := page title splitOn: $..
				part1 := (parts at: 1) asRopedText background: Color orange.
				partsWithColor := parts
						collectWithIndex: [ :each :index | 
							| color |
							color := Color white.
							(each matchesRegexIgnoringCase: '.*todo.*')
								ifTrue: [ color := Color orange muchLighter ].
							each -> color ].
				result := '-' asRopedText.	"background: Color yellow"
				partsWithColor
					do: [ :assoc | 
						result := result , '.' asRopedText
								, (assoc key asRopedText background: assoc value) ].
				result ]
]

{ #category : 'as yet unclassified' }
CASemester >> name [
	^ name
]

{ #category : 'accessing' }
CASemester >> name: aString [ 
	name := aString
]

{ #category : 'as yet unclassified' }
CASemester >> pages [
	^ fromSnippet database pages
]

{ #category : 'as yet unclassified' }
CASemester >> printOn: aStream [
	aStream nextPutAll: name
]

{ #category : 'as yet unclassified' }
CASemester >> relatedPages [
	^ self pages select: [ :page | page title matchesRegexIgnoringCase: '.*', self contextName, '.*' ]
]

{ #category : 'as yet unclassified' }
CASemester >> titleParts: page [
	^ page title splitOn: $.
]

{ #category : 'as yet unclassified' }
CASemester >> todos [
	| pages |
	pages := self allPages.
	^ (pages select: [ :page | page title matchesRegexIgnoringCase: '.*todo.*' ])
	, (pages select: [ :page | page title matchesRegexIgnoringCase: '.*FP.*' ])
	, (pages select: [ :page | page title matchesRegexIgnoringCase: '.*ongoing.*' ])
]

{ #category : 'as yet unclassified' }
CASemester >> todosSorted [
	^ self todos sort: [ :a :b | a sortingIndex < b sortingIndex ]
]

{ #category : 'as yet unclassified' }
CASemester >> weekday [
	^ weekday
]

{ #category : 'accessing' }
CASemester >> weekday: aString [ 
	weekday := aString
]
