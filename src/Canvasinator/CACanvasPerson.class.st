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
	^ rawData at: 'email'
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Person';
		priority: 5;
		actionButtonIcon: BrGlamorousVectorIcons play
			action: [ :aButton | aButton phlow spawnObject: 1 ];
		stencil: [ | vertical pages |
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
			pages := self potentialPagesForMe: self iAccountNumber.
			self inform: pages size asString.
			pages do: [ :page |
				vertical
					addChild: (BrEditorElement new
							padding: (BlInsets all: 10);
							constraintsDo: [ :c | 
								c horizontal matchParent.
								c vertical matchParent ];
							editor: (BrTextEditor new text: page printString asRopedText))].
			vertical ]
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> gtPagesFor: aView [
	<gtView>
	^ aView list
		title: 'Pages';
		priority: 7;
		items: (self potentialPagesForMe: self iAccountNumber) 
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> iAccountNumber [
	| iAccount |
	iAccount := rawData at: 'login_id' ifAbsent: 'I??????@fhict.nl'.
	^ ((iAccount splitOn: '@') at: 1).
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> login_id [
	^ rawData at: 'login_id'
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> parent: aParent [ 
	parent := aParent
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> potentialPagesForMe: aPartOfAPageTitle [
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
CACanvasPerson >> sortable_name [
	^ rawData at: 'sortable_name'
]
