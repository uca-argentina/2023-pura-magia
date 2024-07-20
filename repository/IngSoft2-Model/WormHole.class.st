Class {
	#name : #WormHole,
	#superclass : #Object,
	#instVars : [
		'stateReverse',
		'amountOfCells'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
WormHole class >> createNew [
	^(self new) initializeWith: -4
]

{ #category : #action }
WormHole >> applyTo: aGameBoard for: aChosenShip [
	|newCell newShipPosition shipPosition|
	newCell := (((aChosenShip shipPosition ) isAtPosition)+ amountOfCells ).
	shipPosition := aChosenShip shipPosition .
	newShipPosition:= aGameBoard verifyCellsOf: shipPosition   at: newCell .
	aChosenShip  changePosition: newShipPosition.
]

{ #category : #initialization }
WormHole >> changeState: aStateToChange [ 
	stateReverse := aStateToChange.
	amountOfCells := amountOfCells negated.
]

{ #category : #initialization }
WormHole >> initializeWith: anAmountOfCells [ 
	amountOfCells:=anAmountOfCells .
	stateReverse := false.
]

{ #category : #initialization }
WormHole >> stateReverse [
	^stateReverse
]
