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
CACanvasCourse >> baseUrl: aUrl [
	baseUrl := aUrl
]

{ #category : #accessing }
CACanvasCourse >> baseUrl: aBaseUrl number: aCourseNumber [
	^ self 
		baseUrl: aBaseUrl asUrl;
		number: aCourseNumber
		yourself
]

{ #category : #accessing }
CACanvasCourse >> course: aCourseNumber [
	courseNumber := aCourseNumber
]

{ #category : #accessing }
CACanvasCourse >> defaultBase [
	| canvasBase |
	canvasBase := CACanvasBase defaultBase.
	^ self
]

{ #category : #accessing }
CACanvasCourse >> exampleCourse [

	<gtExample>
	<noTest>
	^ self class
		  baseUrl: 'https://fhict.instructure.com' asUrl 
		  number: 9103
]

{ #category : #accessing }
CACanvasCourse >> number: aCourseNumber [

	^ self baseUrl: CACanvasBase defaultBaseUrl number: aCourseNumber
]
