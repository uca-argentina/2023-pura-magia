Class {
	#name : #GameBoard,
	#superclass : #Object,
	#instVars : [
		'cells',
		'playersPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
GameBoard class >> with: numberOfCells [ 
	^(self new) initializeWith: numberOfCells 
]

{ #category : #validations }
GameBoard >> PlayerPosition: aDice [
	^aDice 
]

{ #category : #validation }
GameBoard >> amountOfCells [
	^cells 
]

{ #category : #validating }
GameBoard >> checkPosition [
	^ (playersPositions at:1) isAtPosition
]

{ #category : #validating }
GameBoard >> checkPosition: aPlayer [
	|counter aux|
	counter := 1.
	[(playersPositions at: counter) is: aPlayer ] whileFalse: [ 
	aux := (playersPositions at: counter).
	counter := counter + 1. 
	
	 ].


	^ (playersPositions at: counter ) isAtPosition
]

{ #category : #creating }
GameBoard >> fillPlayers: aPlayer [
	aPlayer do:[:each | playersPositions add: (Position with: each )].
	"playersPositions add: (Position with: aPlayer)"
]

{ #category : #initialization }
GameBoard >> initializeWith: numberOfCells [ 
	cells := numberOfCells .
	playersPositions := OrderedCollection new.
]

{ #category : #moves }
GameBoard >> move: aPlayer adding: anInteger [ 
	|playerPosition counter aux|
	counter := 1.
	[(playersPositions at: counter) is: aPlayer ] whileFalse: [ 
	aux := (playersPositions at: counter).
	counter := counter + 1. 
	
	 ].
	playerPosition := (playersPositions at: counter ) changePosition: anInteger.
	
	
]
