Class {
	#name : #ShipsGame,
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
ShipsGame class >> initializeEmpty [
	^(self new) initializeWith: 'The Game does not have a winner'
]

{ #category : #creation }
ShipsGame >> create: anAmountOfPlayers [
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
ShipsGame >> initializeWith: aResult [

	result := aResult.
	gameboard := nil.
	numberOfPlayer := 1.
	amountOfPlayers := 0.
]

{ #category : #validation }
ShipsGame >> playUntilWinner: aDice [

	[ (gameboard winner) = 0 ] whileTrue: [ 
		gameboard playRoundWith: aDice ].
	result := 'The Game has ended'
]

{ #category : #validation }
ShipsGame >> ranking [
	^gameboard ranking
]

{ #category : #validation }
ShipsGame >> result [
	^ result
]

{ #category : #starting }
ShipsGame >> startwith: aPlayer [ 
	result:= aPlayer 
]

{ #category : #starting }
ShipsGame >> startwith: anAmountOfPlayers and: aGameboard [

	| players |
	gameboard := aGameboard.
	players := self create: anAmountOfPlayers .
	amountOfPlayers := anAmountOfPlayers. 
	aGameboard fillWith: players
]

{ #category : #action }
ShipsGame >> throwNextPlayer: dices [

	numberOfPlayer <= amountOfPlayers ifTrue:  [ 
		gameboard turnOf: numberOfPlayer with: dices.
		numberOfPlayer := numberOfPlayer + 1.
		 ]ifFalse: [ 
			numberOfPlayer := 1.
			gameboard turnOf: numberOfPlayer with: dices. ]
]

{ #category : #validation }
ShipsGame >> winner [

	^ gameboard winner
]
