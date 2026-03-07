Class {
	#name : 'CACanvasCourse',
	#superclass : 'Object',
	#instVars : [
		'rawData',
		'token',
		'courseId',
		'fromSnippet'
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

{ #category : 'as yet unclassified' }
CACanvasCourse >> announcements [
	"remark: limited nr of people (?per_page=110)"

	"courseId := 15575 asString."
	"example: ""https://fhict.instructure.com/courses/15575/users"

	| reply rawDatax|
	reply := ZnClient new
			url: 'https://fhict.instructure.com/' , 'api/v1/' 
				, 'courses/' , self id asString
				, '/announcements';
			headerAt: 'Authorization' put: ' Bearer ' , self token;
			get.
	rawDatax := STON fromString: reply.
	^ rawDatax "collect: [ :each | CACanvasPerson on: each ]"
	
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

{ #category : 'as yet unclassified' }
CACanvasCourse >> assignments [
	"remark: limited nr of people (?per_page=110)"

	"courseId := 15575 asString."
	"example: ""https://fhict.instructure.com/courses/15575/users"

	| reply rawDatax|
	reply := ZnClient new
			url: 'https://fhict.instructure.com/' , 'api/v1/' 
				, 'courses/' , self id asString
				, '/assignments';
			headerAt: 'Authorization' put: ' Bearer ' , self token;
			get.
	rawDatax := STON fromString: reply.
	^ rawDatax collect: [ :each | CACanvasAssignment on: each ]
]

{ #category : 'accessing' }
CACanvasCourse >> courseId: aCourseId [ 
	courseId := aCourseId asString
]

{ #category : 'as yet unclassified' }
CACanvasCourse >> course_code [
	^ rawData at: 'course_code'
]

{ #category : 'accessing' }
CACanvasCourse >> fromSnippet: thisSnippet [ 
	"store snippet for now, although at this moment I only need the database, which I can get from this snippet"
	fromSnippet := thisSnippet
]

{ #category : 'as yet unclassified' }
CACanvasCourse >> gtAnnouncementsFor: aView [

	<gtView>
	^ aView list
		title: 'announcements';
		priority: 17;
		items: { 'self announcements' }
		
]

{ #category : 'as yet unclassified' }
CACanvasCourse >> gtAsignmentsFor: aView [

	<gtView>
	^ aView columnedList
		title: 'assignments';
		priority: 10;
		items: self assignments;
		column: 'name' text: [ :each | each name ];
		column: 'date' text: [ :each | each date ];
		column: 'obj' text: [ :each | [each asString] onErrorDo: ['_'] ].
		
		
]

{ #category : 'as yet unclassified' }
CACanvasCourse >> gtPeopleFor: aView [
	<gtView>
	| counter |
	counter := 0.
	^ aView columnedList
		title: 'people';
		priority: 5;
		items: self people;
		column: 'nr'
			text: [ :each | 
				counter := counter + 1.
				counter ]
			width: 75;
		column: 'i-account'
			text: [ :each | each iAccountNumber ]
			width: 75;
		column: 'name'
			text: [ :each | (each sortable_name) asRopedText ];
		column: 'x' text: [ : each | self lepDatabase pages detect: [ :page | page title matches: '*',each iAccountNumber,'@*' ]
ifNone: [ 'x']]" 
		column: 'Origin'
			text: [ :anExplicitLink | anExplicitLink originReference description ];
		column: 'Target'
			text: [ :anExplicitLink | anExplicitLink targetReference description ];
		column: 'Status'
			text: [ :anExplicitLink | 
				anExplicitLink targetReference status
					in: [ :aStatus | aStatus label asRopedText foreground: aStatus color ] ]
			width: 100"
]

{ #category : 'as yet unclassified' }
CACanvasCourse >> id [
	^ courseId asString
]

{ #category : 'as yet unclassified' }
CACanvasCourse >> lepDatabase [
	^ fromSnippet database
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
CACanvasCourse >> pageFor: anIAccountNr [
	self lepDatabase pages detect: [ :p | p title asString startsWith: anIAccountNr ] ifNone: [ '-' ]
]

{ #category : 'as yet unclassified' }
CACanvasCourse >> people [
	"remark: limited nr of people (?per_page=110)"

	"courseId := 15575 asString."
	"example: ""https://fhict.instructure.com/courses/15575/users"

	| reply rawDatax nrPerPage|
	nrPerPage := 150 asString.
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
