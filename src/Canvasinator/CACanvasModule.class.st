Class {
	#name : 'CACanvasModule',
	#superclass : 'Object',
	#instVars : [
		'rawData'
	],
	#category : 'Canvasinator',
	#package : 'Canvasinator'
}

{ #category : 'as yet unclassified' }
CACanvasModule class >> on: rawModuleData [ 
	^ self new
		rawData: rawModuleData;
		yourself
]

{ #category : 'as yet unclassified' }
CACanvasModule >> position [
	^ rawData at: 'position'
]

{ #category : 'as yet unclassified' }
CACanvasModule >> printOn: aStream [
	aStream nextPutAll: (rawData at: 'name') asString
]

{ #category : 'as yet unclassified' }
CACanvasModule >> published [
	^ rawData at: 'published'
]

{ #category : 'as yet unclassified' }
CACanvasModule >> rawData: rawModuleData [ 
	rawData := rawModuleData
]
