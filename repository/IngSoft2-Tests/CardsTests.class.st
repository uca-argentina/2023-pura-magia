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
	
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 1 andGameboardWith: 8 and: 2.
	
	player:= 1.

	aGameBoard add: overload to: player.
	aGameBoard add: overload to: player.

	self assert: ((((aGameBoard player: 1) cardsInHand ) at: 1) isKindOf: Overload).
	self assert: ((((aGameBoard player: 1) cardsInHand ) at: 2) isKindOf: Overload).
	
	
]

{ #category : #tests }
CardsTests >> test007PlayerStartTheGameWith2OverloadCardsThenApplyEffect [
	| overload  player player2 |

	overload := Overload  new.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.

	
	player:=1.
	player2:=2.

	
	aGameBoard add: overload to: player.
	aGameBoard add: overload to: player.
	
	aGameBoard add: overload to: player2.
	aGameBoard add: overload to: player2.

	aGame chosen: overload from: player.
	aGame cardDirectedTo: player2.
	aGame applyChosenCard.
	
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 6 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test008PlayerStartTheGameWith2OSpeedCardsThenApplyEffectToThemSelf [
	| speed  player player2 |

	speed := Speed  new.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	player:= 1.
	player2:=2.

	aGameBoard add: speed to: player.
	aGameBoard add: speed to: player.
	
	aGameBoard add: speed to: player2.
	aGameBoard add: speed to: player2.

	aGame throwNextPlayer .
	aGame throwNextPlayer .
	
	aGame chosen: speed from: player.
	aGame cardDirectedTo: player.
	aGame applyChosenCard.
	
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 7 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test009PlayerStartTheGameWith2OAcelerationCardsThenApplyEffect [
	| acceleration   player player2 |
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	acceleration  := Acceleration   new.
	player:= 1.
	player2:=2.

	aGameBoard add: acceleration to: player.
	aGameBoard add: acceleration  to: player.
	
	aGameBoard add: acceleration to: player2.
	aGameBoard add: acceleration to: player2.
	
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	aGame chosen: acceleration from: player.
	
	aGame applyChosenCard.
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 7 .
	self assert: (aGameBoard checkLapOf:   (aGameBoard player: 1)) equals: 1 .
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 3 .
	self assert: (aGameBoard checkLapOf:   (aGameBoard player: 2)) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test010PlayWithCancelletionCardForOverload [
	| overload  player player2  cancellation|
	cancellation:= Cancellation new.
	overload := Overload  new.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.

	
	player:= 1.
	player2:=2.

	
	aGameBoard add: overload to: player.
	aGameBoard add: overload to: player.
	
	aGameBoard add: overload to: player2.
	aGameBoard add: cancellation to: player2.

	aGame chosen: overload from: player.
	aGame cardDirectedTo: player2.
	aGame applyChosenCard.
	
	aGame chosen: cancellation from: player2.
	cancellation canceled: overload.
	aGame cardDirectedTo: player2.
	aGame applyChosenCard.

	
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	
	aGame throwNextPlayer .
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test011PlayWithCancelletionCardForSpeed [
	| overload  player player2  cancellation speed|
	cancellation:= Cancellation new.
	speed := Speed  new.
	overload := Overload  new.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.

	
	player:= 1.
	player2:=2.

	aGameBoard add: overload to: player.
	aGameBoard add: speed  to: player.
	
	aGameBoard add: overload to: player2.
	aGameBoard add: cancellation to: player2.

	aGame chosen: speed  from: player.
	aGame cardDirectedTo: player.
	aGame applyChosenCard.
	
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	
	aGame chosen: cancellation from: player2.
	cancellation canceled: speed.
	aGame cardDirectedTo: player.
	aGame applyChosenCard.
	
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 7 .
]

{ #category : #tests }
CardsTests >> test012PlayWithCancelletionCardForAcceleration [
	| overload  player player2  cancellation acceleration|
	cancellation:= Cancellation new.
	acceleration := Acceleration  new.
	overload := Overload  new.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.

	
	player:= 1.
	player2:=2.

	aGameBoard add: overload to: player.
	aGameBoard add: acceleration  to: player.
	
	aGameBoard add: overload to: player2.
	aGameBoard add: cancellation to: player2.

	aGame chosen: acceleration  from: player.
	aGame applyChosenCard.
	
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	
	aGame chosen: cancellation from: player2.
	cancellation canceled: acceleration .
	aGame applyChosenCard.
	
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 7 .
]

{ #category : #tests }
CardsTests >> test013PlayWithRepeatCardEffectSpeedUpToThemself [
	| overload  player player2  cancellation repeat speedUp|
	speedUp := SpeedUp new.
	cancellation:= Cancellation new.
	repeat  := Repeat new.
	overload := Overload  new.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.

	aGameBoard add: speedUp at: 3.
	player:= 1.
	player2:=2.

	aGameBoard add: repeat   to: player.

	aGame throwNextPlayer .
	
	aGame chosen: repeat   from: player.
	aGame cardDirectedTo: player.
	aGame applyChosenCard.
	
	aGame throwNextPlayer .
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 3 .
]

{ #category : #tests }
CardsTests >> test013PlayWithRepeatCardEffectWormHole [
	| overload  player player2  cancellation repeat wormHole|
	wormHole := WormHole  new.
	cancellation:= Cancellation new.
	repeat  := Repeat new.
	overload := Overload  new.
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.

	aGameBoard add: wormHole at: 3.
	
	player:= 1.
	player2:=2.

	aGameBoard add: repeat   to: player.
	
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	aGame chosen: repeat   from: player.
	aGame cardDirectedTo: player2. 
	aGame applyChosenCard.
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 1 .
]
