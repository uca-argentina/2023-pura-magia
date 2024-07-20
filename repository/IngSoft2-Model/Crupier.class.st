Class {
	#name : #Crupier,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #adding }
Crupier >> add: aCard to: numberOfPlayer using: aGameBoard [
		| aShip |
	aShip :=(aGameBoard player: numberOfPlayer). 
	aShip add: aCard.
]
