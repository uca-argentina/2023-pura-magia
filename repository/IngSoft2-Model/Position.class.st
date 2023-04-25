Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'ship',
		'cellNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Position class >> with: aPlayer [ 
	^ (self new) initializeWith: aPlayer .
]

{ #category : #changes }
Position >> changePosition: anInteger [ 
	cellNumber := cellNumber + anInteger 
]

{ #category : #initialization }
Position >> initializeWith: aShip [ 
	ship  := aShip .
	cellNumber := 0 .
]

{ #category : #validation }
Position >> isAtPosition [
	^ cellNumber 
]

{ #category : #'tests - validation' }
Position >> isTheSameAs: aShip [ 
	^ aShip = ship .
]

{ #category : #validations }
Position >> shipInPosition [
	^ship
]
