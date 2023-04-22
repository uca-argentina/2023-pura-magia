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
GameTests >> test003GameIsStartedThenMessageThatHasNoWinners [
|aGame aPlayer|
aGame:= Game initializeEmpty.
aPlayer := Player new.
aGame startwith: aPlayer.
 
self assert: aGame result equals: aPlayer  
]

{ #category : #tests }
GameTests >> test004GameIsStartedWithAGameBoardAndPlayer [
|aGame aPlayer aGameBoard cells players|
aGame:= Game initializeEmpty.
aPlayer := Player new.
players := OrderedCollection new.
players add: aPlayer .
cells:= 4.
aGameBoard := GameBoard with: cells .

aGame startwith: players and: aGameBoard.
 
self assert: aGameBoard amountOfCells equals: 4  
]

{ #category : #tests }
GameTests >> test005PlayerHasPosition [
|aGame aPlayer aGameBoard cells dice  players|
aGame:= Game initializeEmpty.
aPlayer := Player new.
players := OrderedCollection new.
players add: aPlayer .
dice := 0.
cells:= 4.
aGameBoard := GameBoard with: cells .

aGame startwith: players and: aGameBoard.

self assert: (aGameBoard playerPosition: dice ) equals: 0.
 

  
]

{ #category : #tests }
GameTests >> test006PlayerPositionLessThanToatalsCellsThenNotWinner [
|aGame aPlayer aGameBoard cells players|
aGame:= Game initializeEmpty.
aPlayer := Player new.
players := OrderedCollection new.
players add:aPlayer.
cells:= 4.
aGameBoard := GameBoard with: cells .
aGame startwith: players and: aGameBoard.

self deny: aGame result equals: aPlayer.

  
]

{ #category : #tests }
GameTests >> test007PlayerPositionLessThanToatalsCellsThenWinner [
|aGame aPlayer aGameBoard cells dice players|
aGame:= Game initializeEmpty.
aPlayer := Player new.
players := OrderedCollection new.
players add:aPlayer.
cells:= 4.
dice:= 4.
aGameBoard := GameBoard with: cells .
aGame startwith: players and: aGameBoard.
aGameBoard move: aPlayer adding: dice.
self assert: aGameBoard checkPosition equals: cells.

  
]

{ #category : #tests }
GameTests >> test008PlayersPlayTheGame2Rounds [
|aGame aPlayer aGameBoard cells dice players|
aGame:= Game initializeEmpty.
aPlayer := Player new.
players := OrderedCollection new.
players add:aPlayer.
cells:= 4.
dice:= 4.
aGameBoard := GameBoard with: cells .
aGame startwith: players and: aGameBoard.
aGameBoard move: aPlayer adding: dice.
self assert: aGameBoard checkPosition equals: cells.

  
]

{ #category : #tests }
GameTests >> test009PlayersPlayTheGame2Rounds [
|aGame marian delfi aGameBoard players cells dice|
aGame:= Game initializeEmpty.
marian := Player new.
delfi := Player new.
players := OrderedCollection new.
players add: marian.
players add:delfi.
cells:= 4.
dice:= 1.
aGameBoard := GameBoard with: cells .
aGame startwith: players  and: aGameBoard.
aGameBoard move: marian  adding: dice.
self assert: (aGameBoard  checkPosition: marian  )  equals: 1.
dice:=2.
aGameBoard move: delfi   adding: dice.
self assert: (aGameBoard  checkPosition: delfi  )  equals: 2.
aGameBoard move: marian  adding: dice.
self assert: (aGameBoard  checkPosition: marian  )  equals: 3.

  
]
