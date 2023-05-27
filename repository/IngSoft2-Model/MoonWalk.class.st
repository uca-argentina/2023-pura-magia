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
	|index newPosition turn|
	index := 1.
	turn:= aGameBoard turn .
	[index <= aGameBoard amountOfPlayers] whileTrue: [ 
		((aGameBoard shipAt:  index) = (aGameBoard shipAt:  turn)) ifFalse: [ 
			newPosition := (aGameBoard shipAt:  index) isAtPosition + amountOfCells.
			(aGameBoard shipAt:  index) changePosition: newPosition.
			 ].
		index := index + 1. 
		]
]

{ #category : #initialization }
MoonWalk >> initializeWith: anAmountOfCells [ 
	amountOfCells:= anAmountOfCells .
]
