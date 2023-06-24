Class {
	#name : #Acceleration,
	#superclass : #Object,
	#instVars : [
		'shipsGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Acceleration class >> amountToChange [
	^1.
]

{ #category : #initialization }
Acceleration class >> with: aShipsGame [ 
 ^(self new) initializeWith: aShipsGame.
]

{ #category : #action }
Acceleration >> apply: aGameBoard [
	aGameBoard store: self.
	^(self)
]

{ #category : #action }
Acceleration >> applyToAllFrom: aNumberOfShip [ 
	shipsGame chosen: self from: aNumberOfShip.
	shipsGame applyChosenCard.
]

{ #category : #initialization }
Acceleration >> initializeWith: aShipsGame [ 
	shipsGame := aShipsGame .
]

{ #category : #validation }
Acceleration >> permanent [
	^true.
]

{ #category : #validation }
Acceleration >> permanent: aShipsGame verify: aNumberOfShip [ 
	(aShipsGame playerTurn: aNumberOfShip) ifTrue:[	
	(aShipsGame verify: self IsInHand: aNumberOfShip) ifTrue: [ 
			aShipsGame chosenCard: self ]. ] .
]
