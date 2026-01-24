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
CACanvasAssignment >> due_at [
	^ rawData at: 'due_at'
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
		nextPutAll: self name ; cr;
		nextPutAll: self due_at
]

{ #category : 'accessing' }
CACanvasAssignment >> rawData: dictionary [ 
	rawData := dictionary
]

{ #category : 'as yet unclassified' }
CACanvasAssignment >> rubric [
	^ rawData at: 'rubric'
]
