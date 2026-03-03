Class {
	#name : 'CACanvasCourse',
	#superclass : 'Object',
	#instVars : [
		'rawData',
		'token',
		'courseId'
	],
	#category : 'Canvasinator',
	#package : 'Canvasinator'
}

{ #category : 'accessing' }
CACanvasCourse class >> courseId: aCourseId [ 
	^ self new
		courseId: aCourseId;
		loadCourseInfo;
		yourself
]

{ #category : 'accessing' }
CACanvasCourse >> assignmentWithId: assignmentId [
	| reply dictionary url |
	url := 'https://fhict.instructure.com/api/v1/courses/' , self id
			, '/assignments/', assignmentId asString.	"<- show srubric definitions"
	reply := ZnClient new
			url: url;
			headerAt: 'Authorization' put: ' Bearer ' , token;
			get.
	dictionary := STON fromString: reply.
	^ CACanvasAssignment new rawData: dictionary
]

{ #category : 'accessing' }
CACanvasCourse >> courseId: aCourseId [ 
	courseId := aCourseId asString
]

{ #category : 'as yet unclassified' }
CACanvasCourse >> course_code [
	^ rawData at: 'course_code'
]

{ #category : 'as yet unclassified' }
CACanvasCourse >> gtAsignmentsFor: aView [

	<gtView>
	^ aView list
		title: 'assignments';
		priority: 10;
		items: self assignments
		
]

{ #category : 'as yet unclassified' }
CACanvasCourse >> gtPeopleFor: aView [
	<gtView>
	^ aView columnedList
		title: 'people';
		priority: 15;
		items: self people;
		column: 'i' text: [ :each | each printString asRopedText ] 
]

{ #category : 'as yet unclassified' }
CACanvasCourse >> id [
	^ courseId asString
]

{ #category : 'accessing' }
CACanvasCourse >> loadCourseInfo [
	| reply |
	reply := ZnClient new 
	url: 'https://fhict.instructure.com/api/v1/courses/', courseId;
	headerAt: 'Authorization' put: ' Bearer ', self token;
	get. 
	rawData := STON fromString: reply.

]

{ #category : 'as yet unclassified' }
CACanvasCourse >> people [
	"remark: limited nr of people (?per_page=110)"

	"courseId := 15575 asString."
	"example: ""https://fhict.instructure.com/courses/15575/users"

	| reply rawDatax nrPerPage|
	nrPerPage := 110 asString.
	reply := ZnClient new
			url: 'https://fhict.instructure.com/' , 'api/v1/' 
				, 'courses/' , self id asString
				, '/users?per_page=' , nrPerPage;
			headerAt: 'Authorization' put: ' Bearer ' , self token;
			get.
	rawDatax := STON fromString: reply.
	^ rawDatax collect: [ :each | CACanvasPerson on: each ]
	
]

{ #category : 'as yet unclassified' }
CACanvasCourse >> printOn: aStream [
	aStream
		nextPutAll: 'Canvas Course: ';
		nextPutAll: self course_code;
		cr;
		nextPutAll: 'id: ';
		nextPutAll: self id
]

{ #category : 'accessing' }
CACanvasCourse >> rawData: dictionary [
	rawData := dictionary
]

{ #category : 'as yet unclassified' }
CACanvasCourse >> token [

| canvasTokenFile |
canvasTokenFile := (FileLocator home / 'tokens' / 'token_canvas.txt').
"canvasTokenFile := '~/token_canvas.txt' asFileReference."
^ canvasTokenFile
	ifExists: [ canvasTokenFile contents.
]
	ifAbsent: [ self inform: 'Canvas token needed...'; halt ]
]

{ #category : 'accessing' }
CACanvasCourse >> token: aToken [ 
	token := aToken
]
