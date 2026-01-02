Class {
	#name : 'CACanvasBase',
	#superclass : 'Object',
	#instVars : [
		'courseNumber'
	],
	#classInstVars : [
		'token',
		'defaultBase'
	],
	#category : 'Canvasinator-Canvasinator',
	#package : 'Canvasinator',
	#tag : 'Canvasinator'
}

{ #category : 'accessing' }
CACanvasBase class >> askUserToken [

	token := self requestToken: 'Enter your canvas token'.
	token ifNil: [ 
		self inform:
			'Class CACanvasBase needs a canvas Token: it is nil now.'
			, Character cr asString, 'Execute this in a Playground: ' , Character cr asString
			, 'CACanvasBase token: ''a1bc23d4e5''' ]
]

{ #category : 'accessing' }
CACanvasBase class >> course: aString [ 
]

{ #category : 'accessing' }
CACanvasBase class >> defaultBase [
	^ defaultBase ifNil: [ defaultBase :=  self new ]
]

{ #category : 'accessing' }
CACanvasBase class >> defaultBaseUrl [
	"if needed, replace it with your own..."
	^ 'https://fhict.instructure.com/' 
]

{ #category : 'accessing' }
CACanvasBase class >> requestToken: aString [
	<gtExample>
	^ BlBlocUIManagerNotification
		requestOrNil: #requestPassword:
		with: {aString}
]

{ #category : 'accessing' }
CACanvasBase class >> token [
	^ token
]

{ #category : 'accessing' }
CACanvasBase class >> token: aCanvasToken [ 
	token ifNotNil: [self inform: 'replacing non-nil-token'].
	token := aCanvasToken
]

{ #category : 'accessing' }
CACanvasBase class >> userToken [
	^ token ifNil: [token := self askUserToken]
]

{ #category : 'accessing' }
CACanvasBase >> course: aCourseNumber [
	courseNumber := aCourseNumber
]
