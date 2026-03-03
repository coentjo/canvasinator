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
CACanvasPerson >> printOn: aStream [
	| iAccount |
	iAccount := rawData at: 'login_id' ifAbsent: 'I??????@fhict.nl'.
	iAccount := ((iAccount splitOn: '@') at: 1) , ''.	"
				'202602.' , (rawData at: 'sortable_name') , '_'
					, iAccount , ']]'.
"

	aStream
		nextPutAll: iAccount;
		nextPutAll: '.';
		nextPutAll: (rawData at: 'sortable_name');
		nextPutAll: '.';
		nextPutAll: '202602' "semester-aanduiding: YYYY02 of YYYY08"
]

{ #category : 'as yet unclassified' }
CACanvasPerson >> rawData: personRawData [ 
	rawData := personRawData
]
