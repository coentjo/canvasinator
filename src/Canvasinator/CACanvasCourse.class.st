Class {
	#name : #CACanvasCourse,
	#superclass : #Object,
	#instVars : [
		'courseNumber',
		'baseUrl',
		'canvasBase',
		'json'
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
CACanvasCourse >> canvasBase [

	^ canvasBase ifNil: [ canvasBase := CACanvasBase defaultBase ]
]

{ #category : #accessing }
CACanvasCourse >> course: aCourseNumber [
	courseNumber := aCourseNumber
]

{ #category : #accessing }
CACanvasCourse >> courseInfo [


	^ self courseJson asString asRopedText
]

{ #category : #accessing }
CACanvasCourse >> courseJson [

	^ json ifNil: [ 
		  json := ZnClient new
			          url: 'https://fhict.instructure.com/api/v1/courses';
			          headerAt: 'Authorization'
			          put: ' Bearer ' , CACanvasBase userToken;
			          get ]
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
CACanvasCourse >> getCourseInfo [
| token |
token  := CACanvasBase userToken .
ZnClient new
	url: 'https://fhict.instructure.com/api/v1/courses';
	headerAt: 'Authorization' put: ' Bearer ', token;
	get. 
	
	^'getcourse'
]

{ #category : #accessing }
CACanvasCourse >> gtCourseInfoFor: aView [

	<gtView>
	^ aView textEditor
		  title: 'Course';
		  priority: 110;
		  aptitude: BrGlamorousCodeEditorAptitude;
		  text: [ self courseInfo asRopedText ]
]

{ #category : #accessing }
CACanvasCourse >> gtJsonFor: aView [
	<gtView>
	| selfIsFile selfextension selfcontents |
	"(selfIsFile and: [ (GtFileUtility mimeTypeOfExtension: selfextension) 
		= ZnMimeType applicationJson ]) ifFalse: [ ^ aView empty ]."
	^ aView textEditor
		title: 'JSON';
		priority: 21;
		actionButtonIcon: BrGlamorousIcons tree 
			action: [ :aButton | 
				aButton phlow spawnObject: (
					STONJSON fromString: self courseJson) ];
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ JSONParser gtStyler ];
		text: [ (STONJSON toStringPretty: (
			STONJSON fromString: self courseJson)) ]
]

{ #category : #accessing }
CACanvasCourse >> number: aCourseNumber [

	^ self baseUrl: CACanvasBase defaultBaseUrl number: aCourseNumber
]
