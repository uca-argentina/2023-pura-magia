Class {
	#name : #WormHole,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
WormHole >> applyTo: aGameBoard for: aChosenShip [
	|newCell newShipPosition shipPosition|
	newCell := (((aChosenShip shipPosition ) isAtPosition)-4).
	shipPosition := aChosenShip shipPosition .
	newShipPosition:= aGameBoard verifyCellsOf: shipPosition   at: newCell .
	aChosenShip  changePosition: newShipPosition.
	^self.
]
