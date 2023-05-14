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
		'arrayOfDices'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
GameTests >> aGameBoardwith: numberOfcells and: amountOfLaps [ 
	
	^GameBoard with: numberOfcells  and: amountOfLaps.
]

{ #category : #running }
GameTests >> setUp [
	aGame:= Game initializeEmpty.
	cells:= 8.
	numberOfLaps:= 2.
	amountOfPlayers:=1.
	
	
	numbers := #(1 1 ).
	anotherNumbers := #(3 4).
	dice1 := LoadedDice with: numbers .
	dice2 := LoadedDice with: anotherNumbers .

	arrayOfDices := OrderedCollection new.
	arrayOfDices add: dice1 .
	arrayOfDices add: dice2.
	
	
	aGameBoard := GameBoard with: cells and: numberOfLaps.
	aGame startwith: amountOfPlayers   and: aGameBoard.
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

aGame:= Game new.
self assert:(aGame isKindOf: Game)
]

{ #category : #tests }
GameTests >> test002GameStateBeforeStartThenMessage [

self assert: aGame result equals: 'The Game does not have a winner'  
]

{ #category : #tests }
GameTests >> test003GameIsStartedThenWinnerShip [
| aShip|
aShip := Ship new.
aGame startwith: aShip .
 
self assert: aGame result equals: aShip  
]

{ #category : #tests }
GameTests >> test004GameIsStartedWithAGameBoardThenCheckTheAmountOfCells [
| aShip  players|
aGame:= GameTest initializeEmpty.
aShip  := Ship new.
players := OrderedCollection new.
players add: aShip .
cells:= 4.
aGameBoard := GameBoard with: cells .

aGame startwith: players and: aGameBoard.
 
self assert: aGameBoard amountOfCells equals: 4 .
]

{ #category : #tests }
GameTests >> test005ShipHasPosition [
| aPlayer   dice  players|
aGame:= GameTest initializeEmpty.
aPlayer := Ship new.
players := OrderedCollection new.
players add: aPlayer .
dice := 0.
cells:= 4.
aGameBoard := GameBoard with: cells .

aGame startwith: players and: aGameBoard.

self assert: (aGameBoard playerPosition: dice ) equals: 0.
 

  
]

{ #category : #tests }
GameTests >> test006ShipPositionLowerThanTotalCellsThenNotWinner [
| aPlayer   players|
aGame:= GameTest initializeEmpty.
aPlayer := Ship new.
players := OrderedCollection new.
players add:aPlayer.
cells:= 4.
aGameBoard := GameBoard with: cells .
aGame startwith: players and: aGameBoard.

self deny: aGame result equals: aPlayer.

  
]

{ #category : #tests }
GameTests >> test007ShipPositionSameAsTotalCellsThenWinner [
|  aPlayer  dice players|
aGame:= GameTest initializeEmpty.
aPlayer := Ship new.
players := OrderedCollection new.
players add:aPlayer.
cells:= 4.
dice:= 4.
"aGameBoard := GameBoard with: cells .
aGame startwith: players and: aGameBoard.
aGameBoard move: aPlayer adding: dice."

"self assert: (aGameBoard checkPositionOf:aPlayer) equals: cells."
"self assert: (aGame winner) equals: aPlayer "
"Cambio la implementacion del winner"

  
]

{ #category : #tests }
GameTests >> test008PlayerPlayTheGame2RoundsThenFinalPositionEqualsAmountOfCells [
| aPlayer   dice players|
aGame:= GameTest initializeEmpty.
aPlayer := Ship new.
players := OrderedCollection new.
players add:aPlayer.
cells:= 4.
dice:= 4.
aGameBoard := GameBoard with: cells .
aGame startwith: players and: aGameBoard.
"aGameBoard move: aPlayer adding: dice.
self assert: (aGameBoard checkPositionOf:aPlayer) equals: cells."

  
]

{ #category : #tests }
GameTests >> test009PlayersPlayTheGame2RoundsThenCheckPositions [
| marian delfi  players  dice |
aGame:= GameTest initializeEmpty.
marian := Ship new.
delfi := Ship new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
dice:= 1.
aGameBoard := GameBoard with: cells .
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
marian := Ship new.
delfi := Ship new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
dice:= 1.
aGameBoard := GameBoard with: cells .
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
marian := Ship new.
delfi := Ship new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
numbers := #(1 1 1)  .
dice:= LoadedDice with:numbers.

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice .

aGameBoard := GameBoard with: cells and:1 .
aGame startwith: players  and: aGameBoard.
aGame playUntilWinner: arrayOfDices.

"self assert: (aGameBoard checkPositionOf: delfi)equals: 3. "
"Cambiaron las implementaciones"




  
]

{ #category : #tests }
GameTests >> test011PlayersRoundsUntilOneWins [
| marian delfi  players  dice |
aGame:= GameTest initializeEmpty.
marian := Ship new.
delfi := Ship new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
numbers := #(1 1 1)  .
dice:= LoadedDice with:numbers.

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice .

aGameBoard := GameBoard with: cells and:1.
aGame startwith: players  and: aGameBoard.
aGame playUntilWinner: arrayOfDices.

"self assert: (aGame winner)equals: marian. 
self deny: (aGame winner)equals: delfi."

"Cambió la implementacion del winner"




  
]

{ #category : #tests }
GameTests >> test012PlayersRoundsUntilOneWins [
| marian delfi  players  dice |
aGame:= GameTest initializeEmpty.
marian := Ship new.
delfi := Ship new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
numbers := #(1 2 3)  .
dice:= LoadedDice with:numbers.

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice .

aGameBoard := GameBoard with: cells and:1.
aGame startwith: players  and: aGameBoard.
aGame playUntilWinner: arrayOfDices.

"self assert: (aGame  winner)equals: marian. "

"Cambio la implementacion del winner"



  
]

{ #category : #tests }
GameTests >> test013PlayWithLoadedDiceThenWinsPlayer2 [
| marian delfi  players  dice  |
aGame:= GameTest initializeEmpty.
marian := Ship new.
delfi := Ship new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
dice:= LoadedDice .
numbers := #(1 2 1 4)  .
dice := LoadedDice with: numbers .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice .

aGameBoard := GameBoard with: cells and:1.
aGame startwith: players  and: aGameBoard.
aGame playUntilWinner: arrayOfDices.

"self assert: (aGame winner)equals: delfi . "

"Cambio la implementacion del winner"

]

{ #category : #tests }
GameTests >> test014playWithRandomDiceThenWinner [
| marian delfi  players  aDice  |
aGame:= GameTest initializeEmpty.
marian := Ship new.
delfi := Ship new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
aDice := Dice with: 4.

arrayOfDices := OrderedCollection new.
arrayOfDices add: aDice .

aGameBoard := GameBoard with: cells and:1.
aGame startwith: players  and: aGameBoard.
aGame playUntilWinner: arrayOfDices.

self assert: ((aGame winner)isKindOf:  Integer) . 



  
]

{ #category : #tests }
GameTests >> test015PlayWithNPlayersUntilGameEnds [
|dice|
aGame:= Game initializeEmpty.
numberOfLaps :=1.
amountOfPlayers := 4.
cells:= 8.
dice:= LoadedDice .
numbers := #(1 2 1 4)  .
dice := LoadedDice with: numbers .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice .

aGame startwith: amountOfPlayers   and: aGameBoard.
aGame playUntilWinner: arrayOfDices.

self assert: (aGame result) equals: 'The Game has ended' . 



  
]

{ #category : #tests }
GameTests >> test016PlayWithMLoadedDicesAndNPlayersThenCheckWinner [

aGame:= Game initializeEmpty.
amountOfPlayers := 4.
cells:= 8.
numberOfLaps :=1.
numbers := #(1 1 1 1)  .
anotherNumbers := #(2 2 2 4)  .
dice1 := LoadedDice with: numbers .
dice2 := LoadedDice with: anotherNumbers .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGame startwith: amountOfPlayers   and: aGameBoard.
aGame playUntilWinner: arrayOfDices .




self deny: (aGame winner) equals: (aGameBoard shipAt: 1) .
self deny: (aGame winner) equals: (aGameBoard shipAt: 2) .
self deny: (aGame winner) equals: (aGameBoard shipAt: 3) .
"self assert: (aGame winner) equals: (4) ."




  
]

{ #category : #tests }
GameTests >> test017PlayWithMDicesAndNPlayersUntilTheGameEnds [
|amountOfDices|
aGame:= Game initializeEmpty.
numberOfLaps :=1.
amountOfPlayers := 4.
cells:= 8.

amountOfDices := 2.
dice1 := Dice with: 3 .
dice2 := Dice with: 5 .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGame startwith: amountOfPlayers   and: aGameBoard.
aGame playUntilWinner: arrayOfDices .

self assert: (aGame result) equals: 'The Game has ended'



  
]

{ #category : #tests }
GameTests >> test018PlayWithMLoadedDicesAndNPlayersUntilWinnerThenCheckFinalPositions [ 
amountOfPlayers := 4.
cells:= 8.
numberOfLaps :=1.

numbers := #(1 1 1 1)  .
anotherNumbers := #(2 2 2 4)  .
dice1 := LoadedDice with: numbers .
dice2 := LoadedDice with: anotherNumbers .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGame startwith: amountOfPlayers   and: aGameBoard.
aGame playUntilWinner: arrayOfDices .

self assert: (aGameBoard checkPositionOf: (aGameBoard shipAt: 2) ) equals: 6 .




  
]

{ #category : #tests }
GameTests >> test019PlayerHasAshipThenPlayerShipHasANumber [
|aPlayer|
aPlayer := Ship number: 1.


self assert: (aPlayer numberOfShip) equals: 1.




  
]

{ #category : #tests }
GameTests >> test020PlayWithMLoadedDicesAndNPlayersUntilWinnerThenCheckShipNumberAtFirstPositionEqualsOne [
amountOfPlayers := 4.
numberOfLaps:=1.
numbers := #(2 1 1 1)  .
dice1 := LoadedDice with: numbers .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .

aGame playUntilWinner: arrayOfDices .

self assert: (aGameBoard winner) equals: 1 .




  
]

{ #category : #tests }
GameTests >> test021PlayWithMDicesWithNegativeNumber [


self should:  [Dice with: -3] raise: Error withMessage: 'Cannot create die with negative amount of faces'.




  
]

{ #category : #tests }
GameTests >> test022PlayWithGameBoardWithNegativeAmountOfCellsThenThrowAnError [

self should:[ GameBoard  with: -4 ] raise: Error withMessage: 'Cannot create GameBoard with negative amount of cells'.




  
]

{ #category : #tests }
GameTests >> test023PlayerThrowWithTurns [ 

amountOfPlayers := 4.
numbers := #(1 1 1 1)  .
anotherNumbers := #(2 2 2 4)  .
dice1 := LoadedDice with: numbers .
dice2 := LoadedDice with: anotherNumbers .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGameBoard := GameBoard with: cells and: 1 .
aGame startwith: amountOfPlayers   and: aGameBoard.

aGame throwNextPlayer: arrayOfDices .

self assert: (aGameBoard checkPositionOf: (aGameBoard shipAt: 1) ) equals: 3 .




  
]

{ #category : #tests }
GameTests >> test024PlayWithLoadedDiceTwoTurnsThenCheckPositionOfTheSecondPlayer [


amountOfPlayers := 4.

numbers := #(1 1 1 1)  .
anotherNumbers := #(2 4 2 4)  .
dice1 := LoadedDice with: numbers .
dice2 := LoadedDice with: anotherNumbers .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGameBoard := GameBoard with: cells and: 1.
aGame startwith: amountOfPlayers   and: aGameBoard.

aGame throwNextPlayer: arrayOfDices .
aGame throwNextPlayer: arrayOfDices .

self assert: (aGameBoard checkPositionOf: (aGameBoard shipAt: 2) ) equals: 5 .




  
]

{ #category : #tests }
GameTests >> test025PlayThreeTurnsWithLoadedDiceAndTwoPlayersThenCheckPositionChangeOfTheFirstPlayer [

aGame:= Game initializeEmpty.
amountOfPlayers := 2.
cells:= 8.
numbers := #(1 1 )  .
anotherNumbers := #(2 2)  .
dice1 := LoadedDice with: numbers .
dice2 := LoadedDice with: anotherNumbers .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGameBoard := GameBoard with: cells and: 1.
aGame startwith: amountOfPlayers   and: aGameBoard.

aGame throwNextPlayer: arrayOfDices .
aGame throwNextPlayer: arrayOfDices .
aGame throwNextPlayer: arrayOfDices .

self assert: (aGameBoard checkPositionOf: (aGameBoard shipAt: 1) ) equals: 6 .




  
]

{ #category : #tests }
GameTests >> test026PlayThreeTurnsWithDiceAndCheckThereIsAWinner [

dice1 := Dice with: 4 .
dice2 := Dice with: 8.
numberOfLaps :=1.

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGameBoard := GameBoard with: 2 and: numberOfLaps  .
aGame startwith: amountOfPlayers   and: aGameBoard.

aGame throwNextPlayer: arrayOfDices .
aGame throwNextPlayer: arrayOfDices .
aGame throwNextPlayer: arrayOfDices .
aGame throwNextPlayer: arrayOfDices .
aGame throwNextPlayer: arrayOfDices .
aGame throwNextPlayer: arrayOfDices .
aGame throwNextPlayer: arrayOfDices .
aGame throwNextPlayer: arrayOfDices .
aGame throwNextPlayer: arrayOfDices .
aGame throwNextPlayer: arrayOfDices .

self deny: (aGameBoard winner = 0) .




  
]

{ #category : #tests }
GameTests >> test027GameBoardCircularWithXLaps [
numberOfLaps:= 3.
self assert: (aGameBoard laps >=1).




  
]

{ #category : #tests }
GameTests >> test028GameBoardCircularWithXLapsAndPlayerWithLaps [
self assert: (aGameBoard checkLapOf: (aGameBoard shipAt: 1) ) equals: 1 .




  
]

{ #category : #tests }
GameTests >> test029GameBoardCircularWithXLapsAndPlayerChangeAcualLap [

aGame throwNextPlayer: arrayOfDices .
aGame throwNextPlayer: arrayOfDices.


self assert: (aGameBoard checkLapOf: (aGameBoard shipAt: 1) ) equals: 2 .





  
]

{ #category : #tests }
GameTests >> test030GameBoardCircularWithXLapsAndPlayerCheckPositionInNewLap [

aGame throwNextPlayer: arrayOfDices .
aGame throwNextPlayer: arrayOfDices.


self assert: (aGameBoard checkPositionOf:(aGameBoard shipAt: 1) ) equals: 1 .





  
]

{ #category : #tests }
GameTests >> test031GameUsingSpeedUpEffect [
| speedUp|

speedUp:= SpeedUp new.

aGameBoard add: speedUp at: 3.

aGame throwNextPlayer: arrayOfDices .
aGame throwNextPlayer: arrayOfDices.

self assert: ((aGameBoard specialEffectAtCell: 3) isKindOf:  SpeedUp) .





  
]

{ #category : #tests }
GameTests >> test032GamePlayerFallsInSpeedUpEffectThenChangePosition [
| speedUp|

speedUp:= SpeedUp new.

numbers := #(1 1).
anotherNumbers := #(2 4).
dice1 := LoadedDice with: numbers .
dice2 := LoadedDice with: anotherNumbers .
arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2.

aGameBoard add: speedUp at: 3.

aGame throwNextPlayer: arrayOfDices .

self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 1) ) equals: 7 .





  
]

{ #category : #tests }
GameTests >> test033GameUsingWormHoleEffect [
|wormHole|

wormHole:= WormHole new.

aGameBoard add: wormHole at: 7.

aGame throwNextPlayer: arrayOfDices .
aGame throwNextPlayer: arrayOfDices.
self assert: ((aGameBoard specialEffectAtCell: 7) isKindOf:  WormHole) .





  
]

{ #category : #tests }
GameTests >> test034GamePlayerFallsInWormHoleEffectThenChangePosition [
| wormHole|
wormHole:= WormHole  new.
numbers := #(1 1 ).
anotherNumbers := #(6 4).
dice1 := LoadedDice with: numbers .
dice2 := LoadedDice with: anotherNumbers .
arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .
aGameBoard add: wormHole at: 7.
aGame throwNextPlayer: arrayOfDices .
self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 1) ) equals: 3 .





  
]

{ #category : #tests }
GameTests >> test035GamePlayAndCheckWinner [
| wormHole|
wormHole:= WormHole  new.
numbers := #(1 1 ).
anotherNumbers := #(6 4).
dice1 := LoadedDice with: numbers .
dice2 := LoadedDice with: anotherNumbers .
arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGame throwNextPlayer: arrayOfDices.
aGame throwNextPlayer: arrayOfDices.
aGame throwNextPlayer: arrayOfDices.

self assert: aGameBoard winner equals: 1 .





  
]

{ #category : #tests }
GameTests >> test036GamePlayerFallsInWormHoleAndThenSpeedUpOnlyWornHoleApplied [
| wormHole speedUp|
wormHole:= WormHole  new.
speedUp := SpeedUp new.
numbers := #(1 1 ).
anotherNumbers := #(6 4).
dice1 := LoadedDice with: numbers .
dice2 := LoadedDice with: anotherNumbers .
arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .
aGameBoard add: wormHole at: 7.
aGameBoard add: speedUp at: 3.
aGame throwNextPlayer: arrayOfDices .
self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 1) ) equals: 3 .





  
]

{ #category : #tests }
GameTests >> test037GamePUsingMoonWalk [
|aMoonWalk|

aMoonWalk := MoonWalk new.

aGameBoard add: aMoonWalk at: 2.

aGame throwNextPlayer: arrayOfDices .
aGame throwNextPlayer: arrayOfDices.
self assert: ((aGameBoard specialEffectAtCell: 2) isKindOf:  MoonWalk) .





  
]

{ #category : #tests }
GameTests >> test038GamePlayerFallsInWMoonWalkEffectThenChangePositionOfOtherPlayers [

|aMoonWalk|

aMoonWalk := MoonWalk with: -3.

amountOfPlayers:= 3.
numbers := #(1 1 ).
anotherNumbers := #(1 4).

dice1 := LoadedDice with: numbers .
dice2 := LoadedDice with: anotherNumbers .
arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGame startwith: amountOfPlayers   and: aGameBoard.

aGameBoard add: aMoonWalk at: 2 .
aGame throwNextPlayer: arrayOfDices.

self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 2) ) equals: -3 .
self assert: (aGameBoard checkLapOf: (aGameBoard shipAt: 2) ) equals: 0 .
self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 3) ) equals: -3 .
self assert: (aGameBoard checkLapOf: (aGameBoard shipAt: 3) ) equals: 0 .
self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 1) ) equals: 2 .
self assert: (aGameBoard checkLapOf: (aGameBoard shipAt: 1) ) equals: 1 .





  
]

{ #category : #tests }
GameTests >> test039GameHasTwoDifferentMoonWalksandDifferentPlayersFallInto [

|aMoonWalk anotherMoonWalk|

aMoonWalk := MoonWalk with: -3.
anotherMoonWalk := MoonWalk with: -2.
amountOfPlayers:= 3.
numbers := #(1 1 ).
anotherNumbers := #(1 6 ).

dice1 := LoadedDice with: numbers .
dice2 := LoadedDice with: anotherNumbers .
arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGame startwith: amountOfPlayers   and: aGameBoard.

aGameBoard add: aMoonWalk at: 2 .
aGameBoard add: anotherMoonWalk at: 4 .
aGame throwNextPlayer: arrayOfDices. 
aGame throwNextPlayer: arrayOfDices. 

self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 2) ) equals: 4 .
self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 3) ) equals: -5 .
self assert: (aGameBoard checkPositionOf:  (aGameBoard shipAt: 1) ) equals: 0 .






  
]
