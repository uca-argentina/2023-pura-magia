Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#instVars : [
		'amountOfCells',
		'stateReverse'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpeedUp class >> createNew [
	^(self new) initializeWith: 4
]

{ #category : #action }
SpeedUp >> applyTo: aGameBoard for: aShip [  
	|newCell newShipPosition shipPosition|
	newCell := (((aShip shipPosition ) isAtPosition)+ amountOfCells).
	shipPosition := aShip shipPosition .
	newShipPosition:= aGameBoard verifyCellsOf: shipPosition   at: newCell .
	aShip  changePosition: newShipPosition.
]

{ #category : #initialization }
SpeedUp >> changeState: aStateToChange [ 
	stateReverse := aStateToChange.
	amountOfCells := amountOfCells negated.
]

{ #category : #initialization }
SpeedUp >> initializeWith: anAmountOfCells [ 
	amountOfCells:=anAmountOfCells .
	stateReverse := false.
]

{ #category : #accessing }
SpeedUp >> stateReverse [
	^ stateReverse
]
