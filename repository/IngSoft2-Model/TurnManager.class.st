Class {
	#name : #TurnManager,
	#superclass : #Object,
	#instVars : [
		'amountOfPlayers',
		'nextTurn',
		'gameboard',
		'playersWhoLoseTheirNextTurn'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
TurnManager class >> with: anAmountOfPlayers and: aGameBoard [ 
		^(self new) initializeWith: anAmountOfPlayers using: aGameBoard.
]

{ #category : #action }
TurnManager >> applyPenalityOn: aShip [ 
	|actualCell newPosition|
	actualCell := gameboard checkPositionOf: aShip .
	newPosition := (gameboard positionManager ) manageCellsOf: aShip shipPosition at: (actualCell -2).
	aShip changePosition: newPosition.
	playersWhoLoseTheirNextTurn add: aShip numberOfShip.
	
]

{ #category : #action }
TurnManager >> checkIfPlayerLosesTheirTurn: aNumberOfPlayer [ 
	(playersWhoLoseTheirNextTurn includes: aNumberOfPlayer ) ifTrue:[ 
		playersWhoLoseTheirNextTurn remove: aNumberOfPlayer.
		^true
		]ifFalse: [ ^false ]
]

{ #category : #action }
TurnManager >> checkNotCheating: aNumberOfPlayer [ 
	|aShip|
	(nextTurn == aNumberOfPlayer) ifFalse: [ 
		aShip := gameboard player: aNumberOfPlayer.
		self applyPenalityOn:aShip.
		^false.
		]ifTrue:[^true]
]

{ #category : #initialization }
TurnManager >> initializeWith: anAmountOfPlayers using: aGameBoard [ 
	amountOfPlayers := anAmountOfPlayers.
	nextTurn := 1.
	playersWhoLoseTheirNextTurn := OrderedCollection new.
	gameboard := aGameBoard .
]

{ #category : #accessing }
TurnManager >> nextTurn [
	^ nextTurn
]

{ #category : #action }
TurnManager >> throwNext: aNumberOfPlayer [ 
	
	(self checkNotCheating: aNumberOfPlayer) ifTrue:[
		(self checkIfPlayerLosesTheirTurn: aNumberOfPlayer) ifFalse:[
		aNumberOfPlayer <= amountOfPlayers ifTrue:  [ 
		gameboard turnOf: aNumberOfPlayer.
		((nextTurn := aNumberOfPlayer + 1)> amountOfPlayers )ifTrue: [ 
			nextTurn  := 1.
			 ].
		 ]ifFalse: [ 
			nextTurn := 1.
			gameboard turnOf: nextTurn.
			nextTurn := nextTurn + 1.
			 ].
		]ifTrue: [ nextTurn := nextTurn+1 ].
	]
]
