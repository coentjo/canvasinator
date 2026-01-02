Class {
	#name : 'BaselineOfCanvasinator',
	#superclass : 'BaselineOf',
	#category : 'Canvasinator',
	#package : 'Canvasinator'
}

{ #category : 'baselines' }
BaselineOfCanvasinator >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec package: 'Canvasinator' ]
]
