Class {
	#name : #ShipsGame,
	#superclass : #Object,
	#instVars : [
		'result',
		'gameboard',
		'numberOfPlayer',
		'amountOfPlayers',
		'chosenCard',
		'lastUsedCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
ShipsGame class >> initializeEmpty [
	^(self new) initializeWith: 'The Game does not have a winner'
]

{ #category : #action }
ShipsGame >> applyChosenCard [
	lastUsedCard := chosenCard apply: gameboard .
]

{ #category : #assignments }
ShipsGame >> cardDirectedTo: aNumberOfShip [ 
	chosenCard selected: (gameboard player: aNumberOfShip) 
]

{ #category : #validation }
ShipsGame >> chosen: aCard from: aNumberOfShip [

	| aShip |
	aShip := gameboard player: aNumberOfShip.
	(aShip shipCards )  fillRedoWith: lastUsedCard.

	aCard permanent: self verify: aNumberOfShip .
	
]

{ #category : #instance }
ShipsGame >> chosenCard: aCard [ 
	chosenCard := aCard .
]

{ #category : #creation }
ShipsGame >> create: anAmountOfPlayers [

	| playersCollection |
	playersCollection := OrderedCollection new.

	1 to: anAmountOfPlayers do: [ :count | 
	playersCollection add: (Ship with: count) ].

	^ playersCollection
]

{ #category : #action }
ShipsGame >> gameboard [
	^ gameboard
]

{ #category : #intialization }
ShipsGame >> initializeWith: aResult [

	result := aResult.
	gameboard := nil.
	numberOfPlayer := 1.
	amountOfPlayers := 0.
]

{ #category : #action }
ShipsGame >> lastUsedCard [
	^ lastUsedCard
]

{ #category : #validation }
ShipsGame >> playerTurn: aNumberOfShip [
	aNumberOfShip = numberOfPlayer
		ifFalse: [ 
		Error signal: 'Cannot use permanent card when its not their turn' ]
		ifTrue: [ ^ true ]
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
		((numberOfPlayer := numberOfPlayer + 1)> amountOfPlayers )ifTrue: [ 
			numberOfPlayer := 1.
			 ].
		 ]ifFalse: [ 
			numberOfPlayer := 1.
			gameboard turnOf: numberOfPlayer.
			numberOfPlayer := numberOfPlayer + 1.
			 ]
]

{ #category : #validation }
ShipsGame >> verify: aCard IsInHand: aNumberOfShip [

	| anArrayOfCards aShipCards |
	aShipCards := (gameboard player: aNumberOfShip) shipCards.

	anArrayOfCards := aShipCards cardsInHand.

	(anArrayOfCards includes: aCard) ifTrue: [ 
		anArrayOfCards remove: aCard.
		^ true ].
	^ false
]

{ #category : #validation }
ShipsGame >> winner [

	^ gameboard winner
]
