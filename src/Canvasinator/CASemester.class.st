Class {
	#name : 'CASemester',
	#superclass : 'Object',
	#instVars : [
		'name',
		'fromSnippet',
		'canvasCourses',
		'weekday'
	],
	#category : 'Canvasinator',
	#package : 'Canvasinator'
}

{ #category : 'accessing' }
CASemester >> addCanvasCourse: aCourseId day: aString for: aString1 [ 
	| course |
	course := (CACanvasCourse courseId: aCourseId fromSnippet: fromSnippet)
		weekday: aString; 
		yourself.
	self canvasCourses add: course

]

{ #category : 'accessing' }
CASemester >> addCanvasCourse: aCourseId for: aString [ 
	self canvasCourses add: (CACanvasCourse courseId: aCourseId fromSnippet: fromSnippet)
]

{ #category : 'accessing' }
CASemester >> canvasCourses [
	^canvasCourses ifNil: [ canvasCourses := OrderedCollection new]
]

{ #category : 'accessing' }
CASemester >> fromSnippet: aSnippet [ 
	"store snippet for now, although at this moment I only need the database, which I can get from this snippet"
	fromSnippet := aSnippet
]

{ #category : 'as yet unclassified' }
CASemester >> gtCoursesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Courses';
		priority: 5;
		items: canvasCourses;
		column: 'day'  text: [ :each | each weekday ] weight: 0.1;
		column: 'name' text: [ :each | each printString ]

]

{ #category : 'as yet unclassified' }
CASemester >> gtDirectoriesFor: aView [
	<gtView>
	^ aView forward
		title: 'Dirs';
		priority: 8;
		object: [FileLocator home / self name];
		view: #gtTreeFor:

]

{ #category : 'as yet unclassified' }
CASemester >> gtLiveFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Live';
		priority: 4;
		items: canvasCourses;
		column: 'day'  text: [ :each | each weekday ] weight: 0.1;
		column: 'name' text: [ :each | each printString ]

]

{ #category : 'as yet unclassified' }
CASemester >> name [
	^ name
]

{ #category : 'accessing' }
CASemester >> name: aString [ 
	name := aString
]

{ #category : 'as yet unclassified' }
CASemester >> printOn: aStream [
	aStream nextPutAll: name
]

{ #category : 'as yet unclassified' }
CASemester >> weekday [
	^ weekday
]

{ #category : 'accessing' }
CASemester >> weekday: aString [ 
	weekday := aString
]
