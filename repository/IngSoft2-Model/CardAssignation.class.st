Class {
	#name : #CardAssignation,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CardAssignation >> applyTo: aGameBoard for: aShip [
	|numberOfShip|
	
	numberOfShip:= aShip numberOfShip .
	aGameBoard designateRandomCardTo: numberOfShip .
	
]
