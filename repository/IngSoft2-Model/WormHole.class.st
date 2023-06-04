Class {
	#name : #WormHole,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
WormHole >> applyTo: aGameBoard [ 
	| turn aPlayer |
	turn := aGameBoard turn.
	aPlayer := aGameBoard player: turn.
	aPlayer changePosition: (aPlayer isAtPosition -4).
	
]

{ #category : #action }
WormHole >> repeatFor: aShipPosition [ 
	|actualPosition|
	actualPosition := aShipPosition isAtPosition.
	aShipPosition changePosition: (actualPosition -4).
]

{ #category : #action }
WormHole >> repeatFor: aShipPosition using: aGameBoard [ 
	|actualPosition|
	actualPosition := aShipPosition isAtPosition.
	aShipPosition changePosition: (actualPosition -4).
]
