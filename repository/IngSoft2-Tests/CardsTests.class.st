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

{ #category : #running }
CardsTests >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [
	self
		should: anErrorBlock 
		raise: anExceptionClass 
		withExceptionDo: [ :error |
			self assert: error messageText equals: anErrorMessage 
			 ].
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
	| overload1  overload2 player |

	overload1 := Overload with: aGame .
	overload2 := Overload with: aGame .
	
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 1 andGameboardWith: 8 and: 2.
	
	player:= 1.

	aGameBoard add: overload1 to: player.
	aGameBoard add: overload2 to: player.

	self assert: (((((aGameBoard player: 1)shipCards ) cardsInHand ) at: 3) isKindOf: Overload).
	self assert: (((((aGameBoard player: 1)shipCards ) cardsInHand ) at: 4) isKindOf: Overload).
	
	
]

{ #category : #tests }
CardsTests >> test007PlayerStartTheGameWith2OverloadCardsThenApplyEffect [
	| overload1 overload2  player player2 |

	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	overload1 := Overload with: aGame  .
	overload2 := Overload with: aGame .
		
	player:=1.
	player2:=2.
	
	aGameBoard add: overload1 to: player.
	aGameBoard add: overload2 to: player2.

	overload1 from: player applyTo: player2. 
	
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 6 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test008PlayerStartTheGameWith2OSpeedCardsThenApplyEffectToThemSelf [
	| speed1 speed2  player player2 |
	
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.

	speed1 := Speed with: aGame.
	speed2 := Speed with: aGame.
	
	player:= 1.
	player2:=2.

	aGameBoard add: speed1 to: player.
	aGameBoard add: speed2 to: player2.

	aGame throwNextPlayer .
	aGame throwNextPlayer .
	
	speed1 from: player applyTo: player.
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 7 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test009PlayerStartTheGameWith2OAcelerationCardsThenApplyEffect [
	| acceleration1 acceleration2 player player2 |
	
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	acceleration1  := Acceleration with: aGame .
	acceleration2  := Acceleration with: aGame .
	
	player:= 1.
	player2:=2.

	aGameBoard add: acceleration1 to: player.
	aGameBoard add: acceleration2 to: player2.
		
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	
	acceleration1 applyToAllFrom: player.
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
	
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	cancellation:= Cancellation with: aGame .
	overload := Overload with: aGame .
	
	player:= 1.
	player2:=2.
	
	aGameBoard add: overload to: player.
	aGameBoard add: cancellation to: player2.

	overload  from: player  applyTo: player2 .
	cancellation from: player2 applyTo: player2 canceled: overload .
	
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 2 .
	
	
	
	
]

{ #category : #tests }
CardsTests >> test011PlayWithCancelletionCardForSpeed [
	|player player2  cancellation speed|
	
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.

	cancellation:= Cancellation with: aGame.
	speed := Speed with: aGame .
	player:= 1.
	player2:=2.

	aGameBoard add: speed  to: player.
	aGameBoard add: cancellation to: player2.
	
	speed from: player applyTo: player . 
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	cancellation from: player2  applyTo: player  canceled: speed .	
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 7 .
]

{ #category : #tests }
CardsTests >> test012PlayWithCancelletionCardForAcceleration [
	| player player2  cancellation acceleration|

	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.

	cancellation:= Cancellation with: aGame .
	acceleration := Acceleration  with: aGame .
	
	player:= 1.
	player2:=2.

	aGameBoard add: acceleration  to: player.
	aGameBoard add: cancellation to: player2.

	acceleration applyToAllFrom: player . 
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	cancellation from: player2 canceled: acceleration .
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 7 .
]

{ #category : #tests }
CardsTests >> test013PlayWithRepeatCardEffectSpeedUpToThemself [
	|player player2   repeat speedUp|
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	speedUp := SpeedUp new.
	repeat  := Repeat with: aGame .
	
	aGameBoard add: speedUp at: 3.
	player:= 1.
	player2:=2.

	aGameBoard add: repeat   to: player.

	aGame throwNextPlayer .
	repeat from: player to: player . 
	aGame throwNextPlayer .
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 3 .
]

{ #category : #tests }
CardsTests >> test014PlayWithRepeatCardEffectWormHole [
	|player player2  repeat wormHole|
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	wormHole := WormHole  createNew .
	repeat  := Repeat with: aGame .
	aGameBoard add: wormHole at: 3.
	
	player:= 1.
	player2:=2.

	aGameBoard add: repeat   to: player.
	
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	repeat from: player  to: player2  . 
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 1 .
]

{ #category : #tests }
CardsTests >> test015PlayWithRepeatCardEffectMoonWalk [
	|player player2 repeat moonWalk|
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	moonWalk := MoonWalk with: -3.
	repeat  := Repeat with: aGame .
	aGameBoard add: moonWalk at: 3.
	
	player:= 1.
	player2:=2.
	aGameBoard add: repeat   to: player.
	
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	repeat from: player. 
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 2 .
]

{ #category : #tests }
CardsTests >> test016PlayWithRepeatCardEffectAtomicBomb [
	| player player2  repeat anAtomicBomb|
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	anAtomicBomb := AtomicBomb new.
	repeat  := Repeat with: aGame .
	aGameBoard add: anAtomicBomb at: 5 .

	player:= 1.
	player2:=2.

	aGameBoard add: repeat   to: player.	
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	repeat from: player. 
	
	self assert: (aGameBoard checkPositionOf:  ((aGameBoard player: 2)) ) equals: 0 .
]

{ #category : #tests }
CardsTests >> test017PlayWithRepeatCardEffectHyperJump [
	| player player2  repeat amountOfParsecsToMove parsecs hyperJump parsc1 light1 parsc2 light2 collection1 |
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	parsc1 := Parsecs with: 7.
	light1 := LightYears with: 9.
	parsc2 := Parsecs with: 2.
	light2 := LightYears with: 3.

	amountOfParsecsToMove:= OrderedCollection new.
	collection1:=OrderedCollection new.
	collection1 add: parsc1 .
	collection1 add: light1  .
	collection1 add: parsc2   .
	collection1 add: light2  .

	amountOfParsecsToMove add: collection1 .
	parsecs := 4. 
	hyperJump := HyperJump with: amountOfParsecsToMove .
	
	aGameBoard cellsWith: parsecs and: arrayOfDices .
	
	repeat  := Repeat with: aGame.
	aGameBoard add: hyperJump at: 3 .
	player:= 1.
	player2:=2.
	aGameBoard add: repeat   to: player.
	
	aGame throwNextPlayer .
	aGame throwNextPlayer .
	repeat  from: player  to: player .
		
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 5 .
	self assert: (aGameBoard checkLapOf:  (aGameBoard player: 1)) equals: 1 .
]

{ #category : #tests }
CardsTests >> test018PlayWithRedoCardAndOverloadCard [
	| overload redo player player2 |
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	overload := Overload  with: aGame .
	redo:= Redo with: aGame .

	player:=1.
	player2:=2.
	
	aGameBoard add: overload to: player.
	aGameBoard add: redo to: player2.
	
	overload from: player applyTo: player2 . 
	aGame throwNextPlayer . 
	redo  from: player2 to: player .
	aGame throwNextPlayer . 
	aGame throwNextPlayer . 
	aGame throwNextPlayer .
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 4 .
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 6 .
		
	
	
	
]

{ #category : #tests }
CardsTests >> test019PlayWithRedoCardAndAccelerationCard [
	| acceleration redo player player2 |
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	acceleration := Acceleration with: aGame .
	redo:= Redo with: aGame .
	player:=1.
	player2:=2.
	
	aGameBoard add: acceleration to: player.
	aGameBoard add: acceleration to: player.
	
	aGameBoard add: redo to: player2.
	aGameBoard add: acceleration to: player2.

	acceleration applyToAllFrom:  player . 
	aGame throwNextPlayer . 
	redo from: player2 . 
	aGame throwNextPlayer . 
	aGame throwNextPlayer . 
	aGame throwNextPlayer .
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 1 .
	self assert: (aGameBoard checkLapOf:   (aGameBoard player: 1)) equals: 2 .
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 6 .
	self assert: (aGameBoard checkLapOf:   (aGameBoard player: 2)) equals: 2 .
		
	
	
	
]

{ #category : #tests }
CardsTests >> test020PlayWithRedoCardAndSpeedCard [
	| speed redo player player2 |
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	speed := Speed with: aGame .
	redo:= Redo with: aGame .

	player:=1.
	player2:=2.
	
	aGameBoard add: speed to: player.
	aGameBoard add: redo to: player2.

	speed from: player applyTo: player . 
	aGame throwNextPlayer . 
	redo from: player2 to: player2 . 
	aGame throwNextPlayer . 
	aGame throwNextPlayer . 
	aGame throwNextPlayer .
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 8 .
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 4 .
		
	
	
	
]

{ #category : #tests }
CardsTests >> test021PlayWithRedoCardAndCancellationCard [
	| speed1 speed2 cancellation redo player player2 |
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	speed1 := Speed with: aGame .
	speed2 := Speed with: aGame .
	cancellation := Cancellation with: aGame .
	redo:= Redo with: aGame .
	
	player:=1.
	player2:=2.
	
	aGameBoard add: speed1 to: player.
	aGameBoard add: cancellation to: player.
	aGameBoard add: redo to: player2.
	aGameBoard add: speed2 to: player2.
	
	speed1 from: player applyTo: player. 
	aGame throwNextPlayer . "1-P4 2-P0"
	speed2 from: player2  applyTo: player2. 
	aGame throwNextPlayer . "1-P4 2-P6"
	cancellation  from: player applyTo: player2  canceled: speed2 . 
	redo cancellationFrom: player2 to: player canceled: speed1.
	aGame throwNextPlayer . "1-P7 2-P6"
	aGame throwNextPlayer . "1-P7L1 2-P3L2"
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 7 .
	self assert: (aGameBoard checkLapOf:  (aGameBoard player: 1)) equals: 1 .
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 3 .
	self assert: (aGameBoard checkLapOf:  (aGameBoard player: 2)) equals: 2 .
		
	
	
	
]

{ #category : #tests }
CardsTests >> test022PlayWithRedoCardAndAnotherRedoCardWithPermanentLastCardWhenItsTheirTurn [
	| speed redo1 redo2 player player2 |
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	speed := Speed with: aGame .
	redo1:= Redo with: aGame .
	redo2:= Redo with: aGame .
	
	player:=1.
	player2:=2.
	
	aGameBoard add: speed to: player.
	
	aGameBoard add: redo1 to: player2.
	aGameBoard add: redo2 to: player2.

	speed  from: player applyTo: player .
	aGame throwNextPlayer . 
	redo1 from: player2  to: player2 .
	redo2 from: player2  to: player2 .
	aGame throwNextPlayer . 
	aGame throwNextPlayer . 
	aGame throwNextPlayer .
	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 8 .
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 6 .
		
	
	
	
]

{ #category : #tests }
CardsTests >> test023PlayWithRedoCardAndAnotherRedoCardWithPermanentLastCardWhenItsNOTTheirTurn [
	| speed redo player player2 |

	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	speed := Speed with: aGame .
	redo:= Redo with: aGame .
	player:=1.
	player2:=2.
	
	aGameBoard add: speed to: player.
	aGameBoard add: redo to: player2.
	speed  from: player  applyTo: player .
	
	self should:  [redo from: player2] raise: Error withMessage: 'Cannot use permanent card when its not their turn'.
		
	
	
	
]

{ #category : #tests }
CardsTests >> test024PlayWithReverseCardForEffectHyperJump [
	| player player2  reverse amountOfParsecsToMove parsecs hyperJump parsc1 light1 parsc2 light2 collection1 |
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 2 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	parsc1 := Parsecs with: 7.
	light1 := LightYears with: 9.
	parsc2 := Parsecs with: 2.
	light2 := LightYears with: 3.

	amountOfParsecsToMove:= OrderedCollection new.
	collection1:=OrderedCollection new.
	collection1 add: parsc1 .
	collection1 add: light1  .
	collection1 add: parsc2   .
	collection1 add: light2  .

	amountOfParsecsToMove add: collection1 .
	parsecs := 4. 
	hyperJump := HyperJump with: amountOfParsecsToMove .
	
	aGameBoard cellsWith: parsecs and: arrayOfDices .
	
	reverse := Reverse with: aGame.
	aGameBoard add: hyperJump at: 3 .
	player:= 1.
	player2:=2.
	aGameBoard add: reverse to: player.
	
	reverse from: player  to: 3 .
	aGame throwNextPlayer .
	aGame throwNextPlayer .
		
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 1 .
	self assert: (aGameBoard checkLapOf:  (aGameBoard player: 1)) equals: 1 .
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 2.
	self assert: (aGameBoard checkLapOf:  (aGameBoard player: 1)) equals: 1 .
]

{ #category : #tests }
CardsTests >> test025PlayWithReverseCardAndThenCancelledForEffectHyperJump [
	| player player2  reverse amountOfParsecsToMove parsecs hyperJump parsc1 light1 parsc2 light2 collection1 cancellation|
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 2 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	parsc1 := Parsecs with: 7.
	light1 := LightYears with: 15.
	parsc2 := Parsecs with: 2.
	light2 := LightYears with: 3.

	amountOfParsecsToMove:= OrderedCollection new.
	collection1:=OrderedCollection new.
	collection1 add: parsc1 .
	collection1 add: light1  .
	collection1 add: parsc2   .
	collection1 add: light2  .

	amountOfParsecsToMove add: collection1 .
	parsecs := 4. 
	hyperJump := HyperJump with: amountOfParsecsToMove .
	
	aGameBoard cellsWith: parsecs and: arrayOfDices .
	cancellation:= Cancellation with: aGame .
	reverse := Reverse with: aGame.
	aGameBoard add: hyperJump at: 3 .
	player:= 1.
	player2:=2.
	aGameBoard add: reverse to: player.
	aGameBoard add: cancellation to: player2.
	
	reverse from: player  to: 3 .
	aGame throwNextPlayer .
	cancellation from: player2 canceled: reverse.
	aGame throwNextPlayer .
		
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 1 .
	self assert: (aGameBoard checkLapOf:  (aGameBoard player: 1)) equals: 1 .
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 4.
	self assert: (aGameBoard checkLapOf:  (aGameBoard player: 1)) equals: 1 .
]

{ #category : #tests }
CardsTests >> test026PlayWithReverseCardAndThenReverseAgainForEffectHyperJump [
	| player player2  reverse amountOfParsecsToMove parsecs hyperJump parsc1 light1 parsc2 light2 collection1 reverse2|
	self setUpLoadedDiceWith: #(1 0 1 ) and: #(2 0 2).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	parsc1 := Parsecs with: 7.
	light1 := LightYears with: 15.
	parsc2 := Parsecs with: 2.
	light2 := LightYears with: 3.

	amountOfParsecsToMove:= OrderedCollection new.
	collection1:=OrderedCollection new.
	collection1 add: parsc1 .
	collection1 add: light1  .
	collection1 add: parsc2   .
	collection1 add: light2  .

	amountOfParsecsToMove add: collection1 .
	parsecs := 4. 
	hyperJump := HyperJump with: amountOfParsecsToMove .
	
	aGameBoard cellsWith: parsecs and: arrayOfDices .
	reverse2 := Reverse with: aGame.
	reverse := Reverse with: aGame.
	aGameBoard add: hyperJump at: 3 .
	player:= 1.
	player2:=2.
	aGameBoard add: reverse to: player.
	aGameBoard add: reverse2  to: player2.
	
	reverse from: player  to: 3 .
	aGame throwNextPlayer . "cae en hyperjump y 3 + -7parcecs = casillero 1"
	aGame throwNextPlayer . "cae en 0 no pasa nada"
	reverse2 from: player  to: 3 . "tira otra vez el reverse queda en negativo"
	aGame throwNextPlayer . "tira un 3 => celda 4"
	aGame throwNextPlayer ." p2 cae en hyperjump 3 + (-15/3 parcecs) = 1"
		
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 4 .
	self assert: (aGameBoard checkLapOf:  (aGameBoard player: 1)) equals: 1 .
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 1.
	self assert: (aGameBoard checkLapOf:  (aGameBoard player: 1)) equals: 1 .
]

{ #category : #tests }
CardsTests >> test027PlayWithReverseCardAndThenReverseAgainAndThenCancellForEffectHyperJump [
	| player player2  reverse amountOfParsecsToMove parsecs hyperJump parsc1 light1 parsc2 light2 collection1 reverse2 cancellation|
	self setUpLoadedDiceWith: #(1 0 1 ) and: #(2 0 2).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	parsc1 := Parsecs with: 7.
	light1 := LightYears with: 15.
	parsc2 := Parsecs with: 2.
	light2 := LightYears with: 3.

	amountOfParsecsToMove:= OrderedCollection new.
	collection1:=OrderedCollection new.
	collection1 add: parsc1 .
	collection1 add: light1  .
	collection1 add: parsc2   .
	collection1 add: light2  .

	amountOfParsecsToMove add: collection1 .
	parsecs := 4. 
	hyperJump := HyperJump with: amountOfParsecsToMove .
	
	aGameBoard cellsWith: parsecs and: arrayOfDices .
	reverse2 := Reverse with: aGame.
	reverse := Reverse with: aGame.
	cancellation:= Cancellation with: aGame .
	aGameBoard add: hyperJump at: 3 .
	player:= 1.
	player2:=2.
	aGameBoard add: reverse to: player.
	aGameBoard add: reverse2  to: player2.
	aGameBoard add: cancellation to: player.
	
	
	reverse from: player  to: 3 .
	aGame throwNextPlayer .
	reverse2 from: player2  to: 3 .
	aGame throwNextPlayer .
	
	cancellation from: player canceled: reverse2.
	aGame throwNextPlayer .
	aGame throwNextPlayer .
		
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 4 .
	self assert: (aGameBoard checkLapOf:  (aGameBoard player: 1)) equals: 1 .
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 4.
	self assert: (aGameBoard checkLapOf:  (aGameBoard player: 1)) equals: 1 .
]

{ #category : #tests }
CardsTests >> test028PlayWithReverseCardOnMoonWalk [
	| player player2  reverse moonWalk|
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	moonWalk := MoonWalk with: -3.
	reverse := Reverse with: aGame.
	aGameBoard add: moonWalk at: 3.

	player:= 1.
	player2:=2.
	aGameBoard add: reverse to: player.
	
	reverse from: player  to: 3 .
	aGame throwNextPlayer .
	aGame throwNextPlayer .

	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 3 .
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 8 .
]

{ #category : #tests }
CardsTests >> test029PlayWithReverseAndThenAReverseAgainOnCardOnMoonWalkButStateDoesntChange [
	| player player2  reverse reverse2 moonWalk|
	self setUpLoadedDiceWith: #(1 1 1) and: #(2 2 0).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	moonWalk := MoonWalk with: -3.
	reverse := Reverse with: aGame.
	reverse2 := Reverse with: aGame.
	aGameBoard add: moonWalk at: 3.

	player:= 1.
	player2:=2.
	aGameBoard add: reverse to: player.
	aGameBoard add: reverse2 to: player2.
	
	reverse from: player  to: 3 .
	aGame throwNextPlayer .
	reverse from: player2  to: 3 .
	aGame throwNextPlayer .
	aGame throwNextPlayer .

	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 4 .
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 6 .
]

{ #category : #tests }
CardsTests >> test030PlayWithReverseAndCancellThenMoonWalkgoesBackToNormal [
	| player player2  reverse  moonWalk cancellation|
	self setUpLoadedDiceWith: #(1 0 1) and: #(2 0 0).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	moonWalk := MoonWalk with: -3.
	reverse := Reverse with: aGame.
	aGameBoard add: moonWalk at: 3.
	cancellation:= Cancellation with: aGame .

	player:= 1.
	player2:=2.
	aGameBoard add: reverse to: player.
	aGameBoard add: cancellation to: player2.
	
	reverse from: player  to: 3 .
	aGame throwNextPlayer .
	cancellation from: player2 canceled: reverse.
	aGame throwNextPlayer .

	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 0 .
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 3 .

]

{ #category : #tests }
CardsTests >> test031PlayWithReverseCardOnMWormHole [
	| player player2  reverse wormHole|
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	wormHole := WormHole  createNew.
	reverse := Reverse with: aGame.
	aGameBoard add: wormHole at: 3.

	player:= 1.
	player2:=2.
	aGameBoard add: reverse to: player.
	
	reverse from: player  to: 3 .
	aGame throwNextPlayer .
	aGame throwNextPlayer .

	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 7.
]

{ #category : #tests }
CardsTests >> test032PlayWithReverseAndReverseAgainCardOnMWormHoleThenEffectOnlyReverseOnce [
	| player player2  reverse reverse2 wormHole|
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 2 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	wormHole := WormHole  createNew.
	reverse := Reverse with: aGame.
	aGameBoard add: wormHole at: 3.
	reverse2 :=Reverse with: aGame.

	player:= 1.
	player2:=2.
	aGameBoard add: reverse to: player.
	aGameBoard add: reverse2 to: player.
	
	reverse from: player  to: 3 .
	aGame throwNextPlayer .
	reverse from: player2  to: 3 .
	aGame throwNextPlayer .

	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 7 .
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 7 .
]

{ #category : #tests }
CardsTests >> test033PlayWithReverseOnMWormHoleThenCancell [
	| player player2  reverse cancellation wormHole|
	self setUpLoadedDiceWith: #(1 1 ) and: #(2 2 ).
	self setUpGameWith: 2 andGameboardWith: 8 and: 2.
	
	wormHole := WormHole  createNew.
	reverse := Reverse with: aGame.
	aGameBoard add: wormHole at: 3.
	cancellation:= Cancellation with: aGame .

	player:= 1.
	player2:=2.
	aGameBoard add: reverse to: player.
	aGameBoard add: cancellation to: player2.
	
	reverse from: player  to: 3 .
	aGame throwNextPlayer .
	cancellation from: player2  canceled: reverse .
	aGame throwNextPlayer .

	
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 7 .
	self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2)) equals: 0 .
]
