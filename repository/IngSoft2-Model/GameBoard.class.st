Class {
	#name : #GameBoard,
	#superclass : #Object,
	#instVars : [
		'cells',
		'laps',
		'aCollectionOfSpecialCells',
		'parsecsByCell',
		'dieCollection',
		'turn',
		'aCollectionOfUsedCards',
		'lastEffectUsed',
		'aCollectionOfAccelerations',
		'collectionOfShips'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validating }
GameBoard class >> validateCanExistWith: numberOfCells and: numberOfLaps [
	|result|
	result := (numberOfCells > 1 )&(numberOfLaps >= 1 ).
	 result  ifFalse: [ 
		Error signal:
			'Cannot create GameBoard with negative amount of cells or laps' ]
]

{ #category : #creation }
GameBoard class >> with: numberOfCells and: numberOfLaps [ 
	self validateCanExistWith: numberOfCells and: numberOfLaps.
	^(self new) initializeWith: numberOfCells and: numberOfLaps.
	
	
	 
]

{ #category : #action }
GameBoard >> accelerations [
	^aCollectionOfAccelerations .
]

{ #category : #adding }
GameBoard >> add: aEffect at: aNumberOfCell [ 
	aCollectionOfSpecialCells add: (Cell with: aEffect  and: aNumberOfCell).
]

{ #category : #action }
GameBoard >> add: aCard to: numberOfPlayer [ 
	| aShip |
	aShip :=(self player: numberOfPlayer). 
	aShip add: aCard.
	
	
]

{ #category : #action }
GameBoard >> addEffects: aCollectionOfProbabilities forHyperJump: aCollectionOfDifferentParsecs [ 
	|randomNumber probabilities|
		
	probabilities := self createCollectionFrom: aCollectionOfProbabilities .
	
	0 to: cells do: [ :index | randomNumber:= 100 atRandom.
		
		( randomNumber >= (probabilities  at: 1) and: randomNumber < (probabilities at: 2)) ifTrue: [ 
			self add: (WormHole new) at: index. 
		 ].
	 (randomNumber >= (probabilities  at: 2) and: randomNumber < (probabilities at: 3)) ifTrue: [ 
			self add: (SpeedUp new) at: index. 
		 ].
	 (randomNumber >= (probabilities  at: 3) and: randomNumber < (probabilities at: 4)) ifTrue: [ 
			self add: (MoonWalk  with: (cells atRandom)*(-1)) at: index. 
		 ].
	 (randomNumber >= (probabilities  at: 4) and: randomNumber < (probabilities at: 5)) ifTrue: [ 
			self add: (HyperJump  with: aCollectionOfDifferentParsecs) at: index. 
		 ].
	(randomNumber >= (probabilities  at: 5) and: randomNumber < (probabilities at: 6)) ifTrue: [ 
			self add: (AtomicBomb  new) at: index. 
		 ].
	(randomNumber >= (probabilities  at: 6) and: randomNumber < (probabilities at: 7)) ifTrue: [ 
			self add: (CardAssignation new) at: index. 
		 ].].

]

{ #category : #counting }
GameBoard >> amountOf: typeOfSpecialEffect [

	| count |
	count := 0.
	aCollectionOfSpecialCells do: [ :each | 
		(each typeOfSpecialEffect isKindOf: typeOfSpecialEffect) ifTrue: [ 
			count := count + 1 ] ].

	^ count
]

{ #category : #validation }
GameBoard >> amountOfCells [
	^cells 
]

{ #category : #counter }
GameBoard >> amountOfNormalCells [
	^ cells - (aCollectionOfSpecialCells size) 
]

{ #category : #action }
GameBoard >> amountOfPlayers [
	^ collectionOfShips  size.
]

{ #category : #initialization }
GameBoard >> cellsWith: anAmountOfParsecs and: aCollectionOfDice [
	parsecsByCell := anAmountOfParsecs .
	dieCollection := aCollectionOfDice .
]

{ #category : #action }
GameBoard >> change: aShipPosition changingLap: aResult [ 
	 |result position newLap parsec newShipPosition|
	result := aResult .
		[ result   > cells ] whileTrue: [ 
		position:=result-cells.
		newLap:= ((aShipPosition isAtLap)+1) .
		parsec := aShipPosition isAtParsec .
		newShipPosition := ShipPosition createWith: position at: newLap and: parsec .
		result := result - cells ].
	^newShipPosition .
]

{ #category : #action }
GameBoard >> change: aShipPosition withMoreParsecsThanMax: aResult [ 
	|result position newShipPosition newLap parsecs|
	result:= aResult .
	[ result   > parsecsByCell  ] whileTrue: [ 
		
		position:=aShipPosition isAtPosition +1.
		newShipPosition := self verifyCellsOf: aShipPosition  at: position.
		position := newShipPosition isAtPosition .
		newLap := newShipPosition isAtLap .
		parsecs := Parsecs with: (result-parsecsByCell) .
		newShipPosition := ShipPosition createWith: position at: newLap and: parsecs  .
		result := result - parsecsByCell ].
	^newShipPosition .
]

{ #category : #action }
GameBoard >> change: aShipPosition withNegative: aResult [ 
	|newShipPosition result position newLap parsec|
	result := aResult .
	[ result   < 0 ] whileTrue: [ 
		(aShipPosition isAtLap = 1) ifTrue: [ 
				newShipPosition := ShipPosition createNew.
				result :=0 .
			] ifFalse: [  
				position:=cells + result.
				newLap:= ((aShipPosition isAtLap)-1) .
				parsec := aShipPosition isAtParsec .
				newShipPosition := ShipPosition createWith: position at: newLap and: parsec .
				result := cells + result ] ].
		
		^newShipPosition 
		
]

{ #category : #action }
GameBoard >> change: aShipPosition withNegativeParsecs: aResult [ 
	|newShipPosition  result  position newLap parsecs |
	result := aResult .
	[ result   < 0 ] whileTrue: [ 
		
		position:=aShipPosition isAtPosition -1.
		newShipPosition := self verifyCellsOf: aShipPosition  at: position.
		position := newShipPosition isAtPosition .
		newLap := newShipPosition isAtLap .
		parsecs := Parsecs with: (result+parsecsByCell ) .
		newShipPosition := ShipPosition createWith: position at: newLap and: parsecs .
		result :=result +parsecsByCell . 
		  ].
	^newShipPosition 
]

{ #category : #validation }
GameBoard >> checkLapOf: aShip [ 
	| anotherShip |
	anotherShip := self positionAtCollectionOf: aShip.
	^ (anotherShip shipPosition ) isAtLap.
]

{ #category : #validation }
GameBoard >> checkPositionOf: aShip [

	| anotherShip |
	anotherShip := self positionAtCollectionOf: aShip.
	^ ((anotherShip shipPosition ) isAtPosition)
]

{ #category : #action }
GameBoard >> createCollectionFrom: aCollection [

	| newCollection |
	newCollection := OrderedCollection new.
	newCollection add: (aCollection at: 1).
	2 to: aCollection size do: [ :index | 
		newCollection add:
			(newCollection at: index - 1) + (aCollection at: index) ].


	^ newCollection
]

{ #category : #action }
GameBoard >> createPositionIn: aResult with: aShipPosition [ 
	^(self verifyCellsOf: aShipPosition at: aResult).
]

{ #category : #assign }
GameBoard >> designateRandomCardTo: numberOfShip [
	|probabilities randomNumber|
	probabilities := #(0 10 20 30 40 50 60) .
		
		randomNumber:= 60 atRandom.
		
		( randomNumber >= (probabilities  at: 1) and: randomNumber < (probabilities at: 2)) ifTrue: [
			self add: (Overload new) to: numberOfShip.
		 ].
	 (randomNumber >= (probabilities  at: 2) and: randomNumber < (probabilities at: 3)) ifTrue: [ 
			self add: (Speed new) to: numberOfShip.
		 ].
	 (randomNumber >= (probabilities  at: 3) and: randomNumber < (probabilities at: 4)) ifTrue: [ 
			self add: (Cancellation new) to: numberOfShip.
		 ].
	 (randomNumber >= (probabilities  at: 4) and: randomNumber < (probabilities at: 5)) ifTrue: [ 
			self add: (Redo new) to: numberOfShip.
		 ].
	(randomNumber >= (probabilities  at: 5) and: randomNumber < (probabilities at: 6)) ifTrue: [ 
			self add: (Acceleration new) to: numberOfShip. 
		 ].
	(randomNumber >= (probabilities  at: 6) and: randomNumber <= (probabilities at: 7)) ifTrue: [ 
			self add: (Repeat new) to: numberOfShip. 
		 ].
]

{ #category : #action }
GameBoard >> diceResultOf: aShip [
	|dieResult|
	dieResult  := 0.
	dieResult  := self throwVariousDices: dieCollection .
	dieResult := dieResult + (aShip   resultOfCards) + (self sumOfAccelerations).
	^dieResult .
]

{ #category : #creating }
GameBoard >> fillWith: players [
	
	players do: [ :each | collectionOfShips add: each ].

	1 to: collectionOfShips size do: [ :counter | 
		self designateRandomCardTo: counter.
		self designateRandomCardTo: counter ]
]

{ #category : #initialization }
GameBoard >> initializeWith: numberOfCells and: numberOfLaps [ 
	cells := numberOfCells .
	laps := numberOfLaps.
	aCollectionOfSpecialCells := OrderedCollection new.
	collectionOfShips := OrderedCollection new.
	aCollectionOfUsedCards := OrderedCollection new.
	aCollectionOfAccelerations := OrderedCollection new.
]

{ #category : #validation }
GameBoard >> laps [
	^ laps
]

{ #category : #action }
GameBoard >> lastEffect [
	^lastEffectUsed.
]

{ #category : #action }
GameBoard >> move: aShip [ 
	| aNumberOfShip actualShipPosition result specialEffect auxResult aDieResult |

	aDieResult := self diceResultOf: aShip .
	aNumberOfShip := aShip numberOfShip.
	actualShipPosition := ((collectionOfShips at: aNumberOfShip)shipPosition) isAtPosition.
	result := actualShipPosition + aDieResult .
	auxResult := self updateResult: result.
	specialEffect := self specialEffectAtCell: auxResult.
	self move:(collectionOfShips at: aNumberOfShip) using: specialEffect and: result  .
]

{ #category : #action }
GameBoard >> move: aShip using: specialEffect and: result [ 
	|newPosition turnShip|
	newPosition := (self createPositionIn: result with:(aShip shipPosition)).
	aShip changePosition: newPosition.
	turnShip:= self player:  (self turn) .
	lastEffectUsed:= specialEffect applyTo:  self  for: turnShip  . 
]

{ #category : #validation }
GameBoard >> numberOfParsecs: aShip [ 
	| anotherShip |
	anotherShip := self positionAtCollectionOf: aShip.
	^ ((anotherShip shipPosition ) isAtParsec)
]

{ #category : #positioning }
GameBoard >> player: index [ 
	^ (collectionOfShips  at: index )
]

{ #category : #validation }
GameBoard >> positionAtCollectionOf: aShip [

	| anotherShip counter |
	counter := 1.
	anotherShip := collectionOfShips  at: counter.
	[ anotherShip isTheSameAs: aShip ] whileFalse: [ 
		counter := counter + 1.
		anotherShip := collectionOfShips  at: counter ].
	^ anotherShip
]

{ #category : #validation }
GameBoard >> ranking [
	| array sortedArray |
	array := collectionOfShips .
	sortedArray := array sorted: [:player1 :player2 | (player1 shipPosition ) isAtLap    < (player2 shipPosition ) isAtLap  ].
	sortedArray := sortedArray sorted: [:player1 :player2 | (player1 shipPosition )isAtPosition  < (player2 shipPosition )  isAtPosition ].
	sortedArray :=sortedArray sorted: [:player1 :player2 | ((player1 shipPosition) isAtParsec )nominalValue  < ((player2 shipPosition ) isAtParsec)nominalValue  ].
	^sortedArray 
	 
]

{ #category : #validation }
GameBoard >> specialEffectAtCell: aNumberOfCell [

	| typeOfCell |
	typeOfCell := NullEffect new.
	aCollectionOfSpecialCells do: [ :each | 
		each numberOfSpecialCell = aNumberOfCell ifTrue: [ 
			typeOfCell := each typeOfSpecialEffect ] ].

	^ typeOfCell
]

{ #category : #adding }
GameBoard >> store: anAcceleration [ 
	aCollectionOfAccelerations add: anAcceleration.
]

{ #category : #action }
GameBoard >> sumOfAccelerations [
	^ (aCollectionOfAccelerations size) * (Acceleration amountToChange).
]

{ #category : #action }
GameBoard >> throwVariousDices: aCollectionOfDices [

	| result |
	result := 0.
	aCollectionOfDices do: [ :each | result := result + each throw ].

	^ result
]

{ #category : #action }
GameBoard >> turn [
	^ turn
]

{ #category : #action }
GameBoard >> turnOf: numberOfShip [

	turn := numberOfShip.
	self winner = 0
		ifTrue: [ self move: (collectionOfShips at: numberOfShip) ]
		ifFalse: [ Error signal: 'There is a winner and the game has finished, unless you have a card that prevents it, you cant throw' ]
]

{ #category : #update }
GameBoard >> updateResult: aResult [
	|auxResult|
	auxResult := aResult.
	[ auxResult  > cells ] whileTrue: [ 
		auxResult := auxResult - cells . 
	 ].

	^ auxResult .
]

{ #category : #action }
GameBoard >> verifyCellsOf: aShipPosition at: aResult [ 
	|newShipPosition  result playerPosition  newLap parsec|
	playerPosition := aShipPosition isAtPosition .
	result := aResult. 
	(result   <= cells) ifTrue: [ 
		newLap:=aShipPosition isAtLap.
		parsec := aShipPosition isAtParsec .
		newShipPosition := ShipPosition createWith: result  at: newLap and: parsec .] .
	(result < 0 )ifTrue: [
		newShipPosition := self change: aShipPosition withNegative: result].
	(result > cells)ifTrue:[
		newShipPosition := self change: aShipPosition changingLap: result.
		].

	
	^ newShipPosition 


]

{ #category : #action }
GameBoard >> verifyParsecsOf: aShipPosition at: aNewParsec [
	|newShipPosition  result  position newLap |
	result := aNewParsec + (aShipPosition isAtParsec )nominalValue . 
	(result   <= parsecsByCell ) ifTrue: [ 
		newLap:=aShipPosition isAtLap.
		position := aShipPosition isAtPosition . 
		newShipPosition := ShipPosition createWith: position   at: newLap and: (Parsecs with: aNewParsec)   .] .
	(result <0)ifTrue:[
		newShipPosition := self change: aShipPosition  withNegativeParsecs: result  .
		].
	(result   > parsecsByCell) ifTrue:[
		newShipPosition := self change: aShipPosition  withMoreParsecsThanMax: result  .
		].
	
	^ newShipPosition 
]

{ #category : #validation }
GameBoard >> winner [

	| counter shipLap |
	counter := 1.
	shipLap := (collectionOfShips at: counter) shipPosition isAtLap.
	[ counter >= collectionOfShips size or: shipLap >= (laps + 1) ] 
		whileFalse: [ counter := counter + 1. 
			shipLap := (collectionOfShips at: counter) shipPosition isAtLap.].

	(counter <= collectionOfShips size and: shipLap >= (laps + 1))
		ifTrue: [ ^ (collectionOfShips at: counter) numberOfShip ]
		ifFalse: [ ^ 0 ]
]

{ #category : #creation }
GameBoard >> withNew: aResult and: aShipPosition [ 
	^(self verifyParsecsOf: aShipPosition at: aResult).
]
