Class {
	#name : #GameBoard,
	#superclass : #Object,
	#instVars : [
		'cells',
		'collectionOfShipPositions',
		'laps',
		'aCollectionOfSpecialCells',
		'parsecsByCell',
		'dieCollection',
		'turn',
		'aCollectionOfUsedCards',
		'lastEffectUsed',
		'aCollectionOfAccelerations',
		'positionManager'
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

{ #category : #adding }
GameBoard >> add: aEffect at: aNumberOfCell [ 
	aCollectionOfSpecialCells add: (Cell with: aEffect  and: aNumberOfCell).
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
			self add: (DrawEffect  new) at: index. 
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
	^ collectionOfShipPositions  size.
]

{ #category : #action }
GameBoard >> cardForAllPlayers [
	^aCollectionOfAccelerations .
]

{ #category : #initialization }
GameBoard >> cellsWith: anAmountOfParsecs and: aCollectionOfDice [
	parsecsByCell := anAmountOfParsecs .
	positionManager := PositionManager with: cells and: anAmountOfParsecs .
	dieCollection := aCollectionOfDice .
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

{ #category : #accessing }
GameBoard >> collectionOfShipPositions [
	^ collectionOfShipPositions
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

{ #category : #creation }
GameBoard >> createWithNew: aResult with: aShipPosition [ 
	^(self verifyParsecsOf: aShipPosition at: aResult).
]

{ #category : #action }
GameBoard >> diceResultOf: aShip [
	|dieResult|
	dieResult  := 0.
	dieResult  := self throwVariousDices: dieCollection .
	dieResult := dieResult + (aShip   resultOfCards) + (self sumOfAccelerations).
	^dieResult .
]

{ #category : #accessing }
GameBoard >> fill: players [ 
		players do: [ :each | self collectionOfShipPositions add: each ].
]

{ #category : #initialization }
GameBoard >> initializeWith: numberOfCells and: numberOfLaps [ 
	cells := numberOfCells .
	laps := numberOfLaps.
	aCollectionOfSpecialCells := OrderedCollection new.
	collectionOfShipPositions := OrderedCollection new.
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
	actualShipPosition := ((collectionOfShipPositions at: aNumberOfShip)shipPosition) isAtPosition.
	result := actualShipPosition + aDieResult .
	auxResult := self updateResult: result.
	specialEffect := self specialEffectAtCell: auxResult.
	self move:(collectionOfShipPositions at: aNumberOfShip) using: specialEffect and: result  .
]

{ #category : #action }
GameBoard >> move: aShip using: specialEffect and: result [ 
	|newPosition turnShip|
	newPosition := positionManager manageCellsOf: aShip shipPosition at: result.
	aShip changePosition: newPosition.
	turnShip:= self player:  (self turn) .
	
	lastEffectUsed := specialEffect applyTo:  self  for: turnShip  . 
]

{ #category : #validation }
GameBoard >> numberOfParsecs: aShip [ 
	| anotherShip |
	anotherShip := self positionAtCollectionOf: aShip.
	^ ((anotherShip shipPosition ) isAtParsec)
]

{ #category : #positioning }
GameBoard >> player: index [ 
	^ (collectionOfShipPositions  at: index )
]

{ #category : #validation }
GameBoard >> positionAtCollectionOf: aShip [

	| anotherShip counter |
	counter := 1.
	anotherShip := collectionOfShipPositions  at: counter.
	[ anotherShip isTheSameAs: aShip ] whileFalse: [ 
		counter := counter + 1.
		anotherShip := collectionOfShipPositions  at: counter ].
	^ anotherShip
]

{ #category : #accessing }
GameBoard >> positionManager [
	^ positionManager
]

{ #category : #validation }
GameBoard >> ranking [
	| array sortedArray |
	array := collectionOfShipPositions .
	sortedArray := array sorted: [:player1 :player2 | (player1 shipPosition ) isAtLap    < (player2 shipPosition ) isAtLap  ].
	sortedArray := sortedArray sorted: [:player1 :player2 | (player1 shipPosition )isAtPosition  < (player2 shipPosition )  isAtPosition ].
	sortedArray :=sortedArray sorted: [:player1 :player2 | ((player1 shipPosition) isAtParsec )nominalValue  < ((player2 shipPosition ) isAtParsec)nominalValue  ].
	^sortedArray 
	 
]

{ #category : #action }
GameBoard >> resultOf: aShip [
	|dieResult|
	dieResult  := 0.
	dieResult  := self throwVariousDices: dieCollection .
	dieResult := dieResult + (aShip   resultOfCards) + (self sumOfAccelerations).
	^dieResult .
]

{ #category : #action }
GameBoard >> specialCell: aNumberOfCell [ 
	| targetCell |
	targetCell:= aCollectionOfSpecialCells detect: [ :each | each numberOfSpecialCell  = aNumberOfCell].
	^targetCell.
]

{ #category : #validation }
GameBoard >> specialEffectAtCell: aNumberOfCell [

	| typeOfCell |
	typeOfCell := 0.
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
	turn := numberOfShip .
	self winner = 0
	ifTrue: [ self move: (collectionOfShipPositions at: numberOfShip) ]
	ifFalse: [ Error signal: 'The game is finished, we already have a winner' ]
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

{ #category : #validation }
GameBoard >> winner [

	| counter shipLap|
	counter := 1.
	shipLap:=((collectionOfShipPositions  at: counter)shipPosition ) isAtLap. 
	[ (counter >= collectionOfShipPositions  size or:
			 (shipLap >= (laps + 1))) ] 
		whileFalse: [ counter := counter + 1 ].

	(counter <= collectionOfShipPositions  size and:
		 (shipLap >= (laps + 1)))
		ifTrue: [ 
		^ (collectionOfShipPositions  at: counter) numberOfShip ]
		ifFalse: [ ^ 0 ]
]
