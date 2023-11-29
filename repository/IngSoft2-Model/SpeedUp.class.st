Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedUp >> applyTo: aGameBoard for: aShip [  
	|newCell newShipPosition shipPosition|
	newCell := (((aShip shipPosition ) isAtPosition)+4).
	shipPosition := aShip shipPosition .
	newShipPosition:= aGameBoard verifyCellsOf: shipPosition   at: newCell .
	aShip  changePosition: newShipPosition.
	^self.
]
