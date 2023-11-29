Class {
	#name : #EffectsTests,
	#superclass : #TestCase,
	#instVars : [
		'aGame',
		'cells',
		'numberOfLaps',
		'amountOfPlayers',
		'aGameBoard',
		'arrayOfDie',
		'numbers',
		'anotherNumbers',
		'die1',
		'die2'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
EffectsTests >> setUpGameWith:  anAmountOfPlayers andGameboardWith: anAmountOfCells and: laps [
	aGame:= ShipsGame initializeEmpty.
	
	cells:= anAmountOfCells .
	numberOfLaps:= laps.
	amountOfPlayers := anAmountOfPlayers .
	
	aGameBoard := GameBoard with: cells and: numberOfLaps.
	aGameBoard cellsWith: 0 and: arrayOfDie  .
	aGame startwith: amountOfPlayers   and: aGameBoard.
]

{ #category : #running }
EffectsTests >> setUpLoadedDiceWith: array1 and: array2 [
	
	numbers := array1 .
	anotherNumbers := array2 .
	die1 := LoadedDie with: numbers .
	die2 := LoadedDie with: anotherNumbers .

	arrayOfDie := OrderedCollection new.
	arrayOfDie add: die1 .
	arrayOfDie add: die2.
]

{ #category : #running }
EffectsTests >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [
	self
		should: anErrorBlock 
		raise: anExceptionClass 
		withExceptionDo: [ :error |
			self assert: error messageText equals: anErrorMessage 
			 ].
]

{ #category : #tests }
EffectsTests >> test031GameUsingSpeedUpEffect [
| speedUp|

speedUp:= SpeedUp new.

self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
self setUpGameWith: 1 andGameboardWith: 8 and: 2.

aGameBoard add: speedUp at: 3.

aGame throwNextPlayer.
aGame throwNextPlayer.

self assert: ((aGameBoard specialEffectAtCell: 3) isKindOf:  SpeedUp) .





  
]

{ #category : #tests }
EffectsTests >> test032GamePlayerFallsInSpeedUpEffectThenChangePosition [
| speedUp|

speedUp:= SpeedUp new.

self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
self setUpGameWith: 1 andGameboardWith: 8 and: 2.

aGameBoard add: speedUp at: 3.

aGame throwNextPlayer.

self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1) ) equals: 7 .





  
]

{ #category : #tests }
EffectsTests >> test033GameUsingWormHoleEffect [
|wormHole|

wormHole:= WormHole new.

self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
self setUpGameWith: 1 andGameboardWith: 8 and: 2.

aGameBoard add: wormHole at: 7.

aGame throwNextPlayer.
aGame throwNextPlayer.
self assert: ((aGameBoard specialEffectAtCell: 7) isKindOf:  WormHole) .





  
]

{ #category : #tests }
EffectsTests >> test034GamePlayerFallsInWormHoleEffectThenChangePosition [
| wormHole|
wormHole:= WormHole  new.

self setUpLoadedDiceWith: #(1 1 ) and: #(6 4 ).
self setUpGameWith: 1 andGameboardWith: 8 and: 2.

aGameBoard add: wormHole at: 7.
aGame throwNextPlayer.
self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1) ) equals: 3 .





  
]

{ #category : #tests }
EffectsTests >> test034bisGamePlayerFallsInWormHoleEffectThenChangePosition [
| wormHole|
wormHole:= WormHole  new.

self setUpLoadedDiceWith: #(1 1 ) and: #(1 4 ).
self setUpGameWith: 1 andGameboardWith: 8 and: 2.

aGameBoard add: wormHole at: 2.
aGame throwNextPlayer .
self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1) ) equals: 0 .
self assert: (aGameBoard checkLapOf:   (aGameBoard player: 1) ) equals: 1 .





  
]

{ #category : #tests }
EffectsTests >> test035GamePlayAndCheckWinner [
| wormHole|

self setUpLoadedDiceWith: #(1 1 ) and: #(6 4 ).
self setUpGameWith: 1 andGameboardWith: 8 and: 2.

wormHole:= WormHole  new.

aGame throwNextPlayer.
aGame throwNextPlayer.
aGame throwNextPlayer.

self assert: aGameBoard winner equals: 1 .





  
]

{ #category : #tests }
EffectsTests >> test036GamePlayerFallsInWormHoleAndThenSpeedUpOnlyWornHoleApplied [
| wormHole speedUp|

self setUpLoadedDiceWith: #(1 1 ) and: #(6 4 ).
self setUpGameWith: 1 andGameboardWith: 8 and: 2.

wormHole:= WormHole  new.
speedUp := SpeedUp new.

aGameBoard add: wormHole at: 7.
aGameBoard add: speedUp at: 3.
aGame throwNextPlayer .
self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1) ) equals: 3 .





  
]

{ #category : #tests }
EffectsTests >> test037GamePUsingMoonWalk [
|aMoonWalk|

self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
self setUpGameWith: 1 andGameboardWith: 8 and: 2.

aMoonWalk := MoonWalk new.

aGameBoard add: aMoonWalk at: 2.

aGame throwNextPlayer.
aGame throwNextPlayer.
self assert: ((aGameBoard specialEffectAtCell: 2) isKindOf:  MoonWalk) .





  
]

{ #category : #tests }
EffectsTests >> test038GamePlayerFallsInWMoonWalkEffectThenChangePositionOfOtherPlayers [

|aMoonWalk|

self setUpLoadedDiceWith: #(1 1 ) and: #(1 4 ).
self setUpGameWith: 3 andGameboardWith: 8 and: 2.

aMoonWalk := MoonWalk with: -3.

aGameBoard add: aMoonWalk at: 2 .
aGame throwNextPlayer.

self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2) ) equals: 0 .
self assert: (aGameBoard checkLapOf: (aGameBoard player: 2) ) equals: 1 .
self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 3) ) equals: 0 .
self assert: (aGameBoard checkLapOf: (aGameBoard player: 3) ) equals: 1 .
self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1) ) equals: 2 .
self assert: (aGameBoard checkLapOf: (aGameBoard player: 1) ) equals: 1 
]

{ #category : #tests }
EffectsTests >> test039GameHasTwoDifferentMoonWalksandDifferentPlayersFallInto [

|aMoonWalk anotherMoonWalk|

self setUpLoadedDiceWith: #(1 1 ) and: #(1 6 ).
self setUpGameWith: 3 andGameboardWith: 8 and: 2.

aMoonWalk := MoonWalk with: -3.
anotherMoonWalk := MoonWalk with: -2.

aGameBoard add: aMoonWalk at: 2 .
aGameBoard add: anotherMoonWalk at: 7 .
aGame throwNextPlayer. "2L1 0L1 0L1 "
aGame throwNextPlayer. "0L1 7L1 0L1 "

self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2) ) equals: 7 .
self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 3) ) equals: 0 .
self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1) ) equals: 0 .






  
]

{ #category : #tests }
EffectsTests >> test040GameHasTwoDifferentMoonWalksandDifferentPlayersFallIntoAndCheckLaps [

|aMoonWalk anotherMoonWalk|

self setUpLoadedDiceWith: #(1 1 ) and: #(1 6 ).
self setUpGameWith: 3 andGameboardWith: 8 and: 2.

aMoonWalk := MoonWalk with: -3.
anotherMoonWalk := MoonWalk with: -2.

aGameBoard add: aMoonWalk at: 2 .
aGameBoard add: anotherMoonWalk at: 7 .
aGame throwNextPlayer. 
aGame throwNextPlayer. 

self assert: (aGameBoard checkLapOf:   (aGameBoard player: 2) ) equals: 1 .
self assert: (aGameBoard checkLapOf:  (aGameBoard player: 3) ) equals: 1 .
self assert: (aGameBoard checkLapOf:  (aGameBoard player: 1) ) equals: 1 .






  
]

{ #category : #tests }
EffectsTests >> test041GameUsingAtomicBomb [
|anAtomicBomb|

self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
self setUpGameWith: 1 andGameboardWith: 8 and: 2.

anAtomicBomb := AtomicBomb new.

aGameBoard add: anAtomicBomb at: 8.

aGame throwNextPlayer .
aGame throwNextPlayer.
self assert: ((aGameBoard specialEffectAtCell: 8) isKindOf:  AtomicBomb ) .





  
]

{ #category : #tests }
EffectsTests >> test042GameUsingAtomicBombAllPlayersMovedToCellZero [

|anAtomicBomb|

self setUpLoadedDiceWith: #(1 1 1) and: #(1 4 7).
self setUpGameWith: 3 andGameboardWith: 8 and: 2.

anAtomicBomb := AtomicBomb new.

aGameBoard add: anAtomicBomb at: 8 .
aGame throwNextPlayer.
aGame throwNextPlayer.
aGame throwNextPlayer.

self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 2) ) equals: 0 .
self assert: (aGameBoard checkLapOf: (aGameBoard player: 2) ) equals: 1 .

self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 3) ) equals: 0 .
self assert: (aGameBoard checkLapOf: (aGameBoard player: 3) ) equals: 1 .

self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1) ) equals: 0 .
self assert: (aGameBoard checkLapOf: (aGameBoard player: 1) ) equals: 1 .





  
]

{ #category : #tests }
EffectsTests >> test043GameUsingParsecs [
| parsecs |

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
parsecs := Parsecs with: 4.

self assert: ((aGameBoard numberOfParsecs: (aGameBoard player: 1)) nominalValue ) equals: 0  .





  
]

{ #category : #tests }
EffectsTests >> test044GameUsingHyperJump [
| parsecs hyperJump amountOfParsecsToMove parsc1 light1 parsc2 light2 collection1 |

self setUpGameWith: 2 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 2 ).

parsc1 := Parsecs with: 4.
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
aGameBoard cellsWith: parsecs and: arrayOfDie .
aGameBoard add: hyperJump  at: 3 .
aGame throwNextPlayer.
aGame throwNextPlayer.

self assert: ((aGameBoard numberOfParsecs: (aGameBoard player: 1)) nominalValue ) equals: 4  .
self assert: ((aGameBoard numberOfParsecs: (aGameBoard player: 2)) nominalValue ) equals: 3  .





  
]

{ #category : #tests }
EffectsTests >> test045GameUsingHyperJumpWhenCellChangeThanksToTheEffect [
| parsecs hyperJump amountOfParsecsToMove parsc1 light1 parsc2 light2 collection1 |

self setUpGameWith: 2 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 2 ).

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
aGameBoard cellsWith: parsecs and: arrayOfDie .
aGameBoard add: hyperJump  at: 3 .
aGame throwNextPlayer.


self assert: ((aGameBoard numberOfParsecs: (aGameBoard player: 1)) nominalValue ) equals: 3  .
self assert: ((aGameBoard checkPositionOf:  (aGameBoard player: 1))) equals: 4  .





  
]

{ #category : #tests }
EffectsTests >> test046PlayerFallsInHyperJumpAndChangeLapCellAndParsec [
| parsecs hyperJump amountOfParsecsToMove parsc1 light1 parsc2 light2 collection1 |

self setUpGameWith: 2 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(7 2 ).
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
aGameBoard cellsWith: parsecs and: arrayOfDie .
aGameBoard add: hyperJump  at: 8 .

aGame throwNextPlayer.


self assert: ((aGameBoard numberOfParsecs: (aGameBoard player: 1)) nominalValue ) equals: 3  .
self assert: (aGameBoard checkPositionOf:  (aGameBoard player: 1)) equals: 1  .
self assert: (aGameBoard checkLapOf:   (aGameBoard player: 1)) equals: 2  .





  
]

{ #category : #tests }
EffectsTests >> test047HyperJumpCausesNegativeParsecsThenChangePosition [
| parsecs hyperJump amountOfParsecsToMove parsc1 light1 parsc2 light2 collection1 |

self setUpGameWith: 2 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 2 ).

parsc1 := Parsecs with: -7.
light1 := LightYears with: -9.
parsc2 := Parsecs with: -1.
light2 := LightYears with: -3.

amountOfParsecsToMove:= OrderedCollection new.
collection1:=OrderedCollection new.
collection1 add: light2 .
collection1 add: parsc2  .
collection1 add: light1    .
collection1 add: parsc1  .

amountOfParsecsToMove add: collection1 .
parsecs := 4. 
hyperJump := HyperJump with: amountOfParsecsToMove .
aGameBoard cellsWith: parsecs and: arrayOfDie .
aGameBoard add: hyperJump  at: 3 .
aGame throwNextPlayer.


self assert: ((aGameBoard numberOfParsecs: (aGameBoard player: 1)) nominalValue ) equals: 3  .
self assert: ((aGameBoard checkPositionOf:  (aGameBoard player: 1))) equals: 2  .





  
]

{ #category : #tests }
EffectsTests >> test048GameUsingHyperJumpWithMultipleArrayWithParsecs [
| parsecs hyperJump  arrayOfPosibilities parsc1 light1 parsc2 light2 parsc3 parsc4 amountOfParsecsToMove collection1 collection2 |

self setUpGameWith: 2 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 2 ).
arrayOfPosibilities:= #(#(7 3 2 1) #(-3 -4)).
parsc1 := Parsecs with: 7.
light1 := LightYears with: 9.
parsc2 := Parsecs with: 2.
light2 := LightYears with: 3.
parsc3 := Parsecs with: -3.
parsc4 := Parsecs with: -4.

amountOfParsecsToMove:= OrderedCollection new.
collection1:=OrderedCollection new.
collection2:=OrderedCollection new.
collection1 add: parsc1 .
collection1 add: light1 .
collection1 add: parsc2 .
collection1 add: light2 .
collection2 add: parsc3 .
collection2 add: parsc4 .

amountOfParsecsToMove add: collection1 .
amountOfParsecsToMove add: collection2 .
parsecs := 4. 
hyperJump := HyperJump with: amountOfParsecsToMove .
aGameBoard cellsWith: parsecs and: arrayOfDie .
aGameBoard add: hyperJump  at: 3 .
aGame throwNextPlayer.

self assert: (((aGameBoard checkPositionOf:  (aGameBoard player: 1)) = 4 ) or: ((aGameBoard checkPositionOf:  (aGameBoard player: 1)) = 2)).





  
]

{ #category : #tests }
EffectsTests >> test051HyperJumpWithACollectionOutOfOrderThenRaiseAnException [
| amountOfParsecsToMove parsc1 light1 parsc2 light2 collection1 |

self setUpGameWith: 2 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 2 ).


parsc1 := Parsecs with: 4.
light1 := LightYears with: 3.
parsc2 := Parsecs with: 2.
light2 := LightYears with: 3.

amountOfParsecsToMove:= OrderedCollection new.
collection1:=OrderedCollection new.
collection1 add: parsc1 .
collection1 add: light1  .
collection1 add: parsc2   .
collection1 add: light2  .

amountOfParsecsToMove add: collection1 .
self should:[ HyperJump with: amountOfParsecsToMove ] raise: Error withMessage: 'Cannot create HyperJump with a collection out of order'.





  
]

{ #category : #tests }
EffectsTests >> test052GameUsingNullEffect [
| nullEffect |

nullEffect := NullEffect new.

self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
self setUpGameWith: 1 andGameboardWith: 8 and: 2.

aGameBoard add: nullEffect at: 3.

self assert: ((aGameBoard specialEffectAtCell: 3) isKindOf:  NullEffect) .





  
]
