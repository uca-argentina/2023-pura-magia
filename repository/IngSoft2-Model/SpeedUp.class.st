Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedUp >> applyTo: aGameBoard [ 
	| turn shipPosition newCell newShipPosition|
	turn := aGameBoard turn.
	shipPosition := (aGameBoard player: turn)shipPosition .
	newCell:=(shipPosition isAtPosition +4).
	newShipPosition:= aGameBoard verifyCellsOf: shipPosition   at: newCell .
	(aGameBoard player: turn) changePosition: newShipPosition.
]

{ #category : #action }
SpeedUp >> repeatFor: aShip using: aGameBoard [ 
	|newCell newShipPosition shipPosition|
	newCell := (((aShip shipPosition ) isAtPosition)+4).
	shipPosition := aShip shipPosition .
	newShipPosition:= aGameBoard verifyCellsOf: shipPosition   at: newCell .
	aShip  changePosition: newShipPosition.
]
