Extension { #name : #FileReference }

{ #category : #'*Canvasinator' }
FileReference >> csMethods [

	| model methodNodes |
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

{ #category : #'*Canvasinator' }
FileReference >> gtGraphForZip: aView [

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

{ #category : #'*Canvasinator' }
FileReference >> gtViewDiff2For: aView [
	<gtView>
	|  end |
	end := '/Users/Coen/DownloadsCanvas/diffBase/SteamGamesChecklistForm.solution.cs' asFileReference .
	^ aView textEditor
		title: 'Diff2' translated;
		priority: 54;
		text: [ :anEditor | 
			GtEpiceaDiffStencil new
				from: self contents;
				to: end contents;
				create ]
]

{ #category : #'*Canvasinator' }
FileReference >> gtViewDiffFor: aView [

	<gtView>
	| start end |
	self isFile ifFalse: [ ^ aView empty ].
	start := '/Users/Coen/DownloadsCanvas/diffBase/SteamGamesChecklistForm.start.cs'
		         asFileReference.
	^ aView textEditor
		  title: 'Diff1' translated;
		  priority: 52;
		  text: [ :anEditor | 
			  GtEpiceaDiffStencil new
				  from: start contents;
				  to: self contents;
				  create ]
]

{ #category : #'*Canvasinator' }
FileReference >> isBinaryProbably [
	[ self readStreamDo: [ :s | s next: 1000 ] ]
		on: ZnInvalidUTF8
		do: [ ^ true ].
	^ false

]
