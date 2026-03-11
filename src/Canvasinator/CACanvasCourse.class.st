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
CACanvasCourse class >> courseId: aCourseId fromSnippet: aSnippet [ 
	^ self new
		courseId: aCourseId;
		fromSnippet: aSnippet;
		loadCourseInfo;
		yourself
]

{ #category : 'as yet unclassified' }
CACanvasCourse >> allPages [
	^ self lepDatabase pages
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
				, '/announcement';
			headerAt: 'Authorization' put: ' Bearer ' , self token;
			get.
	rawDatax := "STON fromString:" reply.
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
		items: (self assignments sort: [ :a :b | a due_at <= b due_at ]);
		column: 'name' text: [ :each | each name ];
		column: 'date' text: [ :each | each dueRoped];
		column: 'obj' text: [ :each | [each asString] onErrorDo: ['_'] ].
		
		
]

{ #category : 'as yet unclassified' }
CACanvasCourse >> gtPeopleFor: aView [
	<gtView>
	| counter allPages |
	counter := 0.
	allPages := self allPages.
	^ aView columnedList
		title: 'people';
		priority: 5;
		items: (self people sort: [ :a :b | a sortByThis <= b sortByThis ]);
		column: 'nr'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 75;
		column: 'name'
			text: [ :each "each sortable_name asRopedText" | each sortByThisUsing: allPages ];
		column: 'page'
			text: [ :each | 
				allPages
					detect: [ :page | page title matches: '*' , each iAccountNumber , '*' ]
					ifNone: [ each iAccountNumber asRopedText foreground: Color orange ] ];
		send: [ :each | each value ];
		actionButtonIcon: BrGlamorousVectorIcons async
			tooltip: 'portflow'
			action: [ :aButton | 
				WebBrowser
					openOn: 'https://fhict.instructure.com/accounts/1/external_tools/23360?launch_type=global_navigation&toolId=portfolio-23360' ];
		actionButtonIcon: BrGlamorousVectorIcons robot
			tooltip: 'attendance'
			action: [ :aButton "aButton phlow spawnTool: pages first" | 
				WebBrowser
					openOn: 'https://fhict.instructure.com/courses/',  courseId asString,'/external_tools/1663' ];
		actionButtonIcon: BrGlamorousVectorIcons roadmap
			tooltip: 'feedpulse'
			action: [ :aButton "aButton phlow spawnTool: pages first" | 
				WebBrowser
					openOn: 'https://fhict.instructure.com/courses/',  courseId asString,'/external_tools/1067' ]
					

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
CACanvasCourse >> pageFileReference: page [ 
	^ self lepDatabase pageFileReference: page
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
	^ rawDatax collect: [ :each | CACanvasPerson on: each withParent: self]
	
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
