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

{ #category : #action }
ShipsGame >> applyCard: aTypeOfCard to: chosenPlayer askedBy: aPlayer [ 
	(numberOfPlayer = aPlayer )ifTrue: [ 
		(self verify: aTypeOfCard IsInHand: aPlayer) ifTrue:[
			gameboard store: aTypeOfCard applyTo: chosenPlayer.
			gameboard applyCard: aTypeOfCard  to: chosenPlayer.
			].
		
		 ]
]

{ #category : #creation }
ShipsGame >> create: anAmountOfPlayers [
	|playersCollection count|
	count:=1.
	playersCollection := OrderedCollection new.
	[ count <= anAmountOfPlayers  ] whileTrue: [ 
		playersCollection add: (Player with: count) .
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
ShipsGame >> ranking [
	^gameboard ranking
]

{ #category : #validation }
ShipsGame >> result [
	^ result
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
ShipsGame >> throwNextPlayer [
	numberOfPlayer <= amountOfPlayers ifTrue:  [ 
		gameboard turnOf: numberOfPlayer.
		numberOfPlayer := numberOfPlayer + 1.
		 ]ifFalse: [ 
			numberOfPlayer := 1.
			gameboard turnOf: numberOfPlayer. ]
]

{ #category : #validation }
ShipsGame >> verify: aTypeOfCard IsInHand: aNumberOfPlayer [ 
	|player counter anArrayOfCards selectedCard|
	counter :=1.
	player :=gameboard player: aNumberOfPlayer. 
	anArrayOfCards :=player cardsInHand.
	
	[counter <= anArrayOfCards  size ] whileTrue: [ 
		((anArrayOfCards at: counter ) isKindOf: aTypeOfCard )ifTrue: [ 
			 anArrayOfCards remove: (anArrayOfCards at: counter).
			^true.
			 ].
		
		 ].
	^false.
]

{ #category : #validation }
ShipsGame >> winner [

	^ gameboard winner
]
