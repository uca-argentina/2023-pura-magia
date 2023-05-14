Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'result',
		'gameboard',
		'numberOfPlayer',
		'amountOfPlayers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> initializeEmpty [
	^(self new) initializeWith: 'The Game does not have a winner'
]

{ #category : #creation }
Game >> create: anAmountOfPlayers [
	|playersCollection count|
	count:=1.
	playersCollection := OrderedCollection new.
	[ count <= anAmountOfPlayers  ] whileTrue: [ 
		playersCollection add: (Ship number: count) .
		count :=count +1
	 ].
^playersCollection.
]

{ #category : #intialization }
Game >> initializeWith: aResult [

	result := aResult.
	gameboard := nil.
	numberOfPlayer := 1.
	amountOfPlayers := 0.
]

{ #category : #validations }
Game >> playUntilWinner: aDice [

	[ (gameboard winner) = 0 ] whileTrue: [ 
		gameboard playRoundWith: aDice ].
	result := 'The Game has ended'
]

{ #category : #validation }
Game >> ranking [
	^gameboard ranking
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
Game >> startwith: anAmountOfPlayers and: aGameboard [

	| players |
	gameboard := aGameboard.
	players := self create: anAmountOfPlayers .
	amountOfPlayers := anAmountOfPlayers. 
	aGameboard fillWith: players
]

{ #category : #action }
Game >> throwNextPlayer: dices [

	numberOfPlayer <= amountOfPlayers ifTrue:  [ 
		gameboard turnOf: numberOfPlayer with: dices.
		numberOfPlayer := numberOfPlayer + 1.
		 ]ifFalse: [ 
			numberOfPlayer := 1.
			gameboard turnOf: numberOfPlayer with: dices. ]
]

{ #category : #validating }
Game >> winner [

	^ gameboard winner
]
