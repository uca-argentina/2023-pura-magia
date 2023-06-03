Class {
	#name : #Speed,
	#superclass : #Object,
	#instVars : [
		'chosenPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Speed >> amountToChange [
	^1.
]

{ #category : #action }
Speed >> apply: aGameBoard [ 
	(aGameBoard player: (chosenPlayer numberOfShip)) store: (self).
]

{ #category : #validation }
Speed >> permanent [
	^true
]

{ #category : #selection }
Speed >> selected: aShipPosition [ 
	chosenPlayer := aShipPosition .
]
