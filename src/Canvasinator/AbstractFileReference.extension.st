Extension { #name : #AbstractFileReference }

{ #category : #'*Canvasinator' }
AbstractFileReference >> gtSecondTreeFor: aView [
	<gtView>
	self isDirectory
		ifFalse: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Tree2' translated;
		priority: 11;
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
				[ each humanReadableSize asString ]
				on: FileException, FileSystemError
				do: [ :anException | anException return: '' ] ]
			width: 100;
		column: 'cs' translated
			text: [ :each | self numCsFiles asString]
			width: 100
]

{ #category : #'*Canvasinator' }
AbstractFileReference >> numCsFiles [
	^ (self allChildren select: [ :f | f extension = 'cs' ])  
		size
]
