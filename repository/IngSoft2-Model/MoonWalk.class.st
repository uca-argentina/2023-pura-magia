Class {
	#name : #MoonWalk,
	#superclass : #Object,
	#instVars : [
		'amountOfCells'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
MoonWalk class >> with: anAmountOfCells [ 
	^(self new) initializeWith: anAmountOfCells.
]

{ #category : #action }
MoonWalk >> applyTo: aGameBoard [

	| turn newCell newShipPosition shipPosition |
	turn := aGameBoard turn.
	1 to: aGameBoard amountOfPlayers do: [ :index | 
		(aGameBoard player: index) = (aGameBoard player: turn) ifFalse: [ 
			shipPosition := (aGameBoard player: index) shipPosition.
			newCell := shipPosition isAtPosition + amountOfCells.
			newShipPosition := aGameBoard verifyCellsOf: shipPosition at: newCell.
			(aGameBoard player: index) changePosition: newShipPosition ] ]
]

{ #category : #initialization }
MoonWalk >> initializeWith: anAmountOfCells [ 
	amountOfCells:= anAmountOfCells .
]

{ #category : #action }
MoonWalk >> repeatFor: aChosenShip using: aGameBoard [

	| newCell shipPosition newShipPosition |
	1 to: aGameBoard amountOfPlayers do: [ :index | 
		(aGameBoard player: index) = aChosenShip ifFalse: [ 
			newCell := (aGameBoard player: index) shipPosition isAtPosition + amountOfCells.
			shipPosition := (aGameBoard player: index) shipPosition.
			newShipPosition := aGameBoard verifyCellsOf: shipPosition at: newCell.
			(aGameBoard player: index) changePosition: newShipPosition ] ]
]
