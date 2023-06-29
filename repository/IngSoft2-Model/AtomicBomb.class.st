Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBomb >> applyTo: aGameBoard [

	| newShipPosition ship lap parsec |
	1 to: aGameBoard amountOfPlayers do: [ :index |
		ship := aGameBoard player: index.
		lap := ship shipPosition isAtLap.
		parsec := ship shipPosition isAtParsec.
		newShipPosition := ShipPosition createWith: 0 at: lap and: parsec.
		ship changePosition: newShipPosition ]
]

{ #category : #action }
AtomicBomb >> repeatFor: aChosenShip using: aGameBoard [

	| lap parsec newShipPosition |
	1 to: aGameBoard amountOfPlayers do: [ :index | 
		lap := aChosenShip shipPosition isAtLap.
		parsec := aChosenShip shipPosition isAtParsec.
		newShipPosition := ShipPosition createWith: 0 at: lap and: parsec.
		aChosenShip changePosition: newShipPosition ]
]
