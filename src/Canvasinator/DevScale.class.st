Class {
	#name : 'DevScale',
	#superclass : 'Object',
	#instVars : [
		'note'
	],
	#category : 'Canvasinator',
	#package : 'Canvasinator'
}

{ #category : 'as yet unclassified' }
DevScale class >> advanced [
	^ Advanced
]

{ #category : 'accessing' }
DevScale class >> beginning [
	^ Beginning
]

{ #category : 'as yet unclassified' }
DevScale class >> orienting [
	^ Orienting
]

{ #category : 'accessing' }
DevScale class >> proficient [
	^ Proficient
]

{ #category : 'as yet unclassified' }
DevScale class >> undefined [
	^ Undefined
]

{ #category : 'as yet unclassified' }
DevScale >> color [

	^ Color purple
]

{ #category : 'as yet unclassified' }
DevScale >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		stencil: [ 
			BlElement new
				layout: BlFrameLayout new;
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ];
				addChild: (
					BlElement new
						aptitude: BrShadowAptitude new;
						background: Color white;
						constraintsDo: [ :c |
							c frame horizontal alignCenter.
							c frame vertical alignCenter.
							c horizontal fitContent.
							c vertical fitContent ];
						layout: BlLinearLayout horizontal;
						addChild: (BlElement new background: self color; constraintsDo: [:c | c vertical matchParent. c horizontal exact: 30 ]);
						addChild: (BrLabel new
							text: self asString;
							aptitude: BrGlamorousLabelAptitude;
							layout: BlLinearLayout vertical alignCenter;
							padding: (BlInsets all: 10))) ]
]

{ #category : 'accessing' }
DevScale >> note: aString [ 
	note := aString
]
