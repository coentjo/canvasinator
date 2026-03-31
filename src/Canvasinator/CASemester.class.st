Class {
	#name : 'CASemester',
	#superclass : 'Object',
	#instVars : [
		'name',
		'fromSnippet',
		'canvasCourses'
	],
	#category : 'Canvasinator',
	#package : 'Canvasinator'
}

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
		column: 'name' text: [ : each | each printString]
]

{ #category : 'accessing' }
CASemester >> name: aString [ 
	name := aString
]

{ #category : 'as yet unclassified' }
CASemester >> printOn: aStream [
	aStream nextPutAll: name
]
