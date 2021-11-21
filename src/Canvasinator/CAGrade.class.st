Class {
	#name : #CAGrade,
	#superclass : #Object,
	#instVars : [
		'moment',
		'course',
		'grade',
		'repair'
	],
	#category : #Canvasinator
}

{ #category : #accessing }
CAGrade class >> course: aCourse grade: aGrade repair: aRepair [ 
]

{ #category : #accessing }
CAGrade class >> moment: aMoment course: aCourse grade: aGrade repair: aRepair [ 
	^ self new
		moment: aMoment course: aCourse grade: aGrade repair: aRepair
]

{ #category : #accessing }
CAGrade >> course [
	^ course
]

{ #category : #accessing }
CAGrade >> grade: aGrade repair: aRepair [ 
	^ self new
		moment: 'x' course: 'y' grade: aGrade repair: aRepair
]

{ #category : #accessing }
CAGrade >> moment: aMoment course: aCourse grade: aGrade repair: aRepair [ 
	moment := aMoment.
	course := aCourse.
	grade := aGrade.
	repair := aRepair
]

{ #category : #accessing }
CAGrade >> printOn: aStream [
	aStream 
		nextPutAll: self course; 
		nextPutAll: ' -> ' ;
		nextPutAll: grade
]
