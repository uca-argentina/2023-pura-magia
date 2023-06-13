Class {
	#name : #WormHole,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
WormHole >> applyTo: aGameBoard [ 
	| turn aShip newPosition newCell|
	turn := aGameBoard turn.
	aShip := aGameBoard player: turn.
	newCell:=((aShip shipPosition ) isAtPosition) -4.
	newPosition := (aGameBoard  createPositionIn: newCell with:((aShip)shipPosition)).
	(aShip) changePosition: newPosition.
	
]

{ #category : #action }
WormHole >> repeatFor: aShip using: aGameBoard [ 
	|newCell newShipPosition shipPosition|
	newCell := (((aShip shipPosition ) isAtPosition)-4).
	shipPosition := aShip shipPosition .
	newShipPosition:= aGameBoard verifyCellsOf: shipPosition   at: newCell .
	aShip  changePosition: newShipPosition.
]
