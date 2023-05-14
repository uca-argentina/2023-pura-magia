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

{ #category : #move }
MoonWalk >> applyEffect: allPlayers activatedBy: aPlayer [
	|index newPosition|
	index := 1.
	[index <= allPlayers size] whileTrue: [ 
		((allPlayers at: index) = aPlayer) ifFalse: [ 
			newPosition := (allPlayers at: index) isAtPosition + amountOfCells.
			(allPlayers at: index) changePosition: newPosition.
			 ].
		index := index + 1. 
		]
	
]

{ #category : #action }
MoonWalk >> cellsToMove [
	^amountOfCells.
]

{ #category : #validation }
MoonWalk >> destinatary [
	^1.
]

{ #category : #initialization }
MoonWalk >> initializeWith: anAmountOfCells [ 
	amountOfCells:= anAmountOfCells .
]
