Class {
	#name : #Overload,
	#superclass : #Object,
	#instVars : [
		'numberOfPlayer',
		'chosenPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Overload >> amountToChange [
	^-2.
]

{ #category : #action }
Overload >> apply: aGameBoard [ 
	(aGameBoard player: (chosenPlayer numberOfShip)) store: self.
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
