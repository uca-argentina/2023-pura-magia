Class {
	#name : #Acceleration,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Acceleration >> amountToChange [
	^1.
]

{ #category : #action }
Acceleration >> apply: aGameBoard [ 
	|counter|
	counter := 1.
	[ counter <= aGameBoard amountOfPlayers ]whileTrue: [ 
			((aGameBoard player: counter)shipCards)  store: (self).
			counter := counter +1.
	 ]
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
