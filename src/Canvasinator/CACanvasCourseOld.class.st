Class {
	#name : 'CACanvasCourseOld',
	#superclass : 'Object',
	#instVars : [
		'courseNumber',
		'baseUrl',
		'canvasBase',
		'json'
	],
	#category : 'Canvasinator',
	#package : 'Canvasinator'
}

{ #category : 'accessing' }
CACanvasCourseOld >> baseUrl: aUrl [
	baseUrl := aUrl
]

{ #category : 'accessing' }
CACanvasCourseOld >> baseUrl: aBaseUrl number: aCourseNumber [
	^ self 
		baseUrl: aBaseUrl asUrl;
		number: aCourseNumber
		yourself
]

{ #category : 'accessing' }
CACanvasCourseOld >> canvasBase [

	^ canvasBase ifNil: [ canvasBase := CACanvasBase defaultBase ]
]

{ #category : 'accessing' }
CACanvasCourseOld >> course: aCourseNumber [
	courseNumber := aCourseNumber
]

{ #category : 'accessing' }
CACanvasCourseOld >> courseInfo [

	| cr |
	cr := Character cr asString.
	^ (self courseUrl , cr , '- - - - - - - - -', cr, self courseJson asString) asString asRopedText
]

{ #category : 'accessing' }
CACanvasCourseOld >> courseJson [

	^ json ifNil: [ 
		  json := ZnClient new
			          url: self courseUrl ;
			          headerAt: 'Authorization'
			          put: ' Bearer ' , CACanvasBase userToken;
			          get ]
]

{ #category : 'accessing' }
CACanvasCourseOld >> courseUrl [

	^ self urlForCourse: (courseNumber ifNil: [ 
			 ^ 'https://fhict.instructure.com/api/v1/courses' ])
]

{ #category : 'accessing' }
CACanvasCourseOld >> defaultBase [
	| canvasBase |
	canvasBase := CACanvasBase defaultBase.
	^ self
]

{ #category : 'accessing' }
CACanvasCourseOld >> exampleCourse [

	<gtExample>
	<noTest>
	^ CACanvasCourseOld new
		  number: 9103;
		  yourself
]

{ #category : 'accessing' }
CACanvasCourseOld >> getCourseInfo [
| token |
token  := CACanvasBase userToken .
ZnClient new
	url: 'https://fhict.instructure.com/api/v1/courses';
	headerAt: 'Authorization' put: ' Bearer ', token;
	get. 
	
	^'getcourse'
]

{ #category : 'accessing' }
CACanvasCourseOld >> gtCourseInfoFor: aView [

	<gtView>
	^ aView textEditor
		  title: 'Course';
		  priority: 110;
		  aptitude: BrGlamorousCodeEditorAptitude;
		  text: [ self courseInfo asRopedText ]
]

{ #category : 'accessing' }
CACanvasCourseOld >> gtJsonFor: aView [
	<gtView>
	
	"(selfIsFile and: [ (GtFileUtility mimeTypeOfExtension: selfextension) 
		= ZnMimeType applicationJson ]) ifFalse: [ ^ aView empty ]."
	^ aView textEditor
		title: 'JSON';
		priority: 120;
		actionButtonIcon: BrGlamorousIcons tree 
			action: [ :aButton | 
				aButton phlow spawnObject: (
					STONJSON fromString: self courseJson printString) ];
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ JSONParser gtStyler ];
		text: [ (STONJSON toStringPretty: (
			STONJSON fromString: self courseJson)) printString]
]

{ #category : 'accessing' }
CACanvasCourseOld >> number: aCourseNumber [

	courseNumber := aCourseNumber.
	^ self 
]

{ #category : 'accessing' }
CACanvasCourseOld >> urlForCourse: anObject [ 
	^ 'https://fhict.instructure.com/courses/11531'
]
