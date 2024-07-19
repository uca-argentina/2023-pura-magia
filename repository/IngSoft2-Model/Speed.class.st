Class {
	#name : #Speed,
	#superclass : #Object,
	#instVars : [
		'chosenPlayer',
		'shipsGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Speed class >> with: aShipsGame [ 
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Speed >> amountToChange [
	^1.
]

{ #category : #action }
Speed >> apply: aGameBoard [ 
	((aGameBoard player: (chosenPlayer numberOfShip))shipCards ) store: (self). 
	^(self)
]

{ #category : #action }
Speed >> from: aNumberOfShip applyTo: aChosenNumberOfShip [ 
	shipsGame chosen: self from: aNumberOfShip.
	shipsGame cardDirectedTo: aChosenNumberOfShip.
	shipsGame applyChosenCard.
]

{ #category : #initialization }
Speed >> initializeWith: aShipsGame [ 
	shipsGame := aShipsGame .
]

{ #category : #testing }
Speed >> isOnlyForPlayers [
	^true.
]

{ #category : #validation }
Speed >> permanent [
	^true
]

{ #category : #validation }
Speed >> permanent: aShipsGame verify: aNumberOfShip [ 
	(aShipsGame playerTurn: aNumberOfShip) ifTrue:[	
	(aShipsGame verify: self IsInHand: aNumberOfShip) ifTrue: [ 
			aShipsGame chosenCard: self ]. ] .
]

{ #category : #selection }
Speed >> selected: aShipPosition [ 
	chosenPlayer := aShipPosition .
]
