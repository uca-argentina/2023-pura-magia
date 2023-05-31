Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedUp >> applyTo: aGameBoard [ 
	| turn aPlayer |
	turn := aGameBoard turn.
	aPlayer := aGameBoard player: turn.
	aPlayer changePosition: (aPlayer isAtPosition +4).
]
