Class {
	#name : 'CABase',
	#superclass : 'Object',
	#category : 'Canvasinator-Objects',
	#package : 'Canvasinator',
	#tag : 'Objects'
}

{ #category : 'as yet unclassified' }
CABase >> contextNameRoped [
	^ self contextName asRopedText background: Color lightBlue
]

{ #category : 'as yet unclassified' }
CABase >> gtActionStuBruFor: anAction [
	<gtAction>

	^ anAction button
		  icon: BrGlamorousVectorIcons playinspect;
		  tooltip: 'Studio Brussel';
		  action: [ WebBrowser openOn: 'https://www.youtube.com/watch?v=lCvRP8FhJlI' ]
]

{ #category : 'as yet unclassified' }
CABase >> gtActionWorkMusicFor: anAction [
	<gtAction>

	^ anAction button
		  icon: BrGlamorousVectorIcons play;
		  tooltip: 'Persian';
		  action: [ WebBrowser openOn: 'https://www.youtube.com/watch?v=lCvRP8FhJlI' ]
]
