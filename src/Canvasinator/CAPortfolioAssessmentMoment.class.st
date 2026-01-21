Class {
	#name : 'CAPortfolioAssessmentMoment',
	#superclass : 'Object',
	#instVars : [
		'assessItems'
	],
	#category : 'Canvasinator',
	#package : 'Canvasinator'
}

{ #category : 'accessing' }
CAPortfolioAssessmentMoment >> assessItems [
	^ assessItems ifNil: [assessItems := Dictionary new]
]

{ #category : 'as yet unclassified' }
CAPortfolioAssessmentMoment >> gtAssessItemsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Assess';
		priority: 1;
		items: [ self assessItems associations sort: (#key collatedBy: #asString) ];
		children: [ :each | 
			each value isDictionary
				ifTrue: [ each value associations sort: (#key collatedBy: #asString) ]
				ifFalse: [ 
					(each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [ :x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];
		column: 'Key' text: [ :assoc | assoc key ];
"		column: 'Value' text: [ :assoc | assoc value ] weight: 3; "
		column: 'Value' text: [ :assoc | assoc value ] weight: 3;
		column: 'Value' text: [ :assoc | assoc value numValue] weight: 3;
		send: [ :assoc | assoc value gtLiveFor: aView ].
		
	"Implementation note: association sorting uses #collatedBy: to avoid a 'Symbol DNU value: value: error'"
]

{ #category : 'accessing' }
CAPortfolioAssessmentMoment >> learningOutcome: anInteger assess: anAssessItem [ 
	^ self assessItems
		at: anInteger put: anAssessItem
]

{ #category : 'accessing' }
CAPortfolioAssessmentMoment >> lo: anInteger assess: anAssessItem [
	^ self learningOutcome: anInteger assess: anAssessItem
]

{ #category : 'accessing' }
CAPortfolioAssessmentMoment >> lo: anInteger assess: anObject note: aString [ 
	^ self 
		lo: anInteger assess: 
			(anObject new
				note: aString;
				yourself)
]

{ #category : 'accessing' }
CAPortfolioAssessmentMoment >> note: aString [ 
]

{ #category : 'as yet unclassified' }
CAPortfolioAssessmentMoment >> testSimpleMoment [
	<gtExample>

^	CAPortfolioAssessmentMoment new
	lo: 1 assess: Proficient note: 'according to colleague X'; 
	
	lo: 2 assess: Beginning note: 'well, maybe?'  ;
	
	lo: 3 assess: Orienting note: ''  ;
	lo: 4 assess: Beginning  note: ''  ;
	lo: 5 assess: Orienting   note: ''  ;
	lo: 6 assess: Orienting note: ''  ;
	lo: 7 assess: Beginning   note: ''  ;
	lo: 8 assess: Undefined   note: ''  ;
	yourself
]
