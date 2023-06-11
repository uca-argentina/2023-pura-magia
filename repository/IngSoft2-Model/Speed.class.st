Class {
	#name : #Speed,
	#superclass : #Object,
	#instVars : [
		'chosenPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Speed >> amountToChange [
	^1.
]

{ #category : #action }
Speed >> apply: aGameBoard [ 
	(aGameBoard player: (chosenPlayer numberOfShip)) store: (self).
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
