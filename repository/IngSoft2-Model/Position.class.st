Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'player',
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Position class >> with: aPlayer [ 
	^ (self new) initializeWith: aPlayer .
]

{ #category : #changes }
Position >> changePosition: anInteger [ 
	position := position + anInteger 
]

{ #category : #initialization }
Position >> initializeWith: aPlayer [ 
	player := aPlayer .
	position := 0 .
]

{ #category : #validations }
Position >> is [
	self shouldBeImplemented.
]

{ #category : #'tests - validation' }
Position >> is: aPlayer [ 
	^ aPlayer = player .
]

{ #category : #validation }
Position >> isAtPosition [
	^ position 
]
