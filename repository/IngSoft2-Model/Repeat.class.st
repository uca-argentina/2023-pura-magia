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
Repeat >> permanent [
	^false.
]

{ #category : #intance }
Repeat >> selected: aShipPosition [ 
	chosenShip:= aShipPosition.
]
