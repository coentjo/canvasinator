Extension { #name : 'LePage' }

{ #category : '*canvasinator' }
LePage >> <= anotherPage [
	^ self title <= anotherPage title
]

{ #category : '*canvasinator' }
LePage >> sortingIndex [
	^ self printString
]
