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
