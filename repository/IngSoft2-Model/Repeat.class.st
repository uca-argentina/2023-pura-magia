Class {
	#name : #Repeat,
	#superclass : #Object,
	#instVars : [
		'chosenShip'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Repeat >> apply: aGameBoard [ 
	|lastEffectUsed counter|
	counter:=1.
	lastEffectUsed:= aGameBoard lastEffect  .
	lastEffectUsed repeatFor: chosenShip using: aGameBoard . 
	aGameBoard verifyAllPositions.	
]

{ #category : #validation }
Repeat >> permanent: aShipsGame verify: aNumberOfShip [ 
	(aShipsGame verify: self IsInHand: aNumberOfShip) ifTrue: [ 
			aShipsGame chosenCard: self.
			aShipsGame cardDirectedTo: aNumberOfShip.
			 ].
]

{ #category : #intance }
Repeat >> selected: aShipPosition [ 
	chosenShip:= aShipPosition.
]
