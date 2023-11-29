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
		'die1',
		'die2',
		'arrayOfDie',
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
	die1  := LoadedDie with: numbers .
	die2  := LoadedDie with: anotherNumbers .

	arrayOfDie  := OrderedCollection new.
	arrayOfDie  add: die1  .
	arrayOfDie  add: die2 .
	
	
	aGameBoard := GameBoard with: cells and: numberOfLaps.
	aGameBoard cellsWith: 0 and: arrayOfDie  .
	aGame startwith: amountOfPlayers   and: aGameBoard.
]

{ #category : #running }
GameTests >> setUpGameWith:  anAmountOfPlayers andGameboardWith: anAmountOfCells and: laps [
	aGame:= ShipsGame initializeEmpty.
	
	cells:= anAmountOfCells .
	numberOfLaps:= laps.
	amountOfPlayers := anAmountOfPlayers .
	
	aGameBoard := GameBoard with: cells and: numberOfLaps.
	aGameBoard cellsWith: 0 and: arrayOfDie  .
	aGame startwith: amountOfPlayers   and: aGameBoard.
]

{ #category : #running }
GameTests >> setUpLoadedDiceWith: array1 and: array2 [
	
	numbers := array1 .
	anotherNumbers := array2 .
	die1 := LoadedDie with: numbers .
	die2 := LoadedDie with: anotherNumbers .

	arrayOfDie := OrderedCollection new.
	arrayOfDie add: die1 .
	arrayOfDie add: die2.
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
aShip := ShipPosition new.
"aGame startwith: aShip ."
 
self deny: aGame result equals: aShip  
]

{ #category : #tests }
GameTests >> test004GameIsStartedWithAGameBoardThenCheckTheAmountOfCells [
| aShip  players|
aGame:= GameTest initializeEmpty.
aShip  := ShipPosition  new.
players := OrderedCollection new.
players add: aShip .
cells:= 4.
aGameBoard := GameBoard with: cells and: 1.

"aGame startwith: players and: aGameBoard.
 
self assert: aGameBoard amountOfCells equals: 4 ." "OBSOLET BECAUSE WE ADDED THE CARDS"
]

{ #category : #tests }
GameTests >> test005ShipHasPosition [
| aPlayer   dice  players|
aGame:= GameTest initializeEmpty.
aPlayer := ShipPosition   new.
players := OrderedCollection new.
players add: aPlayer .
dice := 0.
cells:= 4.
aGameBoard := GameBoard with: cells and: 1.

"aGame startwith: players and: aGameBoard.

self assert: (aGameBoard playerPosition: dice ) equals: 0." "OBSOLET BECAUSE WE ADDED THE CARDS"
 

  
]

{ #category : #tests }
GameTests >> test006ShipPositionLowerThanTotalCellsThenNotWinner [
| aPlayer   players|
aGame:= GameTest initializeEmpty.
aPlayer := ShipPosition new.
players := OrderedCollection new.
players add:aPlayer.
cells:= 4.
aGameBoard := GameBoard with: cells and: 1.
"aGame startwith: players and: aGameBoard.

self deny: aGame result equals: aPlayer." "OBSOLET BECAUSE WE ADDED THE CARDS"

  
]

{ #category : #tests }
GameTests >> test007ShipPositionSameAsTotalCellsThenWinner [
|  aPlayer  dice players|
aGame:= GameTest initializeEmpty.
aPlayer := ShipPosition new.
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
aPlayer := ShipPosition new.
players := OrderedCollection new.
players add:aPlayer.
cells:= 4.
dice:= 4.
aGameBoard := GameBoard with: cells and: 1.
"aGame startwith: players and: aGameBoard."
"aGameBoard move: aPlayer adding: dice.
self assert: (aGameBoard checkPositionOf:aPlayer) equals: cells."

  
]

{ #category : #tests }
GameTests >> test009PlayersPlayTheGame2RoundsThenCheckPositions [
| marian delfi  players  dice |
aGame:= GameTest initializeEmpty.
marian := ShipPosition new.
delfi := ShipPosition new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
dice:= 1.
aGameBoard := GameBoard with: cells and: 1.
"aGame startwith: players  and: aGameBoard."
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
marian := ShipPosition new.
delfi := ShipPosition new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
dice:= 1.
aGameBoard := GameBoard with: cells and: 1.
"aGame startwith: players  and: aGameBoard."
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
marian := ShipPosition new.
delfi := ShipPosition new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
numbers := #(1 1 1)  .
dice:= LoadedDie with:numbers.

arrayOfDie  := OrderedCollection new.
arrayOfDie  add: dice .

aGameBoard := GameBoard with: cells and:1 .
"aGame startwith: players  and: aGameBoard." "OBSOLET BECAUSE WE ADDED THE CARDS"
"aGame playUntilWinner: arrayOfDices."

"self assert: (aGameBoard checkPositionOf: delfi)equals: 3. "
"Cambiaron las implementaciones"




  
]

{ #category : #tests }
GameTests >> test011PlayersRoundsUntilOneWins [
| marian delfi  players  dice |
aGame:= GameTest initializeEmpty.
marian := ShipPosition new.
delfi := ShipPosition new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
numbers := #(1 1 1)  .
dice:= LoadedDie with:numbers.

arrayOfDie  := OrderedCollection new.
arrayOfDie  add: dice .

aGameBoard := GameBoard with: cells and:1.
"aGame startwith: players  and: aGameBoard." "OBSOLET BECAUSE WE ADDED THE CARDS"
"aGame playUntilWinner: arrayOfDices."

"self assert: (aGame winner)equals: marian. 
self deny: (aGame winner)equals: delfi."

"Cambió la implementacion del winner"




  
]

{ #category : #tests }
GameTests >> test012PlayersRoundsUntilOneWins [
| marian delfi  players  dice |
aGame:= GameTest initializeEmpty.
marian := ShipPosition new.
delfi := ShipPosition new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
numbers := #(1 2 3)  .
dice:= LoadedDie with:numbers.

arrayOfDie := OrderedCollection new.
arrayOfDie add: dice .

aGameBoard := GameBoard with: cells and:1.
"aGame startwith: players  and: aGameBoard." "OBSOLET BECAUSE WE ADDED THE CARDS"
"aGame playUntilWinner: arrayOfDices."

"self assert: (aGame  winner)equals: marian. "

"Cambio la implementacion del winner"



  
]

{ #category : #tests }
GameTests >> test013PlayWithLoadedDiceThenWinsPlayer2 [
| marian delfi  players  dice  |
aGame:= GameTest initializeEmpty.
marian := ShipPosition new.
delfi := ShipPosition new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
dice:= LoadedDie .
numbers := #(1 2 1 4)  .
dice := LoadedDie with: numbers .

arrayOfDie := OrderedCollection new.
arrayOfDie add: dice .

aGameBoard := GameBoard with: cells and:1.
"aGame startwith: players  and: aGameBoard." "OBSOLETO 2"
"aGame playUntilWinner: arrayOfDices." "OBSOLETO"

"self assert: (aGame winner)equals: delfi . "

"Cambio la implementacion del winner"

]

{ #category : #tests }
GameTests >> test014playWithRandomDiceThenWinner [
| marian delfi  players  aDice  |
aGame:= GameTest initializeEmpty.
marian := ShipPosition new.
delfi := ShipPosition new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
aDice := Die with: 4.

arrayOfDie := OrderedCollection new.
arrayOfDie add: aDice .

aGameBoard := GameBoard with: cells and:1.
"aGame startwith: players  and: aGameBoard." "OBSOLETO 2"
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

arrayOfDie := OrderedCollection new.
arrayOfDie add: dice .

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
die1 := LoadedDie with: numbers .
die2 := LoadedDie with: anotherNumbers .

arrayOfDie := OrderedCollection new.
arrayOfDie add: die1 .
arrayOfDie add: die2 .

aGame startwith: amountOfPlayers   and: aGameBoard.
"aGame playUntilWinner: arrayOfDices . ""OBSOLETO"

self deny: (aGame winner) equals: (aGameBoard player: 1) .
self deny: (aGame winner) equals: (aGameBoard player: 2) .
self deny: (aGame winner) equals: (aGameBoard player: 3) .
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
die1 := Die with: 3 .
die2 := Die with: 5 .

arrayOfDie  := OrderedCollection new.
arrayOfDie add: die1 .
arrayOfDie add: die2 .

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
die1 := LoadedDie with: numbers .
die2 := LoadedDie with: anotherNumbers .

arrayOfDie := OrderedCollection new.
arrayOfDie add: die1 .
arrayOfDie add: die2 .

aGame startwith: amountOfPlayers   and: aGameBoard.
"aGame playUntilWinner: arrayOfDices ." "OBSOLETO"
 
"self assert: (aGameBoard checkPositionOf: (aGameBoard shipAt: 2) ) equals: 6 ."

"Obsoleto"




  
]

{ #category : #tests }
GameTests >> test019PlayerHasAshipThenPlayerShipHasANumber [
|aPlayer|
aPlayer := Ship with:  1.


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
	die1  := LoadedDie with: numbers .
	die2  := LoadedDie with: anotherNumbers .

	arrayOfDie  := OrderedCollection new.
	arrayOfDie add: die1  .
	arrayOfDie add: die2 .
	
	
	aGameBoard := GameBoard with: cells and: numberOfLaps.
	aGameBoard cellsWith: 0 and: arrayOfDie .
	aGame startwith: amountOfPlayers   and: aGameBoard.
	
amountOfPlayers := 4.
numberOfLaps:=1.
numbers := #(2 1 1 1)  .
die1  := LoadedDie with: numbers .

arrayOfDie := OrderedCollection new.
arrayOfDie add: die1  .

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

self setUpLoadedDiceWith: #(1 1 1 1) and: #(2 2 2 4) .
self setUpGameWith:4 andGameboardWith: cells and:1 .

aGame throwNextPlayer.

self assert: (aGameBoard checkPositionOf: (aGameBoard player: 1) ) equals: 3 .




  
]

{ #category : #tests }
GameTests >> test024PlayWithLoadedDiceTwoTurnsThenCheckPositionOfTheSecondPlayer [

self setUpLoadedDiceWith: #(1 1 1 1) and: #(2 7 2 4) .
self setUpGameWith:4 andGameboardWith: 8 and: 1 .

aGame throwNextPlayer .
aGame throwNextPlayer .

self assert: (aGameBoard checkPositionOf: (aGameBoard player: 2) ) equals: 8 .




  
]

{ #category : #tests }
GameTests >> test025PlayThreeTurnsWithLoadedDiceAndTwoPlayersThenCheckPositionChangeOfTheFirstPlayer [

self setUpLoadedDiceWith: #(1 1) and: #(2 2) .
self setUpGameWith: 2 andGameboardWith: 8 and: 1 .

aGame throwNextPlayer .
aGame throwNextPlayer .
aGame throwNextPlayer .

self assert: (aGameBoard checkPositionOf: (aGameBoard player: 1) ) equals: 6 .




  
]

{ #category : #tests }
GameTests >> test026PlayWithNormalDieAndCheckThereIsAWinner [

	die1 := Die with: 20.
	die2 := Die with: 15.

	arrayOfDie := OrderedCollection new.
	arrayOfDie add: die1.
	arrayOfDie add: die2.

	self setUpGameWith: 2 andGameboardWith: 2 and: 1.

	aGame throwNextPlayer.
	self deny: aGameBoard winner equals: 0
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

self assert: (aGameBoard checkLapOf: (aGameBoard player: 1) ) equals: 1 .




  
]

{ #category : #tests }
GameTests >> test029GameBoardCircularWithXLapsAndPlayerChangeAcualLap [

self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
self setUpGameWith: 1 andGameboardWith: 8 and: 2.

aGame throwNextPlayer .
aGame throwNextPlayer.

self assert: (aGameBoard checkLapOf: (aGameBoard player: 1) ) equals: 2 .





  
]

{ #category : #tests }
GameTests >> test030GameBoardCircularWithXLapsAndPlayerCheckPositionInNewLap [

self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
self setUpGameWith: 1 andGameboardWith: 8 and: 2.

aGame throwNextPlayer .
aGame throwNextPlayer.


self assert: (aGameBoard checkPositionOf:(aGameBoard player: 1) ) equals: 1 .
self assert: (aGameBoard checkLapOf: (aGameBoard player: 1)) equals: 2.





  
]

{ #category : #tests }
GameTests >> test031RankingPlayersHavingPlayedAll [
| parsecs  amountOfParsecsToMove aRanking|

self setUpGameWith: 3 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 2) and: #(3 2 4).
amountOfParsecsToMove:= #(7 3 2 1).
parsecs := 4. 
aGameBoard cellsWith: parsecs and: arrayOfDie .

aGame throwNextPlayer.
aGame throwNextPlayer.
aGame throwNextPlayer.
aRanking := aGame ranking.

self assert: (aRanking at: 1) numberOfShip  equals: 3 .
self assert: (aRanking at: 2) numberOfShip  equals: 1 .
self assert: (aRanking at: 3) numberOfShip  equals: 2 .





  
]

{ #category : #tests }
GameTests >> test052UsingRandomDieAndCheckingTheResult [
| die result|
die := Die with: 5.
result:= die throw .
self assert: (result > 0).





  
]

{ #category : #tests }
GameTests >> test053GameUsingCellWithCardThenValidateAmountOfCards [
|anSpecialCard|

self setUpLoadedDiceWith: #(1 1 ) and: #(3 4 ).
self setUpGameWith: 1 andGameboardWith: 8 and: 2.

anSpecialCard := CardAssignation new.
aGameBoard add: anSpecialCard at: 4.

aGame throwNextPlayer .

self assert: (((aGameBoard player: 1)shipCards) cardsInHand size) equals: 3.

]

{ #category : #tests }
GameTests >> test054GameUsingWormholeAndShipDecreasesLapWhenFalling [
| wormHole|
wormHole:= WormHole  new.

self setUpLoadedDiceWith: #(1 1 ) and: #(5 0 ).
self setUpGameWith: 1 andGameboardWith: 4 and: 2.

aGameBoard add: wormHole at: 3.

aGame throwNextPlayer.
self assert: (aGameBoard checkLapOf:  (aGameBoard player: 1) ) equals: 2 .
aGame throwNextPlayer.
self assert: (aGameBoard checkLapOf:  (aGameBoard player: 1) ) equals: 1 .





  
]

{ #category : #tests }
GameTests >> test055UsingParsecsAndLightYears [
|parsecs lightYears|

parsecs := Parsecs with: 2.
lightYears := LightYears with: 9. 

self assert: ((parsecs plus: lightYears)nominalValue) equals: 5





  
]

{ #category : #tests }
GameTests >> test056GameWithLightYearsAndParsecsInHyperJump [
| parsecs hyperJump amountOfParsecsToMove parsc1 parsc2 light1 light2 collection1 aShip|

self setUpGameWith: 1 andGameboardWith: 8 and: 2.
self setUpLoadedDiceWith: #(1 1 ) and: #(2 6 ).
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

aShip:=((aGameBoard player: 1)).
self assert: ((aGameBoard numberOfParsecs: (aGameBoard player: 1)  )nominalValue)  equals: 3  .
self assert: (aGameBoard checkPositionOf:  aShip ) equals: 4  .

aGame throwNextPlayer.
self assert: ((aGameBoard numberOfParsecs: aShip )nominalValue)  equals: 2  .
self assert: (aGameBoard checkPositionOf:  aShip ) equals: 4  .





  
]

{ #category : #tests }
GameTests >> test057GamePlayersWithShipPositionShipCards [

self setUpGameWith: 1 andGameboardWith: 4 and: 1.

self assert: (((aGameBoard player: 1)shipPosition)isAtPosition ) equals: 0





  
]

{ #category : #tests }
GameTests >> test058WhenThereIsAWinnerNextPlayerCantThrow [
| parsecs  amountOfParsecsToMove|

self setUpGameWith: 2 andGameboardWith: 8 and: 1.
self setUpLoadedDiceWith: #(1 1 2) and: #(3 2 5).
amountOfParsecsToMove:= #(7 3 2 1).
parsecs := 4. 
aGameBoard cellsWith: parsecs and: arrayOfDie .

aGame throwNextPlayer. "P1: 4 LAP1 P2: 0 LAP1"
aGame throwNextPlayer. "P1: 4 LAP1 P2: 3 LAP1"
aGame throwNextPlayer. "P1: 3 LAP2 P2: 3 LAP1  --> Ship 1 has won"

self assert: aGame winner equals: 1. 
self should:  [aGame throwNextPlayer] raise: Error withMessage: 'There is a winner and the game has finished, unless you have a card that prevents it, you cant throw'.





  
]
