Class {
	#name : #Reverse,
	#superclass : #Object,
	#instVars : [
		'shipsGame',
		'atargetCell'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Reverse class >> with: aShipsGame [ 
	^(self new) initializeWith: aShipsGame .
]

{ #category : #'instance creation' }
Reverse >> from: aNumberOfShip to: anEffectCell [
	shipsGame chosen: self from: aNumberOfShip.
	shipsGame cardDirectedToCell: anEffectCell.
	shipsGame applyChosenCard.
]

{ #category : #initialization }
Reverse >> initializeWith: aShipsGame [ 
	shipsGame := aShipsGame .
]

{ #category : #testing }
Reverse >> isOnlyForPlayers [
	^false.
]

{ #category : #validation }
Reverse >> permanent: aShipsGame verify: aNumberOfShip [ 
		(aShipsGame playerTurn: aNumberOfShip) ifTrue:[	
	(aShipsGame verify: self IsInHand: aNumberOfShip) ifTrue: [ 
			aShipsGame chosenCard: self ]. ] .
]

{ #category : #accessing }
Reverse >> selected: targetCell [ 
	atargetCell := targetCell.
	
	
]
