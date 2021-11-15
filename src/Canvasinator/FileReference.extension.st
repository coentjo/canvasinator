Extension { #name : #FileReference }

{ #category : #'*Canvasinator' }
FileReference >> gtGraphForZip: aView [
	<gtView>
	(self isDirectory )
		ifFalse: [ ^ aView empty ].

	^ aView explicit
		title: 'Portfolio';
		priority: 8;
		"actionButtonIcon: BrGlamorousVectorIcons browse 
			tooltip: 'Browse method'
			action: [ :aButton | aButton phlow spawnTool: 
				(GtMethodCoderTool compiledMethod: self compiledMethod) ];"
		stencil: [ 	| view items  |
	items := self allDirectories "allChildren". 
	view := GtMondrian new.
	view nodes
		shape: [ :i | 
			BlTextElement new 
				text: i basename asRopedText;
				border: (BlBorder paint: Color black);
				background: Color yellow;
				geometry: BlEllipseGeometry new];
		with: items.
	view edges 
		shape: [ :x | 
			BlLineElement new
				border: (BlBorder paint: (Color blue alpha: 0.5) width: x) ];
		connectFrom: #parent "[ :item | items select: [ :i | 
			b := (item isDirectory and: [ item children anySatisfy: [ :a | a  = i  ]]) .
			self inform: b asString .
			b ifTrue: [a] ifFalse: [item]
			]]"	
		
	.
	view].
]
