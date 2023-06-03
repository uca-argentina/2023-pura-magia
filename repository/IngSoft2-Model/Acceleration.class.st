Class {
	#name : #Acceleration,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Acceleration >> amountToChange [
	^1.
]

{ #category : #action }
Acceleration >> apply: aGameBoard [ 
	|counter|
	counter := 1.
	[ counter <= aGameBoard amountOfPlayers ]whileTrue: [ 
			(aGameBoard player: counter)store: (self).
			counter := counter +1.
	 ]
]

{ #category : #validation }
Acceleration >> permanent [
	^true.
]
