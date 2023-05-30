Class {
	#name : #GameTests,
	#superclass : #TestCase,
	#instVars : [
		'aGame',
		'cells',
		'numberOfLaps',
		'amountOfPlayers',
		'aGameBoard',
		'numbers',
		'anotherNumbers',
		'dice1',
		'dice2',
		'arrayOfDices',
		'numberOfParsecs'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
GameTests >> setUp [
	aGame:= ShipsGame initializeEmpty.
	cells:= 8.
	numberOfLaps:= 2.
	amountOfPlayers:=1.
	
	
	numbers := #(1 1 ).
	anotherNumbers := #(3 4).
	dice1 := LoadedDie with: numbers .
	dice2 := LoadedDie with: anotherNumbers .

	arrayOfDices := OrderedCollection new.
	arrayOfDices add: dice1 .
	arrayOfDices add: dice2.
	
	
	aGameBoard := GameBoard with: cells and: numberOfLaps.
	aGameBoard cellsWith: 0 and: arrayOfDices .
	aGame startwith: amountOfPlayers   and: aGameBoard.
]

{ #category : #running }
GameTests >> setUpGameWith:  anAmountOfPlayers andGameboardWith: anAmountOfCells and: laps [
	aGame:= ShipsGame initializeEmpty.
	
	cells:= anAmountOfCells .
	numberOfLaps:= laps.
	amountOfPlayers := anAmountOfPlayers .
	
	aGameBoard := GameBoard with: cells and: numberOfLaps.
	aGameBoard cellsWith: 0 and: arrayOfDices .
	aGame startwith: amountOfPlayers   and: aGameBoard.
]

{ #category : #running }
GameTests >> setUpLoadedDiceWith: array1 and: array2 [
	
	numbers := array1 .
	anotherNumbers := array2 .
	dice1 := LoadedDie with: numbers .
	dice2 := LoadedDie with: anotherNumbers .

	arrayOfDices := OrderedCollection new.
	arrayOfDices add: dice1 .
	arrayOfDices add: dice2.
]

{ #category : #running }
GameTests >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [
	self
		should: anErrorBlock 
		raise: anExceptionClass 
		withExceptionDo: [ :error |
			self assert: error messageText equals: anErrorMessage 
			 ].
]

{ #category : #tests }
GameTests >> test001GameIsCreated [

aGame:= ShipsGame new.
self assert:(aGame isKindOf: ShipsGame)
]

{ #category : #tests }
GameTests >> test002GameStateBeforeStartThenMessage [

self assert: aGame result equals: 'The Game does not have a winner'  
]

{ #category : #tests }
GameTests >> test003GameIsStartedThenWinnerShip [
| aShip|
aShip := Player new.
"aGame startwith: aShip ."
 
self deny: aGame result equals: aShip  
]

{ #category : #tests }
GameTests >> test004GameIsStartedWithAGameBoardThenCheckTheAmountOfCells [
| aShip  players|
aGame:= GameTest initializeEmpty.
aShip  := Player  new.
players := OrderedCollection new.
players add: aShip .
cells:= 4.
aGameBoard := GameBoard with: cells and: 1.

aGame startwith: players and: aGameBoard.
 
self assert: aGameBoard amountOfCells equals: 4 .
]

{ #category : #tests }
GameTests >> test005ShipHasPosition [
| aPlayer   dice  players|
aGame:= GameTest initializeEmpty.
aPlayer := Player   new.
players := OrderedCollection new.
players add: aPlayer .
dice := 0.
cells:= 4.
aGameBoard := GameBoard with: cells and: 1.

aGame startwith: players and: aGameBoard.

self assert: (aGameBoard playerPosition: dice ) equals: 0.
 

  
]

{ #category : #tests }
GameTests >> test006ShipPositionLowerThanTotalCellsThenNotWinner [
| aPlayer   players|
aGame:= GameTest initializeEmpty.
aPlayer := Player new.
players := OrderedCollection new.
players add:aPlayer.
cells:= 4.
aGameBoard := GameBoard with: cells and: 1.
aGame startwith: players and: aGameBoard.

self deny: aGame result equals: aPlayer.

  
]

{ #category : #tests }
GameTests >> test007ShipPositionSameAsTotalCellsThenWinner [
|  aPlayer  dice players|
aGame:= GameTest initializeEmpty.
aPlayer := Player new.
players := OrderedCollection new.
players add:aPlayer.
cells:= 4.
dice:= 4.
"aGameBoard := GameBoard with: cells .
aGame startwith: players and: aGameBoard.
aGameBoard move: aPlayer adding: dice."

"self assert: (aGameBoard checkPositionOf:aPlayer) equals: cells."
"self deny: (aGame winner) equals: aPlayer "
"Cambio la implementacion del winner"

  
]

{ #category : #tests }
GameTests >> test008PlayerPlayTheGame2RoundsThenFinalPositionEqualsAmountOfCells [
| aPlayer   dice players|
aGame:= GameTest initializeEmpty.
aPlayer := Player new.
players := OrderedCollection new.
players add:aPlayer.
cells:= 4.
dice:= 4.
aGameBoard := GameBoard with: cells and: 1.
aGame startwith: players and: aGameBoard.
"aGameBoard move: aPlayer adding: dice.
self assert: (aGameBoard checkPositionOf:aPlayer) equals: cells."

  
]

{ #category : #tests }
GameTests >> test009PlayersPlayTheGame2RoundsThenCheckPositions [
| marian delfi  players  dice |
aGame:= GameTest initializeEmpty.
marian := Player new.
delfi := Player new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
dice:= 1.
aGameBoard := GameBoard with: cells and: 1.
aGame startwith: players  and: aGameBoard.
"aGameBoard move: marian  adding: dice.
self assert: (aGameBoard  checkPositionOf: marian  )  equals: 1.
dice:=2.
aGameBoard move: delfi   adding: dice.
self assert: (aGameBoard  checkPositionOf: delfi  )  equals: 2.
aGameBoard move: marian  adding: dice.
self assert: (aGameBoard  checkPositionOf: marian  )  equals: 3.
"
  
]

{ #category : #tests }
GameTests >> test010PlayersPlayTheGame3RoundsThenPlayer1Wins [
| marian delfi  players  dice |
aGame:= GameTest initializeEmpty.
marian := Player new.
delfi := Player new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
dice:= 1.
aGameBoard := GameBoard with: cells and: 1.
aGame startwith: players  and: aGameBoard.
"aGameBoard move: marian  adding: dice.
self assert: (aGameBoard  checkPositionOf: marian  )  equals: 1.
dice:=2.
aGameBoard move: delfi   adding: dice.
self assert: (aGameBoard  checkPositionOf: delfi  )  equals: 2.
aGameBoard move: marian  adding: dice.
self assert: (aGameBoard  checkPositionOf: marian  )  equals: 3.
dice := 1.
aGameBoard move: delfi   adding: dice.
self assert: (aGameBoard  checkPositionOf: delfi  )  equals: 3.
aGameBoard move: marian  adding: dice.
self assert: (aGameBoard  checkPositionOf: marian  )  equals: 4."
"self assert: (aGame winner) equals: marian."
"Cambio la implementacion del winner"



  
]

{ #category : #tests }
GameTests >> test011PlayersPlayWithRoundsThenCheckPosition [
| marian delfi  players  dice |
aGame:= GameTest initializeEmpty.
marian := Player new.
delfi := Player new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
numbers := #(1 1 1)  .
dice:= LoadedDie with:numbers.

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice .

aGameBoard := GameBoard with: cells and:1 .
aGame startwith: players  and: aGameBoard.
"aGame playUntilWinner: arrayOfDices."

"self assert: (aGameBoard checkPositionOf: delfi)equals: 3. "
"Cambiaron las implementaciones"




  
]

{ #category : #tests }
GameTests >> test011PlayersRoundsUntilOneWins [
| marian delfi  players  dice |
aGame:= GameTest initializeEmpty.
marian := Player new.
delfi := Player new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
numbers := #(1 1 1)  .
dice:= LoadedDie with:numbers.

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice .

aGameBoard := GameBoard with: cells and:1.
aGame startwith: players  and: aGameBoard.
"aGame playUntilWinner: arrayOfDices."

"self assert: (aGame winner)equals: marian. 
self deny: (aGame winner)equals: delfi."

"Cambió la implementacion del winner"




  
]

{ #category : #tests }
GameTests >> test012PlayersRoundsUntilOneWins [
| marian delfi  players  dice |
aGame:= GameTest initializeEmpty.
marian := Player new.
delfi := Player new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
numbers := #(1 2 3)  .
dice:= LoadedDie with:numbers.

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice .

aGameBoard := GameBoard with: cells and:1.
aGame startwith: players  and: aGameBoard.
"aGame playUntilWinner: arrayOfDices."

"self assert: (aGame  winner)equals: marian. "

"Cambio la implementacion del winner"



  
]

{ #category : #tests }
GameTests >> test013PlayWithLoadedDiceThenWinsPlayer2 [
| marian delfi  players  dice  |
aGame:= GameTest initializeEmpty.
marian := Player new.
delfi := Player new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
dice:= LoadedDie .
numbers := #(1 2 1 4)  .
dice := LoadedDie with: numbers .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice .

aGameBoard := GameBoard with: cells and:1.
aGame startwith: players  and: aGameBoard.
"aGame playUntilWinner: arrayOfDices." "OBSOLETO"

"self assert: (aGame winner)equals: delfi . "

"Cambio la implementacion del winner"

]

{ #category : #tests }
GameTests >> test014playWithRandomDiceThenWinner [
| marian delfi  players  aDice  |
aGame:= GameTest initializeEmpty.
marian := Player new.
delfi := Player new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
aDice := Die with: 4.

arrayOfDices := OrderedCollection new.
arrayOfDices add: aDice .

aGameBoard := GameBoard with: cells and:1.
aGame startwith: players  and: aGameBoard.
"aGame playUntilWinner: arrayOfDices." "OBSOLETO"

"self deny: ((aGame winner)isKindOf:  Integer) . "



  
]

{ #category : #tests }
GameTests >> test015PlayWithNPlayersUntilGameEnds [
|dice|
aGame:= ShipsGame initializeEmpty.
numberOfLaps :=1.
amountOfPlayers := 4.
cells:= 8.
dice:= LoadedDie .
numbers := #(1 2 1 4)  .
dice := LoadedDie with: numbers .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice .

aGame startwith: amountOfPlayers   and: aGameBoard.
"aGame playUntilWinner: arrayOfDices. ""OBSOLETO"

self deny: (aGame result) equals: 'The Game has ended' . 



  
]

{ #category : #tests }
GameTests >> test016PlayWithMLoadedDicesAndNPlayersThenCheckWinner [

aGame:= ShipsGame initializeEmpty.
amountOfPlayers := 4.
cells:= 8.
numberOfLaps :=1.
numbers := #(1 1 1 1)  .
anotherNumbers := #(2 2 2 4)  .
dice1 := LoadedDie with: numbers .
dice2 := LoadedDie with: anotherNumbers .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGame startwith: amountOfPlayers   and: aGameBoard.
"aGame playUntilWinner: arrayOfDices . ""OBSOLETO"

self deny: (aGame winner) equals: (aGameBoard shipAt: 1) .
self deny: (aGame winner) equals: (aGameBoard shipAt: 2) .
self deny: (aGame winner) equals: (aGameBoard shipAt: 3) .
"self assert: (aGame winner) equals: (4) ."




  
]

{ #category : #tests }
GameTests >> test017PlayWithMDicesAndNPlayersUntilTheGameEnds [
|amountOfDices|
aGame:= ShipsGame initializeEmpty.
numberOfLaps :=1.
amountOfPlayers := 4.
cells:= 8.

amountOfDices := 2.
dice1 := Die with: 3 .
dice2 := Die with: 5 .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGame startwith: amountOfPlayers   and: aGameBoard.
"aGame playUntilWinner: arrayOfDices ." "OBSOLETO"

"self assert: (aGame result) equals: 'The Game has ended'"



  
]

{ #category : #tests }
GameTests >> test018PlayWithMLoadedDicesAndNPlayersUntilWinnerThenCheckFinalPositions [ 
amountOfPlayers := 4.
cells:= 8.
numberOfLaps :=1.

numbers := #(1 1 1 1)  .
anotherNumbers := #(2 2 2 4)  .
dice1 := LoadedDie with: numbers .
dice2 := LoadedDie with: anotherNumbers .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGame startwith: amountOfPlayers   and: aGameBoard.
"aGame playUntilWinner: arrayOfDices ." "OBSOLETO"
 
"self assert: (aGameBoard checkPositionOf: (aGameBoard shipAt: 2) ) equals: 6 ."

"Obsoleto"




  
]

{ #category : #tests }
GameTests >> test019PlayerHasAshipThenPlayerShipHasANumber [
|aPlayer|
aPlayer := Player with:  1.


self assert: (aPlayer numberOfShip) equals: 1.




  
]

{ #category : #tests }
GameTests >> test020PlayWithMLoadedDicesAndNPlayersUntilWinnerThenCheckShipNumberAtFirstPositionEqualsOne [

aGame:= ShipsGame initializeEmpty.
	cells:= 8.
	numberOfLaps:= 2.
	amountOfPlayers:=1.
	
	
	numbers := #(1 1 ).
	anotherNumbers := #(3 4).
	dice1 := LoadedDie with: numbers .
	dice2 := LoadedDie with: anotherNumbers .

	arrayOfDices := OrderedCollection new.
	arrayOfDices add: dice1 .
	arrayOfDices add: dice2.
	
	
	aGameBoard := GameBoard with: cells and: numberOfLaps.
	aGameBoard cellsWith: 0 and: arrayOfDices .
	aGame startwith: amountOfPlayers   and: aGameBoard.
	
amountOfPlayers := 4.
numberOfLaps:=1.
numbers := #(2 1 1 1)  .
dice1 := LoadedDie with: numbers .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .

"aGame playUntilWinner: arrayOfDices .

self assert: (aGameBoard winner) equals: 1 ."




  
]

{ #category : #tests }
GameTests >> test021PlayWithMDicesWithNegativeNumber [


self should:  [Die with: -3] raise: Error withMessage: 'Cannot create die with negative amount of faces'.




  
]

{ #category : #tests }
GameTests >> test022PlayWithGameBoardWithNegativeAmountOfCellsThenThrowAnError [

self should:[ GameBoard  with: -4 and: -1] raise: Error withMessage: 'Cannot create GameBoard with negative amount of cells or laps'.




  
]

{ #category : #tests }
GameTests >> test023PlayerThrowWithTurns [ 

amountOfPlayers := 4.
numbers := #(1 1 1 1)  .
anotherNumbers := #(2 2 2 4)  .
dice1 := LoadedDie with: numbers .
dice2 := LoadedDie with: anotherNumbers .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGameBoard := GameBoard with: cells and: 1 .
aGameBoard cellsWith: 0 and: arrayOfDices .
aGame startwith: amountOfPlayers   and: aGameBoard.

aGame throwNextPlayer.

self assert: (aGameBoard checkPositionOf: (aGameBoard shipAt: 1) ) equals: 3 .




  
]

{ #category : #tests }
GameTests >> test024PlayWithLoadedDiceTwoTurnsThenCheckPositionOfTheSecondPlayer [


amountOfPlayers := 4.

numbers := #(1 1 1 1)  .
anotherNumbers := #(2 4 2 4)  .
dice1 := LoadedDie with: numbers .
dice2 := LoadedDie with: anotherNumbers .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGameBoard := GameBoard with: cells and: 1.
aGameBoard cellsWith: 0 and: arrayOfDices .
aGame startwith: amountOfPlayers   and: aGameBoard.

aGame throwNextPlayer .
aGame throwNextPlayer .

self assert: (aGameBoard checkPositionOf: (aGameBoard shipAt: 2) ) equals: 5 .




  
]

{ #category : #tests }
GameTests >> test025PlayThreeTurnsWithLoadedDiceAndTwoPlayersThenCheckPositionChangeOfTheFirstPlayer [

aGame:= ShipsGame initializeEmpty.
amountOfPlayers := 2.
cells:= 8.
numbers := #(1 1 )  .
anotherNumbers := #(2 2)  .
dice1 := LoadedDie with: numbers .
dice2 := LoadedDie with: anotherNumbers .


arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGameBoard := GameBoard with: cells and: 1.
aGameBoard cellsWith: 0 and: arrayOfDices .
aGame startwith: amountOfPlayers   and: aGameBoard.

aGame throwNextPlayer .
aGame throwNextPlayer .
aGame throwNextPlayer .

self assert: (aGameBoard checkPositionOf: (aGameBoard shipAt: 1) ) equals: 6 .




  
]

{ #category : #tests }
GameTests >> test026PlayThreeTurnsWithDiceAndCheckThereIsAWinner [

self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
self setUpGameWith: 1 andGameboardWith: 2 and: 1.

dice1 := Die with: 4 .
dice2 := Die with: 8.

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGame throwNextPlayer.
aGame throwNextPlayer.
aGame throwNextPlayer.
aGame throwNextPlayer.
aGame throwNextPlayer.
aGame throwNextPlayer.
aGame throwNextPlayer.
aGame throwNextPlayer.
aGame throwNextPlayer.
aGame throwNextPlayer.


self deny: (aGameBoard winner = 0) .




  
]

{ #category : #tests }
GameTests >> test027GameBoardCircularWithXLaps [
self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).

numberOfLaps:= 3.
self assert: (aGameBoard laps >=1).




  
]

{ #category : #tests }
GameTests >> test028GameBoardCircularWithXLapsAndPlayerWithLaps [

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).

self assert: (aGameBoard checkLapOf: (aGameBoard shipAt: 1) ) equals: 1 .




  
]

{ #category : #tests }
GameTests >> test029GameBoardCircularWithXLapsAndPlayerChangeAcualLap [

self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
self setUpGameWith: 1 andGameboardWith: 8 and: 2.

aGame throwNextPlayer .
aGame throwNextPlayer.

self assert: (aGameBoard checkLapOf: (aGameBoard shipAt: 1) ) equals: 2 .





  
]

{ #category : #tests }
GameTests >> test030GameBoardCircularWithXLapsAndPlayerCheckPositionInNewLap [

self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
self setUpGameWith: 1 andGameboardWith: 8 and: 2.

aGame throwNextPlayer .
aGame throwNextPlayer.


self assert: (aGameBoard checkPositionOf:(aGameBoard shipAt: 1) ) equals: 1 .





  
]

{ #category : #tests }
GameTests >> test031GameUsingSpeedUpEffect [
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
GameTests >> test032GamePlayerFallsInSpeedUpEffectThenChangePosition [
| speedUp|

speedUp:= SpeedUp new.

self setUpLoadedDiceWith: #(1 1 ) and: #(2 4 ).
self setUpGameWith: 1 andGameboardWith: 8 and: 2.

aGameBoard add: speedUp at: 3.

aGame throwNextPlayer.

self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 1) ) equals: 7 .





  
]

{ #category : #tests }
GameTests >> test033GameUsingWormHoleEffect [
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
GameTests >> test034GamePlayerFallsInWormHoleEffectThenChangePosition [
| wormHole|
wormHole:= WormHole  new.

self setUpLoadedDiceWith: #(1 1 ) and: #(6 4 ).
self setUpGameWith: 1 andGameboardWith: 8 and: 2.

aGameBoard add: wormHole at: 7.
aGame throwNextPlayer.
self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 1) ) equals: 3 .





  
]

{ #category : #tests }
GameTests >> test034bisGamePlayerFallsInWormHoleEffectThenChangePosition [
| wormHole|
wormHole:= WormHole  new.

self setUpLoadedDiceWith: #(1 1 ) and: #(1 4 ).
self setUpGameWith: 1 andGameboardWith: 8 and: 2.

aGameBoard add: wormHole at: 2.
aGame throwNextPlayer .
self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 1) ) equals: 0 .
self assert: (aGameBoard checkLapOf:   (aGameBoard shipAt: 1) ) equals: 1 .





  
]

{ #category : #tests }
GameTests >> test035GamePlayAndCheckWinner [
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
GameTests >> test036GamePlayerFallsInWormHoleAndThenSpeedUpOnlyWornHoleApplied [
| wormHole speedUp|

self setUpLoadedDiceWith: #(1 1 ) and: #(6 4 ).
self setUpGameWith: 1 andGameboardWith: 8 and: 2.

wormHole:= WormHole  new.
speedUp := SpeedUp new.

aGameBoard add: wormHole at: 7.
aGameBoard add: speedUp at: 3.
aGame throwNextPlayer .
self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 1) ) equals: 3 .





  
]

{ #category : #tests }
GameTests >> test037GamePUsingMoonWalk [
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
GameTests >> test038GamePlayerFallsInWMoonWalkEffectThenChangePositionOfOtherPlayers [

|aMoonWalk|

self setUpLoadedDiceWith: #(1 1 ) and: #(1 4 ).
self setUpGameWith: 3 andGameboardWith: 8 and: 2.

aMoonWalk := MoonWalk with: -3.

aGameBoard add: aMoonWalk at: 2 .
aGame throwNextPlayer.

self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 2) ) equals: 0 .
self assert: (aGameBoard checkLapOf: (aGameBoard shipAt: 2) ) equals: 1 .
self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 3) ) equals: 0 .
self assert: (aGameBoard checkLapOf: (aGameBoard shipAt: 3) ) equals: 1 .
self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 1) ) equals: 2 .
self assert: (aGameBoard checkLapOf: (aGameBoard shipAt: 1) ) equals: 1 
]

{ #category : #tests }
GameTests >> test039GameHasTwoDifferentMoonWalksandDifferentPlayersFallInto [

|aMoonWalk anotherMoonWalk|

self setUpLoadedDiceWith: #(1 1 ) and: #(1 6 ).
self setUpGameWith: 3 andGameboardWith: 8 and: 2.

aMoonWalk := MoonWalk with: -3.
anotherMoonWalk := MoonWalk with: -2.

aGameBoard add: aMoonWalk at: 2 .
aGameBoard add: anotherMoonWalk at: 7 .
aGame throwNextPlayer. "2L1 0L1 0L1 "
aGame throwNextPlayer. "0L1 7L1 0L1 "

self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 2) ) equals: 7 .
self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 3) ) equals: 0 .
self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 1) ) equals: 0 .






  
]

{ #category : #tests }
GameTests >> test040GameHasTwoDifferentMoonWalksandDifferentPlayersFallIntoAndCheckLaps [

|aMoonWalk anotherMoonWalk|

self setUpLoadedDiceWith: #(1 1 ) and: #(1 6 ).
self setUpGameWith: 3 andGameboardWith: 8 and: 2.

aMoonWalk := MoonWalk with: -3.
anotherMoonWalk := MoonWalk with: -2.

aGameBoard add: aMoonWalk at: 2 .
aGameBoard add: anotherMoonWalk at: 7 .
aGame throwNextPlayer. 
aGame throwNextPlayer. 

self assert: (aGameBoard checkLapOf:   (aGameBoard shipAt: 2) ) equals: 1 .
self assert: (aGameBoard checkLapOf:  (aGameBoard shipAt: 3) ) equals: 1 .
self assert: (aGameBoard checkLapOf:  (aGameBoard shipAt: 1) ) equals: 1 .






  
]

{ #category : #tests }
GameTests >> test041GameUsingAtomicBomb [
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
GameTests >> test042GameUsingAtomicBombAllPlayersMovedToCellZero [

|anAtomicBomb|

self setUpLoadedDiceWith: #(1 1 1) and: #(1 4 7).
self setUpGameWith: 3 andGameboardWith: 8 and: 2.

anAtomicBomb := AtomicBomb new.

aGameBoard add: anAtomicBomb at: 8 .
aGame throwNextPlayer.
aGame throwNextPlayer.
aGame throwNextPlayer.

self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 2) ) equals: 0 .
self assert: (aGameBoard checkLapOf: (aGameBoard shipAt: 2) ) equals: 1 .

self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 3) ) equals: 0 .
self assert: (aGameBoard checkLapOf: (aGameBoard shipAt: 3) ) equals: 1 .

self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 1) ) equals: 0 .
self assert: (aGameBoard checkLapOf: (aGameBoard shipAt: 1) ) equals: 1 .





  
]

{ #category : #tests }
GameTests >> test043GameUsingParsecs [
| parsecs |

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
parsecs := 4. 


self assert: (aGameBoard numberOfParsecs: (aGameBoard shipAt: 1)) equals: 0  .





  
]

{ #category : #tests }
GameTests >> test044GameUsingHyperJump [
| parsecs hyperJump amountOfParsecsToMove|

self setUpGameWith: 2 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 2 ).

amountOfParsecsToMove:= #(#(4 3 2 1)).
parsecs := 4. 
hyperJump := HyperJump with: amountOfParsecsToMove .
aGameBoard cellsWith: parsecs and: arrayOfDices .
aGameBoard add: hyperJump  at: 3 .
aGame throwNextPlayer.
aGame throwNextPlayer.

self assert: (aGameBoard numberOfParsecs: (aGameBoard shipAt: 1)) equals: 4  .
self assert: (aGameBoard numberOfParsecs: (aGameBoard shipAt: 2)) equals: 3  .





  
]

{ #category : #tests }
GameTests >> test045GameUsingHyperJumpWhenCellChangeThanksToTheEffect [
| parsecs hyperJump amountOfParsecsToMove|

self setUpGameWith: 2 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 2 ).
amountOfParsecsToMove:= #(#(7 3 2 1)).
parsecs := 4. 
hyperJump := HyperJump with: amountOfParsecsToMove .
aGameBoard cellsWith: parsecs and: arrayOfDices .
aGameBoard add: hyperJump  at: 3 .
aGame throwNextPlayer.


self assert: (aGameBoard numberOfParsecs: (aGameBoard shipAt: 1)) equals: 3  .
self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 1)) equals: 4  .





  
]

{ #category : #tests }
GameTests >> test046PlayerFallsInHyperJumpAndChangeLapCellAndParsec [
| parsecs hyperJump amountOfParsecsToMove|

self setUpGameWith: 2 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(7 2 ).
amountOfParsecsToMove:= #(#(7 3 2 1)).
parsecs := 4. 

hyperJump := HyperJump with: amountOfParsecsToMove .

aGameBoard cellsWith: parsecs and: arrayOfDices .
aGameBoard add: hyperJump  at: 8 .

aGame throwNextPlayer.


self assert: (aGameBoard numberOfParsecs: (aGameBoard shipAt: 1)) equals: 3  .
self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 1)) equals: 1  .
self assert: (aGameBoard checkLapOf:   (aGameBoard shipAt: 1)) equals: 2  .





  
]

{ #category : #tests }
GameTests >> test047RankingPlayers [
| parsecs  amountOfParsecsToMove aRanking|

self setUpGameWith: 3 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 2) and: #(3 2 4).
amountOfParsecsToMove:= #(7 3 2 1).
parsecs := 4. 

aGameBoard cellsWith: parsecs and: arrayOfDices .
aGame throwNextPlayer.
aGame throwNextPlayer.
aGame throwNextPlayer.
aRanking := aGame ranking.


self assert: (aRanking at: 1) numberOfShip  equals: 3 .
self assert: (aRanking at: 2) numberOfShip  equals: 1 .
self assert: (aRanking at: 3) numberOfShip  equals: 2 .





  
]

{ #category : #tests }
GameTests >> test048GameUsingHyperJumpWithMultipleArrayWithParsecs [
| parsecs hyperJump  arrayOfPosibilities|

self setUpGameWith: 2 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 2 ).
arrayOfPosibilities:= #(#(7 3 2 1) #(-3 -4)).
parsecs := 4. 
hyperJump := HyperJump with: arrayOfPosibilities .
aGameBoard cellsWith: parsecs and: arrayOfDices .
aGameBoard add: hyperJump  at: 3 .
aGame throwNextPlayer.

self assert: (((aGameBoard checkPositionOf:  (aGameBoard shipAt: 1)) = 4 ) or: ((aGameBoard checkPositionOf:  (aGameBoard shipAt: 1)) = 2)).





  
]

{ #category : #tests }
GameTests >> test049CheckDistributionOfEffectsIn1000GameboardsWithHyperJumpArrays [
| parsecs aProbability effectsProbabilities array|

parsecs := 4. 
aProbability := ProbabilityOfEffects new.
array:=#(#(6 5 2) #(9 9 8 6 5 4 -5) #(2 1 -9) #(6 6 4 2 1) #(3 2 1) #(9 2) #(4 1) #(9 5)).
effectsProbabilities := aProbability calculate: #(40 20 20 10 8 2) forHyperJump: array.

self assert: ((effectsProbabilities at: 1) >39  and: (effectsProbabilities at: 1) < 40) .
self assert: ((effectsProbabilities at: 2) >19  and: (effectsProbabilities at: 2) < 21) .
self assert: ((effectsProbabilities at: 3) >19  and: (effectsProbabilities at: 3) < 21) .
self assert: ((effectsProbabilities at: 4) >9  and: (effectsProbabilities at: 4) < 11) .
self assert: ((effectsProbabilities at: 5) >7  and: (effectsProbabilities at: 5) < 9) .
self assert: ((effectsProbabilities at: 6) >1  and: (effectsProbabilities at: 6) < 3) .





  
]

{ #category : #tests }
GameTests >> test050CheckDifferentDistributionOfEffectsIn1000GameboardsWithHyperJumpArrays [
| parsecs aProbability effectsProbabilities array|

parsecs := 4. 
aProbability := ProbabilityOfEffects new.
array:=#(#(6 5 2) #(9 9 8 6 5 4 -5) #(2 1 -9) #(6 6 4 2 1) #(3 2 1) #(9 2) #(4 1) #(9 5)).
effectsProbabilities := aProbability calculate: #(40 30 10 10 10 0) forHyperJump: array.

self assert: ((effectsProbabilities at: 1) >39  and: (effectsProbabilities at: 1) < 41) .
self assert: ((effectsProbabilities at: 2) >29  and: (effectsProbabilities at: 2) < 31) .
self assert: ((effectsProbabilities at: 3) >9  and: (effectsProbabilities at: 3) < 11) .
self assert: ((effectsProbabilities at: 4) >9  and: (effectsProbabilities at: 4) < 11) .
self assert: ((effectsProbabilities at: 5) >9  and: (effectsProbabilities at: 5) < 11) .
self assert: ((effectsProbabilities at: 6) >(-1)  and: (effectsProbabilities at: 6) < 1) .





  
]

{ #category : #tests }
GameTests >> test051HyperJumpWithACollectionOutOfOrderThenRaiseAnException [
| amountOfParsecsToMove|

self setUpGameWith: 2 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 2 ).

amountOfParsecsToMove:= #(#(4 1 2 3)).
self should:[ HyperJump with: amountOfParsecsToMove ] raise: Error withMessage: 'Cannot create HyperJump with a collection out of order'.





  
]

{ #category : #tests }
GameTests >> test052UsingRandomDieAndCheckingTheResult [
| die result|
die := Die with: 5.
result:= die throw .
self assert: (result > 0).





  
]
