Class {
	#name : #CardsTests,
	#superclass : #TestCase,
	#instVars : [
		'numbers',
		'anotherNumbers',
		'dice1',
		'dice2',
		'arrayOfDices',
		'aGame',
		'cells',
		'numberOfLaps',
		'amountOfPlayers',
		'aGameBoard'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
CardsTests >> setUpGameWith:  anAmountOfPlayers andGameboardWith: anAmountOfCells and: laps [
	aGame:= ShipsGame initializeEmpty.
	
	cells:= anAmountOfCells .
	numberOfLaps:= laps.
	amountOfPlayers := anAmountOfPlayers .
	
	aGameBoard := GameBoard with: cells and: numberOfLaps.
	aGameBoard cellsWith: 0 and: arrayOfDices .
	aGame startwith: amountOfPlayers   and: aGameBoard.
]

{ #category : #running }
CardsTests >> setUpLoadedDiceWith: array1 and: array2 [
	
	numbers := array1 .
	anotherNumbers := array2 .
	dice1 := LoadedDie with: numbers .
	dice2 := LoadedDie with: anotherNumbers .

	arrayOfDices := OrderedCollection new.
	arrayOfDices add: dice1 .
	arrayOfDices add: dice2.
]

{ #category : #tests }
CardsTests >> test001TypeCardOverloadExistsThenAssert [
	
	|cardOverload|
	cardOverload := Overload new.
	self assert: (cardOverload  isKindOf:  Overload ) .
]

{ #category : #tests }
CardsTests >> test002TypeCardASpeedExistsThenAssert [
	
	|cardSpeed|
	cardSpeed := Speed new.
	self assert: (cardSpeed  isKindOf:  Speed ) .
]

{ #category : #tests }
CardsTests >> test003TypeCardAccelerationExistsThenAssert [
	
	|cardAcceleration|
	cardAcceleration  := Acceleration new.
	self assert: (cardAcceleration   isKindOf:  Acceleration ) .
]

{ #category : #tests }
CardsTests >> test004TypeCardCancellationExistsThenAssert [
	
	|cardCancellation|
	cardCancellation := Acceleration new.
	self assert: (cardCancellation isKindOf:  Acceleration ) .
]

{ #category : #tests }
CardsTests >> test005TypeCardRepeatExistsThenAssert [
	
	|cardRepeat|
	cardRepeat  := Repeat new.
	self assert: (cardRepeat  isKindOf:  Repeat ) .
]

{ #category : #tests }
CardsTests >> test006PlayerStartTheGameThen2OverloadCardsAreAsigned [
	| overload  overload2 player |

	overload := Overload  new.
	overload2 := Overload  new.
	player:=1.

	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 1 andGameboardWith: 8 and: 2.

	aGameBoard add: overload to: player.
	aGameBoard add: overload to: player.
	
	self assert: ((((aGameBoard player: 1) cardsInHand ) at: 1) isKindOf: Overload).
	self assert: ((((aGameBoard player: 1) cardsInHand ) at: 2) isKindOf: Overload).
	
	
]

{ #category : #tests }
CardsTests >> test007PlayerStartTheGameWith2OverloadCardsThenApplyEffect [
	| overload  player player2 |

	overload := Overload  new.
	player:=1.
	player2:=2.

	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.

	aGameBoard add: overload to: player.
	aGameBoard add: overload to: player.
	
	aGameBoard add: overload to: player2.
	aGameBoard add: overload to: player2.

	"aGame applyCard: Overload to:player2 askedBy: player."
	
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	
	"self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 3 ."
	
	
	
	
]
