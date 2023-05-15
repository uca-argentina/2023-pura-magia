Class {
	#name : #HyperJump,
	#superclass : #Object,
	#instVars : [
		'anAmountOfParsecsToMove',
		'round'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
HyperJump class >> with: amountOfParsecsToMove [ 
	^(self new)initializeWith: amountOfParsecsToMove
]

{ #category : #action }
HyperJump >> activatedBy: aPlayer with: aNewPosition [ 
	|result|
	round := round +1.
	(round > anAmountOfParsecsToMove  size) ifTrue: [ 
		round :=1 ].
	result := anAmountOfParsecsToMove  at: round.
	aPlayer changeParsecs: result.

]

{ #category : #validation }
HyperJump >> destinatary [
	^0.
]

{ #category : #initialization }
HyperJump >> initializeWith: amountOfParsecsToMove [ 
	anAmountOfParsecsToMove:=amountOfParsecsToMove  .
	round:= 0.
]
