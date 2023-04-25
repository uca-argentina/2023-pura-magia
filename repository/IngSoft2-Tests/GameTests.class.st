Class {
	#name : #GameTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTests >> test001GameIsCreated [
|aGame|
aGame:= Game new.
self assert:(aGame isKindOf: Game)
]

{ #category : #tests }
GameTests >> test002GameStateBeforeStartThenMessage [
|aGame|
aGame:= Game initializeEmpty.
self assert: aGame result equals: 'The Game does not have a winner'  
]

{ #category : #tests }
GameTests >> test003GameIsStartedThenWinnerShip [
|aGame aShip|
aGame:= Game initializeEmpty.
aShip := Ship new.
aGame startwith: aShip .
 
self assert: aGame result equals: aShip  
]

{ #category : #tests }
GameTests >> test004GameIsStartedWithAGameBoardThenCheckTheAmountOfCells [
|aGame aShip aGameBoard cells players|
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
|aGame aPlayer aGameBoard cells dice  players|
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
|aGame aPlayer aGameBoard cells players|
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
|aGame aPlayer aGameBoard cells dice players|
aGame:= GameTest initializeEmpty.
aPlayer := Ship new.
players := OrderedCollection new.
players add:aPlayer.
cells:= 4.
dice:= 4.
aGameBoard := GameBoard with: cells .
aGame startwith: players and: aGameBoard.
aGameBoard move: aPlayer adding: dice.

self assert: (aGameBoard checkPositionOf:aPlayer) equals: cells.
self assert: (aGame winner) equals: aPlayer 

  
]

{ #category : #tests }
GameTests >> test008PlayerPlayTheGame2RoundsThenFinalPositionEqualsAmountOfCells [
|aGame aPlayer aGameBoard cells dice players|
aGame:= GameTest initializeEmpty.
aPlayer := Ship new.
players := OrderedCollection new.
players add:aPlayer.
cells:= 4.
dice:= 4.
aGameBoard := GameBoard with: cells .
aGame startwith: players and: aGameBoard.
aGameBoard move: aPlayer adding: dice.
self assert: (aGameBoard checkPositionOf:aPlayer) equals: cells.

  
]

{ #category : #tests }
GameTests >> test009PlayersPlayTheGame2RoundsThenCheckPositions [
|aGame marian delfi aGameBoard players cells dice|
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
aGameBoard move: marian  adding: dice.
self assert: (aGameBoard  checkPositionOf: marian  )  equals: 1.
dice:=2.
aGameBoard move: delfi   adding: dice.
self assert: (aGameBoard  checkPositionOf: delfi  )  equals: 2.
aGameBoard move: marian  adding: dice.
self assert: (aGameBoard  checkPositionOf: marian  )  equals: 3.

  
]

{ #category : #tests }
GameTests >> test010PlayersPlayTheGame3RoundsThenPlayer1Wins [
|aGame marian delfi aGameBoard players cells dice|
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
aGameBoard move: marian  adding: dice.
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
self assert: (aGameBoard  checkPositionOf: marian  )  equals: 4.
self assert: (aGame winner) equals: marian.



  
]

{ #category : #tests }
GameTests >> test011PlayersPlayWithRoundsThenCheckPosition [
|aGame marian delfi aGameBoard players cells dice numbers arrayOfDices|
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

aGameBoard := GameBoard with: cells .
aGame startwith: players  and: aGameBoard.
aGame playUntilWinner: arrayOfDices.

self assert: (aGameBoard checkPositionOf: delfi)equals: 3. 




  
]

{ #category : #tests }
GameTests >> test011PlayersRoundsUntilOneWins [
|aGame marian delfi aGameBoard players cells dice numbers arrayOfDices|
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

aGameBoard := GameBoard with: cells .
aGame startwith: players  and: aGameBoard.
aGame playUntilWinner: arrayOfDices.

self assert: (aGame winner)equals: marian. 
self deny: (aGame winner)equals: delfi.




  
]

{ #category : #tests }
GameTests >> test012PlayersRoundsUntilOneWins [
|aGame marian delfi aGameBoard players cells dice numbers arrayOfDices|
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

aGameBoard := GameBoard with: cells .
aGame startwith: players  and: aGameBoard.
aGame playUntilWinner: arrayOfDices.

self assert: (aGame  winner)equals: marian. 



  
]

{ #category : #tests }
GameTests >> test013PlayWithLoadedDiceThenWinsPlayer2 [
|aGame marian delfi aGameBoard players cells dice numbers arrayOfDices|
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

aGameBoard := GameBoard with: cells .
aGame startwith: players  and: aGameBoard.
aGame playUntilWinner: arrayOfDices.

self assert: (aGame winner)equals: delfi . 



  
]

{ #category : #tests }
GameTests >> test014playWithRandomDiceThenWinner [
|aGame marian delfi aGameBoard players cells aDice arrayOfDices|
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

aGameBoard := GameBoard with: cells .
aGame startwith: players  and: aGameBoard.
aGame playUntilWinner: arrayOfDices.

self assert: ((aGame winner)isKindOf:  Ship) . 



  
]

{ #category : #tests }
GameTests >> test015PlayWithNPlayersUntilGameEnds [
|aGame aGameBoard amountOfPlayers cells dice numbers arrayOfDices|
aGame:= Game initializeEmpty.
amountOfPlayers := 4.
cells:= 8.
dice:= LoadedDice .
numbers := #(1 2 1 4)  .
dice := LoadedDice with: numbers .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice .

aGameBoard := GameBoard with: cells .
aGame startwith: amountOfPlayers   and: aGameBoard.
aGame playUntilWinner: arrayOfDices.

self assert: (aGame result) equals: 'The Game has ended' . 



  
]

{ #category : #tests }
GameTests >> test016PlayWithMLoadedDicesAndNPlayersThenCheckWinner [
|aGame aGameBoard amountOfPlayers amountOfDices anotherNumbers cells dice1 dice2 numbers arrayOfDices|
aGame:= Game initializeEmpty.
amountOfPlayers := 4.
cells:= 8.

amountOfDices := 2.

numbers := #(1 1 1 1)  .
anotherNumbers := #(2 2 2 4)  .
dice1 := LoadedDice with: numbers .
dice2 := LoadedDice with: anotherNumbers .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGameBoard := GameBoard with: cells .
aGame startwith: amountOfPlayers   and: aGameBoard.
aGame playUntilWinner: arrayOfDices .

self deny: (aGame winner) equals: (aGameBoard shipAt: 1) .
self deny: (aGame winner) equals: (aGameBoard shipAt: 2) .
self deny: (aGame winner) equals: (aGameBoard shipAt: 3) .
self assert: (aGame winner) equals: (aGameBoard shipAt: 4) .




  
]

{ #category : #tests }
GameTests >> test017PlayWithMDicesAndNPlayersUntilTheGameEnds [
|aGame aGameBoard amountOfPlayers amountOfDices cells dice1 dice2 arrayOfDices |
aGame:= Game initializeEmpty.
amountOfPlayers := 4.
cells:= 8.

amountOfDices := 2.
dice1 := Dice with: 3 .
dice2 := Dice with: 5 .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGameBoard := GameBoard with: cells .
aGame startwith: amountOfPlayers   and: aGameBoard.
aGame playUntilWinner: arrayOfDices .

self assert: (aGame result) equals: 'The Game has ended'



  
]

{ #category : #tests }
GameTests >> test018PlayWithMLoadedDicesAndNPlayersUntilWinnerThenCheckFinalPositions [ 
|aGame aGameBoard amountOfPlayers amountOfDices anotherNumbers cells dice1 dice2 numbers arrayOfDices|
aGame:= Game initializeEmpty.
amountOfPlayers := 4.
cells:= 8.

amountOfDices := 2.

numbers := #(1 1 1 1)  .
anotherNumbers := #(2 2 2 4)  .
dice1 := LoadedDice with: numbers .
dice2 := LoadedDice with: anotherNumbers .

arrayOfDices := OrderedCollection new.
arrayOfDices add: dice1 .
arrayOfDices add: dice2 .

aGameBoard := GameBoard with: cells .
aGame startwith: amountOfPlayers   and: aGameBoard.
aGame playUntilWinner: arrayOfDices .

self assert: (aGameBoard checkPositionOf: (aGameBoard shipAt: 2) ) equals: 6 .




  
]
