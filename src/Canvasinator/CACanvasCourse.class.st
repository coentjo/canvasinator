Class {
	#name : 'CACanvasCourse',
	#superclass : 'Object',
	#instVars : [
		'rawData',
		'token',
		'assignmentIds'
	],
	#category : 'Canvasinator',
	#package : 'Canvasinator'
}

{ #category : 'as yet unclassified' }
CACanvasCourse >> assignmentIds [
	^ assignmentIds
]

{ #category : 'accessing' }
CACanvasCourse >> assignmentIds: anObject [ 
	assignmentIds := anObject
]

{ #category : 'accessing' }
CACanvasCourse >> assignmentWithId: assignmentId [
	| reply dictionary url |
	url := 'https://fhict.instructure.com/api/v1/courses/' , self id
			, '/assignments/', assignmentId asString.	"<- show srubruc definitions"
	reply := ZnClient new
			url: url;
			headerAt: 'Authorization' put: ' Bearer ' , token;
			get.
	dictionary := STON fromString: reply.
	^ CACanvasAssignment new rawData: dictionary
]

{ #category : 'as yet unclassified' }
CACanvasCourse >> assignments [
	^ self assignmentIds 
		collect: [ :id | self assignmentWithId: id]
]

{ #category : 'as yet unclassified' }
CACanvasCourse >> course_code [
	^ rawData at: 'course_code'
]

{ #category : 'as yet unclassified' }
CACanvasCourse >> gtAsignmentIDsFor: aView [

	<gtView>
	^ aView list
		title: 'assignmentIDs';
		priority: 15;
		items: self assignmentIds
		
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
CACanvasCourse >> id [
	^ (rawData at: 'id') asString
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

{ #category : 'accessing' }
CACanvasCourse >> token: aToken [ 
	token := aToken
]
