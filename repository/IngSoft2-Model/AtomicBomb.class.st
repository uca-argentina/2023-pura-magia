Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBomb >> applyTo: aGameBoard for: aShip [

	| newShipPosition ship lap parsec |
	1 to: aGameBoard amountOfPlayers do: [ :index |
		ship := aGameBoard player: index.
		lap := ship shipPosition isAtLap.
		parsec := ship shipPosition isAtParsec.
		newShipPosition := ShipPosition createWith: 0 at: lap and: parsec.
		ship changePosition: newShipPosition ].
	^self.
]
