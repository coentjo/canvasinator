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
CACanvasPerson >> allPages [
	^ parent allPages
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> email [
	^ rawData at: 'email' ifAbsent: 'I??????@fhict.nl'
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
			self inform: pages size asString.
			pages
				do: [  "				vertical addChild: Br.":page | 
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
			action: [ :aButton | aButton phlow spawnTool: pages first ]
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> gtPagesFor: aView [
	<gtView>
	^ aView list
		title: 'Pages';
		priority: 7;
		items: self potentialPagesForMe 
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> iAccountNumber [
	| iAccount |
	iAccount := rawData at: 'login_id' ifAbsent: 'I??????@fhict.nl'.
	^ ((iAccount splitOn: '@') at: 1).
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
	^ self potentialPagesOfWhichTitleContains: self iAccountNumber
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> potentialPagesOfWhichTitleContains: aPartOfAPageTitle [
	self inform: self allPages size asString .
	^ self allPages select: [ :page | page title matchesRegex: '.*',aPartOfAPageTitle,'.*' ]
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> printOn: aStream [
	aStream
		nextPutAll: self iAccountNumber;
		nextPutAll: '.';
		nextPutAll: self sortable_name;
		nextPutAll: '.';
		nextPutAll: self semesterAanduiding	"semester-aanduiding: YYYY02 of YYYY08"
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> rawData: personRawData [ 
	rawData := personRawData
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> semesterAanduiding [
	^ '202602'
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> sortByThis [
	^ self sortable_name
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> sortable_name [
	^ rawData at: 'sortable_name'
]
