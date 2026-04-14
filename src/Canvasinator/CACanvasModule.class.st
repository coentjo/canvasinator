Class {
	#name : 'CACanvasModule',
	#superclass : 'Object',
	#instVars : [
		'rawData',
		'rawDatax',
		'parent'
	],
	#category : 'Canvasinator',
	#package : 'Canvasinator'
}

{ #category : 'as yet unclassified' }
CACanvasModule class >> on: rawModuleData [ 
	^ self new
		rawData: rawModuleData;
		yourself
]

{ #category : 'as yet unclassified' }
CACanvasModule class >> on: rawModuleData withParent: aParent [
	^ self new
		rawData: rawModuleData;
		parent: aParent;
		yourself
]

{ #category : 'as yet unclassified' }
CACanvasModule >> courseId [
	^ parent courseId
]

{ #category : 'as yet unclassified' }
CACanvasModule >> gtItemsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Items';
		priority: 9;
		items: self items
]

{ #category : 'as yet unclassified' }
CACanvasModule >> items [
	| url reply |
	url := self items_url.
	reply := ZnClient new
			url: 'https://fhict.instructure.com/' , 'api/v1/' 
				, 'courses/' , self courseId asString
				, '/modules';
			headerAt: 'Authorization' put: ' Bearer ' , self token;
			get.
	rawDatax := STON fromString: reply.
	^ rawDatax collect: [ :each | CACanvasModule on: each withParent: parent]
]

{ #category : 'as yet unclassified' }
CACanvasModule >> items_url [
	^ rawData at: 'items_url'
]

{ #category : 'as yet unclassified' }
CACanvasModule >> parent: aParent [ 
	parent := aParent
]

{ #category : 'as yet unclassified' }
CACanvasModule >> position [
	^ rawData at: 'position'
]

{ #category : 'as yet unclassified' }
CACanvasModule >> printOn: aStream [
	aStream nextPutAll: (rawData at: 'name') asString
]

{ #category : 'as yet unclassified' }
CACanvasModule >> published [
	^ rawData at: 'published'
]

{ #category : 'as yet unclassified' }
CACanvasModule >> rawData: rawModuleData [ 
	rawData := rawModuleData
]

{ #category : 'as yet unclassified' }
CACanvasModule >> token [
	^ parent token
]
