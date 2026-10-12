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
	^ aView columnedList
		title: 'Todos';
		priority: 9;
		items: [self todosSorted ];
		column: 'name' text: [ :page | 
			| parts part1 partsWithColor result |
			parts := page title splitOn: $. .
			part1 := (parts at: 1) asRopedText background: Color orange .
"some gefrunnik... could have been nice..."
			"parts doWithIndex: [ :each :index | 
				color := Color lightGray.
				(each matchesRegexIgnoringCase: '.*todo.*') 
					ifTrue: [color := Color yellow]]."
			partsWithColor := parts collectWithIndex: [ :each :index |
				| color |
				color := Color white.
				(each matchesRegexIgnoringCase: '.*todo.*') 
					ifTrue: [color := Color orange].
				each -> color
			].
			result := ('-' asRopedText "background: Color yellow"). 
			partsWithColor do: [ :assoc | result := result, '.' asRopedText, (assoc key asRopedText background: assoc value) ]
			.
			result
			"$. asRopedText join:
			(partsWithColor collect: [ :assoc | 
				assoc key asRopedText background: assoc value
			])"
			"part1, ' - ' asRopedText, ($. join: parts) asRopedText background: color"]
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
