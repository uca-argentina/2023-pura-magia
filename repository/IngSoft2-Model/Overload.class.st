Class {
	#name : #Overload,
	#superclass : #Object,
	#instVars : [
		'numberOfPlayer',
		'chosenPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Overload >> amountToChange [
	^-2.
]

{ #category : #action }
Overload >> apply: aGameBoard [ 
	(aGameBoard player: (chosenPlayer numberOfShip)) store: self.
]

{ #category : #validation }
Overload >> permanent [
	^true.
]

{ #category : #instance }
Overload >> selected: aShipPosition [ 
	chosenPlayer := aShipPosition .
]
