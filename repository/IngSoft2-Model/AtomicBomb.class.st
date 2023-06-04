Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBomb >> applyTo: aGameBoard [ 
	|index|
	index := 1.	
	[ index <= aGameBoard amountOfPlayers ] whileTrue: [ 
		(aGameBoard player:  index ) changePosition: 0.
		index:= index + 1.
	 ]
]

{ #category : #action }
AtomicBomb >> repeatFor: aChosenPlayer using: aGameBoard [ 
	|index|
	index := 1.	
	[ index <= aGameBoard amountOfPlayers ] whileTrue: [ 
		(aGameBoard player:  index ) changePosition: 0.
		index:= index + 1.
	 ]
]
