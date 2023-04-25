Class {
	#name : #LoadedDice,
	#superclass : #Object,
	#instVars : [
		'numbers',
		'round'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
LoadedDice class >> with: numbers [ 
	^(self new) initializeWith: numbers
]

{ #category : #initialization }
LoadedDice >> initializeWith: aNumbers [
	numbers := aNumbers.
	round := 0.
]

{ #category : #action }
LoadedDice >> throw [
	|result|
	round := round +1.
	(round > numbers size) ifTrue: [ 
		round :=1 ].
	result := numbers at: round.
	^(result  )
]
