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
	|index turn newCell newShipPosition shipPosition|
	index := 1.
	turn:= aGameBoard turn .
	[index <= aGameBoard amountOfPlayers] whileTrue: [ 
		((aGameBoard player:  index) = (aGameBoard player:  turn)) ifFalse: [ 
			shipPosition:= (aGameBoard player:  index)shipPosition .
			newCell := (shipPosition ) isAtPosition + amountOfCells.
			newShipPosition:= aGameBoard verifyCellsOf: shipPosition    at: newCell .
			(aGameBoard player:  index) changePosition: newShipPosition .
			 ].
		index := index + 1. 
		]
]

{ #category : #initialization }
MoonWalk >> initializeWith: anAmountOfCells [ 
	amountOfCells:= anAmountOfCells .
]

{ #category : #action }
MoonWalk >> repeatFor: aChosenShip using: aGameBoard [ 
	|index  newCell shipPosition newShipPosition|
	index := 1.
	
	[index <= aGameBoard amountOfPlayers] whileTrue: [ 
		((aGameBoard player:  index) = (aChosenShip )) ifFalse: [ 
			newCell :=( (aGameBoard player:  index)shipPosition ) isAtPosition + amountOfCells.
			shipPosition:= (aGameBoard player:  index)shipPosition.
			newShipPosition:= aGameBoard verifyCellsOf: shipPosition   at: newCell .
			(aGameBoard player:  index) changePosition: newShipPosition.
			 ].
		index := index + 1. 
		]
]
