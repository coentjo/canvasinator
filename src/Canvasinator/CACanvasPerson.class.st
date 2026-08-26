Class {
	#name : 'CACanvasPerson',
	#superclass : 'Object',
	#instVars : [
		'rawData',
		'parent'
	],
	#category : 'Canvasinator',
	#package : 'Canvasinator'
}

{ #category : 'as yet unclassified' }
CACanvasPerson class >> on: personRawData withParent: aParent [
	^ self new
		rawData: personRawData;
		parent: aParent;
		yourself
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> allLepiterPages [
	^ parent allLepiterPages
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> courseId [
	^ parent courseId
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> createPage: aPageName [
	^ self lepDatabase addPage: 
		(LePage new 
			addSnippet: (LeTextSnippet new string: 'wk');
			title: aPageName;
			yourself)
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> email [
	^ rawData at: 'email' ifAbsent: 'I??????@fhict.nl'
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> grades [
	"remark: limited nr (?per_page=110)"
	| reply rawDatax|
	reply := ZnClient new
			url: 'https://fhict.instructure.com/' , 'api/v1/' 
				, 'courses/' , self courseId asString
				, '/users/', self id asString;
			headerAt: 'Authorization' put: ' Bearer ' , self token;
			get.
	rawDatax := STON fromString: reply.
	^ rawDatax collect: [ :each | CACanvasAssignment on: each ]
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> gtGradesFor: aView [
	<gtView>
	| grades |
	grades := self grades.
	^ aView columnedList
		title: 'Grades';
		priority: 9;
		items: {grades}
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> gtLiveFor: aView [
	<gtView>
	| pages |
	pages := self potentialPagesForMe.
	^ aView explicit
		title: 'Person';
		priority: 5;
		stencil: [ | vertical |
			vertical := BrVerticalPane new.
			vertical
				addChild: (BrEditorElement new
						padding: (BlInsets all: 10);
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical matchParent ];
						editor: (BrTextEditor new text: self email asRopedText)).
			vertical
				addChild: (BrEditorElement new
						padding: (BlInsets all: 10);
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical matchParent ];
						editor: (BrTextEditor new text: self id asRopedText)).
			vertical
				addChild: (BrEditorElement new
						padding: (BlInsets all: 10);
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical matchParent ];
						editor: (BrTextEditor new text: self login_id asRopedText)).
			vertical
				addChild: (BrEditorElement new
						padding: (BlInsets all: 10);
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical matchParent ];
						editor: (BrTextEditor new text: self iAccountNumber asRopedText)).
			vertical
				addChild: (BrEditorElement new
						padding: (BlInsets all: 10);
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical matchParent ];
						editor: (BrTextEditor new text: self printString asRopedText)).
			pages
				do: [ :page "				vertical addChild: Br." | 
					vertical
						addChild: (BrEditorElement new
								padding: (BlInsets all: 10);
								constraintsDo: [ :c | 
									c horizontal matchParent.
									c vertical matchParent ];
								editor: (BrTextEditor new text: page printString asRopedText)) ].
			vertical ];
		actionButtonIcon: BrGlamorousVectorIcons browse
			tooltip: 'open page'
			action: [ :aButton | aButton phlow spawnTool: pages first ];
		actionButtonIcon: BrGlamorousVectorIcons add
			tooltip: 'create page'
			action: [ :aButton | 
				pages
					ifEmpty: [ | pageName |
						self inform: 'Page to be created'.
						pageName := self printString.
						Clipboard clipboardText: pageName ]
					ifNotEmpty: [ aButton phlow spawnTool: pages first ] ]
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> gtPagesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Pages';
		priority: 4;
		items: (self potentialPagesForMe ifEmpty: [ {self createPage: self printString} ]);
		column: 'Pages'
			text: [ :each | 
				| color page |
				page := each.
				color := (page title endsWith: 'coachee' caseSensitive: false)
						ifTrue: [ Color orange ]
						ifFalse: [ Color gray ].
				page asString asRopedText foreground: color	"?title" ];
		actionButtonLabel: 'FP'
			tooltip: 'feedpulse'
			action: [ :aButton "aButton phlow spawnTool: pages first" | 
				Clipboard clipboardText: 'wk01 - Coen'.
				WebBrowser
					openOn: 'https://fhict.instructure.com/courses/' , self courseId asString
							, '/external_tools/1067' ]
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> iAccountNumber [
	| iAccount |
	iAccount := rawData at: 'login_id' ifAbsent: 'Ixxxxxx@fhict.nl'.
	^ ((iAccount splitOn: '@') at: 1).
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> id [
	^ rawData at: 'id'
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> isTeacher [
	^ self iAccountNumber asLowercase beginsWith: 'i8'
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> lepDatabase [
	^ parent lepDatabase
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> login_id [
	^ rawData at: 'login_id' ifAbsent: '????'
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> parent: aParent [ 
	parent := aParent
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> potentialPagesForMe [

	| onPcn onNamePart |
	"self potentialPagesOfWhichTitleContains: self iAccountNumber"
	onPcn := self potentialPagesOfWhichTitleContains: self iAccountNumber.
	onNamePart := self potentialPagesOfWhichTitleContains: (self sortable_name first: 7).
	^ (onPcn collect: [ : each | each ])
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> potentialPagesOfWhichTitleContains: aPartOfAPageTitle [
	^ self allLepiterPages select: [ :page | page title matchesRegex: '.*',aPartOfAPageTitle,'.*' ]
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> printOn: aStream [
	aStream
		nextPutAll: self semesterAanduiding	"semester-aanduiding: YYYY02 of YYYY08nj (nj: najaar)";
		nextPutAll: '.';
		nextPutAll: self sortable_name;
		nextPutAll: self iAccountNumber
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> rawData: personRawData [ 
	rawData := personRawData
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> semesterAanduiding [
	^ '202608nj'
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> sortByThis [
	| pages |
	pages := self potentialPagesForMe.	"Page with 'coachee' in title should be on top, 
	next: Person with a Page should be at the top"
	^ (pages ifEmpty: ['z'] ifNotEmpty: [(pages first title endsWith: 'coachee') ifTrue: 'c' ifFalse: 'n'])
		, (pages size > 0 ifTrue: [ '' ] ifFalse: [ 'zzzz' ]) 
		, self sortable_name
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> sortByThisUsing: aPagesCollection [
	| pages |
	pages := self potentialPagesForMe.
	"Person with a Page should be at the top"
	^ (aPagesCollection size > 0 ifTrue: [''] ifFalse: ['zzzz']), self sortable_name
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> sortable_name [
	^ rawData at: 'sortable_name'
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> token [
	^ parent token
]
