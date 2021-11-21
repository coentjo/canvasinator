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
CAStudent >> course: aCourse grade: aGrade repair: aRepair [
	<deprecated>
	
	"for convenience, because for first use 'moment' is not relevant... "
	^ self moment: 'X' course: aCourse grade: aGrade repair: aRepair
]

{ #category : #accessing }
CAStudent >> gradeFor: aString [ 
	self grades select: [ :g | 
		'1' ]
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
	^ number ifNil: ['??']
]

{ #category : #accessing }
CAStudent >> number: aNumber [
	number := aNumber
]

{ #category : #accessing }
CAStudent >> printInfo [

	^ String streamContents: [ :stream | 
		  stream
			  nextPutAll:
				  'CAStudent nr: ''' , self number asString , ''' name: '''
				  , self name , '''; ';
			  cr;
			  tab.
		  #( 'IEO' 'ADO' 'ESO' 'DDO' 'EDO' ) do: [ :course | 
			  stream
				  tab;
				  nextPutAll: course;
				  nextPutAll: ': ''''' ] ]
]

{ #category : #accessing }
CAStudent >> printOn: aStream [
	aStream
			nextPutAll: (self number asString); cr;
			nextPutAll: self name 
]
