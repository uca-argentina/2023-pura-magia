Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'result',
		'gameboard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> initializeEmpty [
	^(self new) initializeWith: 'The Game does not have a winner'
]

{ #category : #creation }
Game >> addShipTo: playersCollection andIncrease1On: count [

	playersCollection add: Ship new.
	^ count + 1
]

{ #category : #creation }
Game >> addToCollectionTheRequired: amountOfPlayers [

	| playersCollection count |
	count := 1.
	playersCollection := OrderedCollection new.
	[ self the: count isLowerOrEqualThan: amountOfPlayers ] whileTrue: [ 
		count := self addShipTo: playersCollection andIncrease1On: count ].
	^ playersCollection
]

{ #category : #creation }
Game >> create: amountOfPlayers [

	| playersCollection |
	playersCollection := self addToCollectionTheRequired: amountOfPlayers.
	^ playersCollection
]

{ #category : #intialization }
Game >> initializeWith: aResult [ 
	result := aResult.
	gameboard := nil.
]

{ #category : #validations }
Game >> playUntilWinner: aDice [

	[ self thereIsNoWinnerYet ] whileTrue: [ 
		gameboard playRoundWith: aDice ].
	result := 'The Game has ended'
]

{ #category : #validation }
Game >> result [
	^ result
]

{ #category : #start }
Game >> start [
	result := 'The Game does not have a winner' 
]

{ #category : #starting }
Game >> startwith: aPlayer [ 
	result:= aPlayer 
]

{ #category : #starting }
Game >> startwith: amountOfPlayers and: aGameboard [
|players|
gameboard := aGameboard .
players := self create: amountOfPlayers.
aGameboard fillPlayers: players  .
"((aGameboard player aPlayer) = (aGameboard amountOfCells)) ifTrue: [result:= aPlayer  ]."
	 
]

{ #category : #creation }
Game >> the: count isLowerOrEqualThan: amountOfPlayers [

	^ count <= amountOfPlayers
]

{ #category : #validations }
Game >> thereIsNoWinnerYet [
	^ gameboard winner = false
]

{ #category : #validating }
Game >> winner [
	^gameboard winner
]
