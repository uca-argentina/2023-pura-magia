Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBomb >> applyTo: aGameBoard [ 
	|index newShipPosition ship lap parsec|
	index := 1.	
	[ index <= aGameBoard amountOfPlayers ] whileTrue: [ 
		ship:=aGameBoard player:  index .
		lap:= (ship shipPosition )isAtLap .
		parsec:= (ship shipPosition )isAtParsec  .
		newShipPosition := ShipPosition createWith: 0 at: lap and: parsec .
		(ship) changePosition: newShipPosition .
		index:= index + 1.
	 ]
]

{ #category : #action }
AtomicBomb >> repeatFor: aChosenShip using: aGameBoard [ 
	|index lap parsec newShipPosition|
	index := 1.	
	[ index <= aGameBoard amountOfPlayers ] whileTrue: [ 
	
		lap:= (aChosenShip  shipPosition )isAtLap .
		parsec:= (aChosenShip  shipPosition )isAtParsec  .
		newShipPosition := ShipPosition createWith: 0 at: lap and: parsec .
		(aChosenShip  ) changePosition: newShipPosition .
		index:= index + 1.
	 ]
]
