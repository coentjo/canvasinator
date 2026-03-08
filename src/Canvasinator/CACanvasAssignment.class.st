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
CACanvasAssignment >> date [
	^ '1-1'
]

{ #category : 'as yet unclassified' }
CACanvasAssignment >> dueDateColor [
	^ 
	(self due_at asString <= Date today yyyymmdd)
		ifTrue: [	Color red] 
		ifFalse: [	Color green muchDarker]
]

{ #category : 'as yet unclassified' }
CACanvasAssignment >> dueRoped [
	^ self due_at asRopedText foreground: self dueDateColor
]

{ #category : 'as yet unclassified' }
CACanvasAssignment >> due_at [
	^ rawData at: 'due_at' ifAbsent: '-'
]

{ #category : 'as yet unclassified' }
CACanvasAssignment >> gtRubricFor: aView [
	<gtView>
	^ aView list
		title: 'rubrics';
		priority: 10;
		items: { 1 . 4 . 6}
]

{ #category : 'as yet unclassified' }
CACanvasAssignment >> name [
	^ rawData at: 'name'
]

{ #category : 'as yet unclassified' }
CACanvasAssignment >> printOn: aStream [
	aStream 
		nextPutAll: 'assignment: '; cr;
		nextPutAll: self name
]

{ #category : 'accessing' }
CACanvasAssignment >> rawData: dictionary [ 
	rawData := dictionary
]

{ #category : 'as yet unclassified' }
CACanvasAssignment >> rubric [
	^ rawData at: 'rubric'
]
