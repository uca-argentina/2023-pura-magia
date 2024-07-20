Class {
	#name : #DrawEffect,
	#superclass : #Object,
	#instVars : [
		'stateReverse',
		'shipsGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DrawEffect class >> with: aShipsGame [ 
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
DrawEffect >> applyTo: aGameBoard for: aShip [
	|numberOfShip|
	numberOfShip:= aShip numberOfShip .
	((self shipGame) crupier) designateRandomCardTo: numberOfShip using: aGameBoard.
]

{ #category : #initialization }
DrawEffect >> initializeWith: aShipsGame [ 
	shipsGame := aShipsGame .
	stateReverse := false.
]

{ #category : #action }
DrawEffect >> shipGame [
	^shipsGame.
]
