Extension { #name : 'FileReference' }

{ #category : '*Canvasinator' }
FileReference >> caGraphForZip: aView [

	<gtView>
	(self isDirectory or: [self extension ='zip']) ifFalse: [ ^ aView empty ].

	^ aView explicit
		  title: 'Portfolio';
		  priority: 80;
		  "actionButtonIcon: BrGlamorousVectorIcons browse 
			tooltip: 'Browse method'
			action: [ :aButton | aButton phlow spawnTool: 
				(GtMethodCoderTool compiledMethod: self compiledMethod) ];"
		  stencil: [ 
			  | view items |
			  items := self allDirectories. "allChildren ??"
			  view := GtMondrian new.
			  view nodes
				  shape: [ :i | 
					  BlTextElement new
						  text: i basename asRopedText;
						  border: (BlBorder paint: Color black);
						  background: Color yellow;
						  geometry: BlEllipseGeometry new ];
				  with: items.
			  view edges
				  shape: [ :x | 
					  BlLineElement new border:
							  (BlBorder paint: (Color blue alpha: 0.5) width: x) ];
					fromCenterBottom; 
					toCenterTop;
					connectFrom: #children. "[ :item | items select: [ :i | 
			b := (item isDirectory and: [ item children anySatisfy: [ :a | a  = i  ]]) .
			self inform: b asString .
			b ifTrue: [a] ifFalse: [item]
			]]"
			view layout horizontalTree.
			  view ]
]

{ #category : '*Canvasinator' }
FileReference >> caViewDiff2For: aView [
	<gtView>
	|   start |
	start := '/Users/croco2/Downloads/example_cs_to_diff_with.cs' asFileReference .
	^ aView textEditor
		title: 'some diff' translated;
		priority: 54;
		text: [ :anEditor | 
			GtEpiceaDiffStencil new
				from: start contents;
				to: self contents;
				create ]
]

{ #category : '*Canvasinator' }
FileReference >> caViewDiffFor: aView [

	"<gtView>"
	| start |
	self isFile ifFalse: [ ^ aView empty ].
	start := '/Users/Coen/DownloadsCanvas/cohort202108.S1-CB/wk17-turnedIn-work-AirBnB/_start/AirBeeNBee/ManagementApp/AirBeeNBee.cs'
		         asFileReference.
	^ aView textEditor
		  title: 'diff AirBeeNBee' translated;
		  priority: 52;
		  text: [ :anEditor | 
			  GtEpiceaDiffStencil new
				  from: start contents;
				  to: self contents;
				  create ]
]

{ #category : '*Canvasinator' }
FileReference >> csMethods [

	| model methodNodes |
	self isDirectory ifTrue: [ ^ OrderedCollection new ].
	methodNodes := OrderedCollection new.
	model := [ 
	         CSharpParser parse: self contents.
	         model
		         allNodesOfType: CSMethodDeclarationNode
		         do: [ :node | methodNodes add: node ] ]
		         on: SmaCCParserError
		         do: [ :err | 
		         self inform: self class name , '>>csMethod:' , err asString ].

	^ methodNodes
]

{ #category : '*Canvasinator' }
FileReference >> csNumberOfMethods [

	[ ^ self csMethods size ] onErrorDo: [ ^ '?' "Yes, this is a string!" ]
]

{ #category : '*Canvasinator' }
FileReference >> isBinaryProbably [
	[ self readStreamDo: [ :s | s next: 1000 ] ]
		on: ZnInvalidUTF8
		do: [ ^ true ].
	^ false

]
