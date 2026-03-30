Class {
	#name : 'CACanvasAssignment',
	#superclass : 'Object',
	#instVars : [
		'rawData'
	],
	#category : 'Canvasinator',
	#package : 'Canvasinator'
}

{ #category : 'as yet unclassified' }
CACanvasAssignment class >> on: rawAssignmentData [
	^ self new 
		rawData: rawAssignmentData;
		yourself
]

{ #category : 'as yet unclassified' }
CACanvasAssignment >> courseId [
	^ 15757
]

{ #category : 'as yet unclassified' }
CACanvasAssignment >> date [
	^ '1-1'
]

{ #category : 'as yet unclassified' }
CACanvasAssignment >> dueDateColor [
	^ 
	(self due_at asString <= Date today yyyymmdd)
		ifTrue: [	Color red] 
		ifFalse: [	
			(self due_at asString <= (Date today addDays: 8) yyyymmdd) ifTrue: [Color orange] ifFalse: [
		Color green muchDarker]]
]

{ #category : 'as yet unclassified' }
CACanvasAssignment >> dueRoped [
	^ self due_at asRopedText foreground: self dueDateColor
]

{ #category : 'as yet unclassified' }
CACanvasAssignment >> due_at [
	| due_at |
	due_at := (rawData at: 'due_at' ifAbsent: '-') ifNil: ['-'].
	^ ('T' split: due_at) at: 1
]

{ #category : 'as yet unclassified' }
CACanvasAssignment >> gtRubricFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Rubrics';
		priority: 10;
		items: self rubric_settings;
		column: 'Name' text: [ :each | each description asRopedText foreground: Color orange darker];
		column: 'Description' text: [ :each | each long_description];
		actionButtonIcon: BrGlamorousVectorIcons target
			tooltip: 'attendance'
			action: [ :aButton "aButton phlow spawnTool: pages first" | 
				WebBrowser
					openOn: 'https://fhict.instructure.com/courses/' , self courseId asString
							, '/gradebook/speed_grader?assignment_id=273514&anonymous_id=3hz3G&student_id=39655' ]
]

{ #category : 'as yet unclassified' }
CACanvasAssignment >> name [
	^ rawData at: 'name'
]

{ #category : 'as yet unclassified' }
CACanvasAssignment >> printOn: aStream [
	aStream 
		nextPutAll: 'assignment: '; cr;
		nextPutAll: self name asString
]

{ #category : 'accessing' }
CACanvasAssignment >> rawData: dictionary [ 
	rawData := dictionary
]

{ #category : 'as yet unclassified' }
CACanvasAssignment >> rubric_settings [
	^ (rawData at: 'rubric') collect: [ :each | CARubricsSet on: each]
]

{ #category : 'as yet unclassified' }
CACanvasAssignment >> rubrics [
	^ {1.
		4.
		6}
]
