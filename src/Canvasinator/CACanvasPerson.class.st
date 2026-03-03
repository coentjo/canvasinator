Class {
	#name : 'CACanvasPerson',
	#superclass : 'Object',
	#instVars : [
		'rawData'
	],
	#category : 'Canvasinator',
	#package : 'Canvasinator'
}

{ #category : 'as yet unclassified' }
CACanvasPerson class >> on: personRawData [
	^ self new
		rawData: personRawData;
		yourself
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> iAccountNumber [
	| iAccount |
	iAccount := rawData at: 'login_id' ifAbsent: 'I??????@fhict.nl'.
	^ ((iAccount splitOn: '@') at: 1).
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> printOn: aStream [
	aStream
		nextPutAll: self iAccountNumber;
		nextPutAll: '.';
		nextPutAll: self sortable_name;
		nextPutAll: '.';
		nextPutAll: self semesterAanduiding	"semester-aanduiding: YYYY02 of YYYY08"
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> rawData: personRawData [ 
	rawData := personRawData
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> semesterAanduiding [
	^ '202602'
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> sortable_name [
	^ rawData at: 'sortable_name'
]
