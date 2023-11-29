Class {
	#name : #NullEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
NullEffect >> applyTo: aGameBoard for: aShip [ 
	^ aGameBoard lastEffect .
]
