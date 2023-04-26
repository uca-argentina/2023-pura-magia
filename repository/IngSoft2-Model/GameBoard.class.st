Class {
	#name : #GameBoard,
	#superclass : #Object,
	#instVars : [
		'cells',
		'collectionOfPositions'
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
GameBoard >> checkPositionOf: aShip [

	| anotherShip |
	anotherShip := self positionAtCollectionOf: aShip.
	^ anotherShip isAtPosition
]

{ #category : #creating }
GameBoard >> fillWith: players [
	players do:[:each | collectionOfPositions add: (Position with: each )].
	
]

{ #category : #initialization }
GameBoard >> initializeWith: numberOfCells [ 
	cells := numberOfCells .
	collectionOfPositions := OrderedCollection new.
]

{ #category : #moves }
GameBoard >> move: aPlayer adding: diceResult [ 
	|index|
	index := 1.
	[(collectionOfPositions at: index) isTheSameAs:  aPlayer ] whileFalse: [ 
	 index := index + 1. 
	 ].
	
	(collectionOfPositions at: index ) changePosition: diceResult.
	
	
]

{ #category : #action }
GameBoard >> playRoundWith: aCollectionOfDices [ 
	|index result|
	index := 1.
	result := 0.
	[index  <= collectionOfPositions size and: self winner = false] whileTrue:  [
		result := self throwVariousDices: aCollectionOfDices .	
		self move: ((collectionOfPositions at: index  )  shipInPosition   )  adding: result.
		index  := index  + 1.
		result := 0.
	
	 ].
]

{ #category : #validations }
GameBoard >> playerPosition: aDice [
	^aDice 
]

{ #category : #validating }
GameBoard >> positionAtCollectionOf: aShip [

	| anotherShip counter |
	counter := 1.
	anotherShip := collectionOfPositions at: counter.
	[ anotherShip isTheSameAs: aShip ] whileFalse: [ 
		counter := counter + 1.
		anotherShip := collectionOfPositions at: counter ].
	^ anotherShip
]

{ #category : #positioning }
GameBoard >> shipAt: index [ 
	^ (collectionOfPositions at: index ) shipInPosition
]

{ #category : #action }
GameBoard >> throwDice: aDice [ 
	|counter|
	counter := 1.
	
	[counter <= collectionOfPositions size and: self winner = false] whileTrue:  [ 
	 self move: ((collectionOfPositions at: counter )  shipInPosition  )  adding: aDice.
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

	| counter |
	counter := 1.
	[ 
	(collectionOfPositions at: counter) isAtPosition >= cells or:
		counter >= collectionOfPositions size ] whileFalse: [ 
		counter := counter + 1 ].
	(counter <= collectionOfPositions size and:
		 (collectionOfPositions at: counter) isAtPosition >= cells)
		ifTrue: [ ^ (collectionOfPositions at: counter) shipInPosition ]
		ifFalse: [ ^ false ]
]
