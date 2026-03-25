Class {
	#name : 'CARubricsSet',
	#superclass : 'Object',
	#instVars : [
		'rawData'
	],
	#category : 'Canvasinator',
	#package : 'Canvasinator'
}

{ #category : 'as yet unclassified' }
CARubricsSet class >> on: aRawData [ 
	^ self new
		rawData:aRawData;
		yourself
]

{ #category : 'as yet unclassified' }
CARubricsSet >> printOn: aStream [

	aStream nextPutAll: rawData
]

{ #category : 'as yet unclassified' }
CARubricsSet >> rawData: aRawData [ 
	rawData := aRawData
]
