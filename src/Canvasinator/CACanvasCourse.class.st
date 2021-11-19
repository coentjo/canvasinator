Class {
	#name : #CACanvasCourse,
	#superclass : #Object,
	#instVars : [
		'courseNumber',
		'baseUrl'
	],
	#category : #Canvasinator
}

{ #category : #accessing }
CACanvasCourse class >> baseUrl: aBaseUrl number: aCourseNumber [
	^ self new
		baseUrl: aBaseUrl asUrl;
		yourself
]

{ #category : #accessing }
CACanvasCourse >> baseUrl: aUrl [
	baseUrl := aUrl
]
