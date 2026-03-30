Class {
	#name : 'CARubricsSet',
	#superclass : 'Object',
	#instVars : [
		'rawData'
	],
	#category : 'Canvasinator',
	#package : 'Canvasinator'
}

{ #category : 'as yet unclassified' }
CARubricsSet class >> on: aRawData [ 
	^ self new
		rawData:aRawData;
		yourself
]

{ #category : 'as yet unclassified' }
CARubricsSet >> description [
	^ rawData at: 'description'
]

{ #category : 'as yet unclassified' }
CARubricsSet >> gtDescriptionFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Description';
		priority: 10;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self totalDescriptionRoped ];
		actionUpdateButton
]

{ #category : 'as yet unclassified' }
CARubricsSet >> long_description [
	^ rawData at: 'long_description'
]

{ #category : 'as yet unclassified' }
CARubricsSet >> printOn: aStream [

	aStream nextPutAll: self totalDescriptionRoped
]

{ #category : 'as yet unclassified' }
CARubricsSet >> rawData: aRawData [ 
	rawData := aRawData
]

{ #category : 'as yet unclassified' }
CARubricsSet >> totalDescriptionRoped [
	^ (self description asRopedText foreground: Color orange darker)
		, ':' asRopedText , Character lf asString asRopedText
		, self long_description asRopedText
]
