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
	[counter<= aGameBoard amountOfPlayers ]whileTrue: [ 
		((aGameBoard player: counter) = chosenShip )ifTrue: [ 
					lastEffectUsed repeatFor: chosenShip. 
					aGameBoard verifyAllPositions.
			
			 ].
		counter := counter +1.
	 ]
	
	
	
]

{ #category : #validation }
Repeat >> permanent [
	^false.
]

{ #category : #intance }
Repeat >> selected: aShipPosition [ 
	chosenShip:= aShipPosition.
]
