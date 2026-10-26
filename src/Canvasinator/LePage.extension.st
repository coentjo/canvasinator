Extension { #name : 'LePage' }

{ #category : '*canvasinator' }
LePage >> <= anotherPage [
	^ self title <= anotherPage title
]

{ #category : '*canvasinator' }
LePage >> contextNameRoped [
	| triggerWords colors |
	triggerWords := { 'todo' . 'ongoing' }.
	colors := { Color orange . Color white. Color red . Color lightGray }.
	triggerWords doWithIndex: [ :word :index | 
		(self title matchesRegexIgnoringCase: '.*', word,'.*')
			ifTrue: [ ^ word asRopedText background: (colors at: index) ] ].
	^ '-' asRopedText background: Color veryLightGray lighter
]

{ #category : '*canvasinator' }
LePage >> sortingIndex [
	^ self printString
]
