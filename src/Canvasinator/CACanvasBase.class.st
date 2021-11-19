Class {
	#name : #CACanvasBase,
	#superclass : #Object,
	#classInstVars : [
		'token'
	],
	#category : #'Canvasinator-Canvasinator'
}

{ #category : #accessing }
CACanvasBase class >> askUserToken [
	token := self requestToken: 'Enter your canvas token'. 
	^ token
]

{ #category : #accessing }
CACanvasBase class >> requestToken: aString [
	^ BlBlocUIManagerNotification
		requestOrNil: #requestPassword:
		with: {aString}
]

{ #category : #accessing }
CACanvasBase class >> token [
]

{ #category : #accessing }
CACanvasBase class >> userToken [
	^ token ifNil: [token := self askUserToken]
]
