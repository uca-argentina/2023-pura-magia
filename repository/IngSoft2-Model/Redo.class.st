Class {
	#name : #Redo,
	#superclass : #Object,
	#instVars : [
		'cardToRedo',
		'chosenShip'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Redo >> apply: aGameBoard [
	(cardToRedo isKindOf: Acceleration) ifTrue: [ 
			cardToRedo apply: aGameBoard .	
		 ] ifFalse: [ 
			cardToRedo selected: chosenShip .
			cardToRedo apply: aGameBoard .	
		 ].

	 
]

{ #category : #validation }
Redo >> permanent: aShipsGame verify: aNumberOfShip [
	(cardToRedo permanent) ifFalse: [ 
		(aShipsGame verify: self IsInHand: aNumberOfShip) ifTrue: [ 
			aShipsGame chosenCard: self.
			aShipsGame cardDirectedTo: aNumberOfShip.
			 ] ].

	(cardToRedo permanent) ifTrue: [
		(aShipsGame playerTurn: aNumberOfShip) ifTrue:[
		(aShipsGame verify: self IsInHand: aNumberOfShip) ifTrue: [ 
			aShipsGame chosenCard: self ] ] ].
]

{ #category : #action }
Redo >> redo: lastUsedCard [ 
	cardToRedo := lastUsedCard .
]

{ #category : #validation }
Redo >> redoCard [
	^cardToRedo .
]

{ #category : #instance }
Redo >> selected: aShipPosition [ 
	chosenShip := aShipPosition .
]
