Class {
	#name : #CAStudent,
	#superclass : #Object,
	#instVars : [
		'number',
		'name',
		'grades',
		'moment'
	],
	#category : #Canvasinator
}

{ #category : #accessing }
CAStudent class >> nr: aNumber name: aName [
	^ self new
		number: aNumber;
		name: aName;
		yourself
]

{ #category : #accessing }
CAStudent >> grades [
	^ grades ifNil: [grades := OrderedCollection new]
]

{ #category : #accessing }
CAStudent >> moment: aMoment course: aCourse grade: aGrade repair: aRepair [

	self grades add: (CAGrade
			 moment: aMoment
			 course: aCourse
			 grade: aGrade
			 repair: aRepair)
]

{ #category : #accessing }
CAStudent >> name [
	^ name
]

{ #category : #accessing }
CAStudent >> name: aName [
	name := aName
]

{ #category : #accessing }
CAStudent >> number [
	^ number
]

{ #category : #accessing }
CAStudent >> number: aNumber [
	number := aNumber
]

{ #category : #accessing }
CAStudent >> printOn: aStream [
	aStream
			nextPutAll: (self number asString); cr;
			nextPutAll: self name 
]
