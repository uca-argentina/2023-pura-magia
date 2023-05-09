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
Game >> create: amountOfPlayers [
	|playersCollection count|
	count:=1.
	playersCollection := OrderedCollection new.
	[ count <= amountOfPlayers  ] whileTrue: [ 
		playersCollection add: Ship new.
		count :=count +1
	 ].
^playersCollection.
]

{ #category : #intialization }
Game >> initializeWith: aResult [

	result := aResult.
	gameboard := nil
]

{ #category : #validations }
Game >> playUntilWinner: aDice [

	[ gameboard winner = false ] whileTrue: [ 
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

	| players |
	gameboard := aGameboard.
	players := self create: amountOfPlayers.
	aGameboard fillWith: players
]

{ #category : #validating }
Game >> winner [

	^ gameboard winner
]
