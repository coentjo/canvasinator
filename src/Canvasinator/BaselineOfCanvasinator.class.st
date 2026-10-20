Class {
	#name : 'BaselineOfCanvasinator',
	#superclass : 'BaselineOf',
	#category : 'Canvasinator',
	#package : 'Canvasinator'
}

{ #category : 'baselines' }
BaselineOfCanvasinator class >> loadLepiter [
	| currentProperties |
	currentProperties := LeDatabasesRegistry defaultLogicalDatabase properties.
	currentProperties
		addRegisteredDirectory: FileLocator imageDirectory
			/ 'pharo-local'
			/ 'iceberg'
			/ 'coentjo'
			/ 'canvasinator'
			/ 'lepiter'.
	LeDatabasesRegistry default defaultLogicalDatabase reload.
	

]

{ #category : 'baselines' }
BaselineOfCanvasinator >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec package: #Canvasinator 
	]
]
