Extension { #name : #AbstractFileReference }

{ #category : #'*Canvasinator' }
AbstractFileReference >> allInterestringChildren [
	"Return all the files and folders recursively nested in the receiver"
	
	^ CollectVisitor 
		breadthFirst: self resolve 
		collect: [:entry | entry reference ]
]

{ #category : #'*Canvasinator' }
AbstractFileReference >> caNamesFor: aView [
	<gtView>
	self isDirectory
		ifFalse: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Portfolio' translated;
		priority: 13;
		items: [ self gtChildren ];
		children: [ :each | each gtChildren ];
		column: 'Name' translated 
			icon: [ :each | 
				| anIcon aName aContainer |
				anIcon := each isDirectory
					ifTrue: [ BrGlamorousIcons folder asElement ]
					ifFalse: [ BrGlamorousIcons file asElement ].
				
				aName := GtPhlowUtility newItemLabel.
				aName text: each basename asString.
				
				aContainer := BrHorizontalPane new
					alignCenter;
					fitContent.
				
				aContainer addChild: anIcon; addChild: aName ]
			weight: 1;
		column: 'Size' translated
			text: [ :each | 
				[ | sz |
					each isFile 
						ifTrue: [each humanReadableSize asString]
						ifFalse: [''] ]
				on: FileException, FileSystemError
				do: [ :anException | anException return: '' ] ]
			width: 100;
		column: 'cs' translated
			text: [ :each | 
				[ | numCsFiles |
					numCsFiles := (each csFiles size).
					numCsFiles > 0 
						ifTrue: [numCsFiles asString]
						ifFalse: [''] ]
				on: SmaCCParserError
				do: [ :anException | self inform: anException class asString  ] ]
			width: 100;
		column: 'methods' translated
			text: [:each | each csNumberOfMethods asString]
			width: 100
]

{ #category : #'*Canvasinator' }
AbstractFileReference >> caPortfolioFor: aView [
	<gtView>
	self isDirectory
		ifFalse: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Portfoliox' translated;
		priority: 13;
		items: [ self gtChildren ];
		children: [ :each | each gtChildren ];
		column: 'Name' translated 
			icon: [ :each | 
				| anIcon aName aContainer |
				anIcon := each isDirectory
					ifTrue: [ BrGlamorousIcons folder asElement ]
					ifFalse: [ BrGlamorousIcons file asElement ].
				
				aName := GtPhlowUtility newItemLabel.
				aName text: each basename asString.
				
				aContainer := BrHorizontalPane new
					alignCenter;
					fitContent.
				
				aContainer addChild: anIcon; addChild: aName ]
			weight: 1;
		column: 'Size' translated
			text: [ :each | 
				[ | sz |
					each isFile 
						ifTrue: [each humanReadableSize asString]
						ifFalse: [''] ]
				on: FileException, FileSystemError
				do: [ :anException | anException return: '' ] ]
			width: 100;
		column: 'cs' translated
			text: [ :each | 
				[ | numCsFiles |
					numCsFiles := (each csFiles size).
					numCsFiles > 0 
						ifTrue: [numCsFiles asString]
						ifFalse: [''] ]
				on: SmaCCParserError
				do: [ :anException | self inform: anException class asString  ] ]
			width: 100;
		column: 'methods' translated
			text: [:each | each csNumberOfMethods asString]
			width: 100
]

{ #category : #'*Canvasinator' }
AbstractFileReference >> csFiles [
	^ (self allInterestringChildren select: [ :f | f extension = 'cs' ])
]

{ #category : #'*Canvasinator' }
AbstractFileReference >> findLinkUrlsIn: aText [
	| links regExp |
	links := OrderedCollection new .
	regExp := '<a href="(.*)">Click Here to go to the submission</a>' asRegex.
	self contents linesDo: [ :line | 
		(regExp matches: line)
			ifTrue: [ links add: (regExp subexpression: 2) ].
		].
	^ (String streamContents: [ :str | 
		links do: [ :lnk | 
			str nextPutAll: lnk ] 
			separatedBy: [str cr] ]) asRopedText
]

{ #category : #'*Canvasinator' }
AbstractFileReference >> gtCanvasLinkFor: aView [
	<gtView>
	self isFile ifFalse: [ ^ aView empty ].
	self extension = 'html' ifFalse: [ ^ aView empty ] .
	[ self readStreamDo: [ :s | s next: 1000 ] ]
		on: ZnInvalidUTF8
		do: [ ^ aView empty ].
	^ aView explicit
		title: 'canvas-url' translated;
		priority: 49;
		stencil: [ 
			BrEditorElement new 
				padding: (BlInsets all: 10);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ];
				editor: (BrTextEditor new 
					text: (((self findLinkUrlsIn: self contents)) asRopedText) ) ];
												
		actionStencil: [ :tab | 
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				label: 'Go';
				icon: BrGlamorousIcons go;
				action: [ 
				 WebBrowser openOn: (self findLinkUrlsIn: self contents) ] ] 				 
]

{ #category : #'*Canvasinator' }
AbstractFileReference >> numCsFiles [
	^ (self allInterestringChildren select: [ :f | f extension = 'cs' ])  
		size
]
