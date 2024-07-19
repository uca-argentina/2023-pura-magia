Class {
	#name : #Overload,
	#superclass : #Object,
	#instVars : [
		'chosenPlayer',
		'shipsGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Overload class >> with: aShipsGame [
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Overload >> amountToChange [
	^-2.
]

{ #category : #action }
Overload >> apply: aGameBoard [ 
	((aGameBoard player: (chosenPlayer numberOfShip))shipCards ) store: self.
	^(self)
]

{ #category : #action }
Overload >> from: aNumberOfShip applyTo: aChosenNumberOfShip [ 
	shipsGame chosen: self from: aNumberOfShip.
	shipsGame cardDirectedTo: aChosenNumberOfShip.
	shipsGame applyChosenCard.
]

{ #category : #initialization }
Overload >> initializeWith: aShipsGame [
	shipsGame := aShipsGame .
]

{ #category : #testing }
Overload >> isOnlyForPlayers [
	^true.
]

{ #category : #validation }
Overload >> permanent [
	^true.
]

{ #category : #validation }
Overload >> permanent: aShipsGame verify: aNumberOfShip [ 
	(aShipsGame playerTurn: aNumberOfShip) ifTrue:[	
	(aShipsGame verify: self IsInHand: aNumberOfShip) ifTrue: [ 
			aShipsGame chosenCard: self ]. ] .
]

{ #category : #instance }
Overload >> selected: aShipPosition [ 
	chosenPlayer := aShipPosition .
]
