Class {
	#name : #GameBoard,
	#superclass : #Object,
	#instVars : [
		'cells',
		'playersPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
GameBoard class >> with: numberOfCells [ 
	^(self new) initializeWith: numberOfCells 
]

{ #category : #validation }
GameBoard >> amountOfCells [
	^cells 
]

{ #category : #validating }
GameBoard >> checkPosition: aPlayer [
	|counter aux|
	counter := 1.
	[(playersPositions at: counter) is: aPlayer ] whileFalse: [ 
	aux := (playersPositions at: counter).
	counter := counter + 1. 
	
	 ].


	^ (playersPositions at: counter ) isAtPosition
]

{ #category : #creating }
GameBoard >> fillPlayers: aPlayer [
	aPlayer do:[:each | playersPositions add: (Position with: each )].
	"playersPositions add: (Position with: aPlayer)"
]

{ #category : #initialization }
GameBoard >> initializeWith: numberOfCells [ 
	cells := numberOfCells .
	playersPositions := OrderedCollection new.
]

{ #category : #moves }
GameBoard >> move: aPlayer adding: anInteger [ 
	|playerPosition counter aux|
	counter := 1.
	[(playersPositions at: counter) is: aPlayer ] whileFalse: [ 
	aux := (playersPositions at: counter).
	counter := counter + 1. 
	
	 ].
	playerPosition := (playersPositions at: counter ) changePosition: anInteger.
	
	
]

{ #category : #action }
GameBoard >> playRoundWith: aCollectionOfDices [ 
	|counter result|
	counter := 1.
	result := 0.
	
	[counter <= playersPositions size and: self winner = false] whileTrue:  [
		
		result := self throwVariousDices: aCollectionOfDices .	
		self move: ((playersPositions at: counter )  playerInPosition  )  adding: result.
		counter := counter + 1.
		result := 0.
	
	 ].
]

{ #category : #positioning }
GameBoard >> playerIn: aPosition [ 
	^ (playersPositions at: aPosition ) playerInPosition
]

{ #category : #validations }
GameBoard >> playerPosition: aDice [
	^aDice 
]

{ #category : #action }
GameBoard >> throwDice: aDice [ 
	|counter|
	counter := 1.
	
	[counter <= playersPositions size and: self winner = false] whileTrue:  [ 
	 self move: ((playersPositions at: counter )  playerInPosition  )  adding: aDice.
	counter := counter + 1. 
	
	 ].
]

{ #category : #actions }
GameBoard >> throwVariousDices: aCollectionOfDices [
	|counter result|
	counter := 1.
	result := 0.
	
	[ counter <= aCollectionOfDices size ] whileTrue: [ 
			result := result + (aCollectionOfDices at: counter) throw .
			counter := counter + 1.
		 ].
	^ result .
]

{ #category : #validation }
GameBoard >> winner [
	|counter|
	counter := 1.
	 [((playersPositions at: counter) isAtPosition) >= cells or:(counter >= playersPositions size) ] whileFalse: [ 
		counter := counter + 1. 
	
	 ].
((counter <= playersPositions size) and: (((playersPositions at: counter) isAtPosition) >= cells)) ifTrue: [ ^(playersPositions at: counter)playerInPosition. ] 
ifFalse: [ ^false ].
 


	
	
	
]
