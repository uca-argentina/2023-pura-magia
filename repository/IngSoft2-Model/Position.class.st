Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'ship',
		'cellNumber',
		'actualLap'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Position class >> with: aPlayer [ 
	^ (self new) initializeWith: aPlayer .
]

{ #category : #changes }
Position >> changeLap [
	actualLap:=actualLap +1.
]

{ #category : #move }
Position >> changeLap: anAmountOfLaps [ 
	anAmountOfLaps < 0 ifTrue: [ 
		actualLap := actualLap-1.
		 ]
	ifFalse:[
		actualLap := actualLap+1.
		]
		
]

{ #category : #changes }
Position >> changePosition: anInteger [ 
	cellNumber := anInteger 
]

{ #category : #initialization }
Position >> initializeWith: aShip [ 
	ship  := aShip .
	cellNumber := 0 .
	actualLap :=1.
]

{ #category : #validation }
Position >> isAtLap [
	^actualLap.
]

{ #category : #validation }
Position >> isAtPosition [
	^ cellNumber 
]

{ #category : #'tests - validation' }
Position >> isTheSameAs: aShip [ 
	^ aShip = ship .
]

{ #category : #changes }
Position >> restartCellPosition [
	cellNumber := 0.
]

{ #category : #validations }
Position >> shipInPosition [
	^ship
]
