Class {
	#name : #Redo,
	#superclass : #Object,
	#instVars : [
		'cardToRedo',
		'chosenShip',
		'shipsGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Redo class >> with: aShipsGame [
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Redo >> apply: aGameBoard [

	(cardToRedo isKindOf: Acceleration)
		ifTrue: [  ]
		ifFalse: [ cardToRedo selected: chosenShip ].
	cardToRedo apply: aGameBoard.
	^ cardToRedo
]

{ #category : #action }
Redo >> cancellationFrom: aNumberOfPlayer to: aChosenNumberOfPlayer canceled: aCard [
	|lastCardUsedInGame aGameboard|
	lastCardUsedInGame := shipsGame lastUsedCard.
	aGameboard := shipsGame gameboard.
	lastCardUsedInGame selected: aChosenNumberOfPlayer .
	lastCardUsedInGame  canceled: aCard.
	lastCardUsedInGame apply: aGameboard .
]

{ #category : #action }
Redo >> from: aNumberOfShip [
	shipsGame  chosen: self from: aNumberOfShip.
	shipsGame  applyChosenCard.
]

{ #category : #action }
Redo >> from: aNumberOfShip to: aChosenNumberOfShip [
	shipsGame chosen: self from: aNumberOfShip.
	shipsGame cardDirectedTo: aChosenNumberOfShip.
	shipsGame applyChosenCard.
]

{ #category : #initialization }
Redo >> initializeWith: aShipsGame [ 
	shipsGame := aShipsGame .
]

{ #category : #validation }
Redo >> permanent: aShipsGame verify: aNumberOfShip [
	(cardToRedo permanent) ifFalse: [ 
		(aShipsGame verify: self IsInHand: aNumberOfShip) ifTrue: [ 
			aShipsGame chosenCard: self.
			aShipsGame cardDirectedTo: aNumberOfShip.
			 ] ].

	(cardToRedo permanent) ifTrue: [
		(aShipsGame playerTurn: aNumberOfShip) ifTrue:[
		(aShipsGame verify: self IsInHand: aNumberOfShip) ifTrue: [ 
			aShipsGame chosenCard: self ] ] ].
]

{ #category : #action }
Redo >> redo: lastUsedCard [ 
	cardToRedo := lastUsedCard .
]

{ #category : #instance }
Redo >> selected: aShipPosition [ 
	chosenShip := aShipPosition .
]
