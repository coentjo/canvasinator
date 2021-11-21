Class {
	#name : #CAClass,
	#superclass : #Object,
	#instVars : [
		'name',
		'studs'
	],
	#category : #'Canvasinator-Canvasinator'
}

{ #category : #accessing }
CAClass class >> named: aString [
	^ self new
		name: aString
]

{ #category : #accessing }
CAClass >> name: aString [ 
	name := aString
]

{ #category : #accessing }
CAClass >> student: aName nr: aNumber [
	| stud |
	stud := CAStudent nr: aNumber name: aName.
	self studs
		  add: stud.
		  ^ stud
]

{ #category : #accessing }
CAClass >> studs [
	^ studs ifNil: [studs := OrderedCollection new]
]
