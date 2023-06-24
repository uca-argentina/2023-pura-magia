Class {
	#name : #CardAssignation,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CardAssignation >> applyTo: aGameBoard [ 
	|numberOfShip|
	
	numberOfShip:= aGameBoard turn.
	aGameBoard designateRandomCardTo: numberOfShip .
	
]
