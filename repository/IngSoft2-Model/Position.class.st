Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'ship',
		'cellNumber',
		'actualLap',
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Position class >> with: aPlayer [ 
	^ (self new) initializeWith: aPlayer .
]

{ #category : #action }
Position >> changeParsecs: anAmountOfParsecs [ 
	parsecs := anAmountOfParsecs.
]

{ #category : #changes }
Position >> changePosition: anInteger [ 
	cellNumber := anInteger 
]

{ #category : #action }
Position >> decreaseLap [
	actualLap := actualLap -1.
]

{ #category : #changes }
Position >> increaseLap [
	actualLap:=actualLap +1.
]

{ #category : #initialization }
Position >> initializeWith: aShip [ 
	ship  := aShip .
	cellNumber := 0 .
	actualLap :=1.
	parsecs := 0.
]

{ #category : #validation }
Position >> isAtLap [
	^actualLap.
]

{ #category : #validation }
Position >> isAtParsec [
	^parsecs.
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
