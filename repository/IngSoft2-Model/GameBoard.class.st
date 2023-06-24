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
		'aCollectionOfAccelerations'
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
	|index randomNumber probabilities|
	index:= 0.
	
	probabilities := self createCollectionFrom: aCollectionOfProbabilities .
		
	[ index <= cells ] whileTrue: [
		randomNumber:= 100 atRandom.
		
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
		 ].
	
		index := index + 1.
		
	 ]

]

{ #category : #counting }
GameBoard >> amountOfAtomicBombs [
	|index count|
	index := 1.
	count := 0.
	[ index <= aCollectionOfSpecialCells size  ] whileTrue: [ 
		(((aCollectionOfSpecialCells at: index) typeOfSpecialEffect) isKindOf: AtomicBomb ) ifTrue: [ 
			count := count + 1.
			 ].
		index:= index + 1.
	 ].

^ count .
]

{ #category : #validation }
GameBoard >> amountOfCells [
	^cells 
]

{ #category : #counting }
GameBoard >> amountOfHyperJumps [
	|index count|
	index := 1.
	count := 0.
	[ index <= aCollectionOfSpecialCells size  ] whileTrue: [ 
		(((aCollectionOfSpecialCells at: index) typeOfSpecialEffect) isKindOf: HyperJump ) ifTrue: [ 
			count := count + 1.
			 ].
		index:= index + 1.
	 ].

^ count .
]

{ #category : #counting }
GameBoard >> amountOfMoonWalks [
	|index count|
	index := 1.
	count := 0.
	[ index <= aCollectionOfSpecialCells size  ] whileTrue: [ 
		(((aCollectionOfSpecialCells at: index) typeOfSpecialEffect) isKindOf: MoonWalk ) ifTrue: [ 
			count := count + 1.
			 ].
		index:= index + 1.
	 ].

^ count .
]

{ #category : #counter }
GameBoard >> amountOfNormalCells [
	^ cells - (aCollectionOfSpecialCells size) 
]

{ #category : #action }
GameBoard >> amountOfPlayers [
	^ collectionOfShipPositions  size.
]

{ #category : #counting }
GameBoard >> amountOfSpecialCardsCells [
	|index count|
	index := 1.
	count := 0.
	[ index <= aCollectionOfSpecialCells size  ] whileTrue: [ 
		(((aCollectionOfSpecialCells at: index) typeOfSpecialEffect) isKindOf: CardAssignation) ifTrue: [ 
			count := count + 1.
			 ].
		index:= index + 1.
	 ].

^ count .
]

{ #category : #counting }
GameBoard >> amountOfSpeedUps [
	|index count|
	index := 1.
	count := 0.
	[ index <= aCollectionOfSpecialCells size  ] whileTrue: [ 
		(((aCollectionOfSpecialCells at: index) typeOfSpecialEffect) isKindOf: SpeedUp ) ifTrue: [ 
			count := count + 1.
			 ].
		index:= index + 1.
	 ].

^ count .
]

{ #category : #calculating }
GameBoard >> amountOfWormHoles [
	|index count|
	index := 1.
	count := 0.
	[ index <= aCollectionOfSpecialCells size  ] whileTrue: [ 
		(((aCollectionOfSpecialCells at: index) typeOfSpecialEffect) isKindOf: WormHole) ifTrue: [ 
			count := count + 1.
			 ].
		index:= index + 1.
	 ].

^ count .
]

{ #category : #initialization }
GameBoard >> cellsWith: anAmountOfParsecs and: aCollectionOfDice [
	parsecsByCell := anAmountOfParsecs .
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

{ #category : #action }
GameBoard >> createCollectionFrom: aCollection [ 
	|index newCollection|
	index:= 2.
	newCollection := OrderedCollection new .
	newCollection add: (aCollection at: 1).
	[ index <= aCollection size ] whileTrue: [ 
		newCollection add: ((newCollection at: index-1) + (aCollection at: index)).
		index := index + 1.
	 ].

^ newCollection .
	
]

{ #category : #action }
GameBoard >> createPositionIn: aResult with: aShipPosition [ 
	^(self verifyCellsOf: aShipPosition at: aResult).
]

{ #category : #creation }
GameBoard >> createWithNew: aResult with: aShipPosition [ 
	^(self verifyParsecsOf: aShipPosition at: aResult).
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

{ #category : #creating }
GameBoard >> fillWith: players [
	|counter|
	counter := 1.
	players do: [ :each | collectionOfShipPositions add: each ].
	[ counter <= (collectionOfShipPositions size) ] whileTrue:[
		self designateRandomCardTo: counter.
		self designateRandomCardTo: counter.
		counter := counter + 1.
		]
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
	| aNumberOfShip positionOfShip result specialEffect auxResult dieResult |

	dieResult := self resultOf: aShip .
	aNumberOfShip := aShip numberOfShip.
	
	positionOfShip := ((collectionOfShipPositions  at: aNumberOfShip)shipPosition) isAtPosition.
	result := positionOfShip + dieResult .
	auxResult := self updateResult: result.
	specialEffect := self specialEffectAtCell: auxResult.
	(specialEffect == 0)
		ifFalse: [ 
					self move:(collectionOfShipPositions at: aNumberOfShip) using: specialEffect and: result  .
					 ]
		ifTrue: [
			self move: (collectionOfShipPositions at: aNumberOfShip) using: result .
			 ]
]

{ #category : #action }
GameBoard >> move: aShip using: result [ 
	|newPosition|
	newPosition := (self createPositionIn: result with:(aShip shipPosition)).
	aShip changePosition: newPosition.
]

{ #category : #action }
GameBoard >> move: aShip using: specialEffect and: result [ 
	|newPosition|
	newPosition := (self createPositionIn: result with:(aShip shipPosition)).
	aShip changePosition: newPosition.
	specialEffect applyTo: self.
	lastEffectUsed := specialEffect.
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
	dieResult := dieResult + (aShip   resultOfCards) + self sumOfAccelerations.
	^dieResult .
]

{ #category : #validation }
GameBoard >> specialEffectAtCell: aNumberOfCell [ 
	|counter typeOfCell|
	counter :=1.
	typeOfCell := 0. 
	[counter <= aCollectionOfSpecialCells size] whileTrue: [ 
		(((aCollectionOfSpecialCells at: counter ) numberOfSpecialCell) = aNumberOfCell )ifTrue: [
			typeOfCell :=(aCollectionOfSpecialCells at: counter)typeOfSpecialEffect.
			counter := counter +1.
			]
		ifFalse: [
			counter := counter +1.
			
			].
		
		 ].
	
	^typeOfCell.
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

	| counter result |
	counter := 1.
	result := 0.
	[ counter <= aCollectionOfDices size ] whileTrue: [ 
		result := result + (aCollectionOfDices at: counter) throw.
		counter := counter + 1 ].
	^ result
]

{ #category : #action }
GameBoard >> turn [
	^ turn
]

{ #category : #action }
GameBoard >> turnOf: numberOfShip [
	turn := numberOfShip .
	self
		move: (collectionOfShipPositions  at: numberOfShip)
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
	|newShipPosition  result playerPosition position newLap parsec|
	playerPosition := aShipPosition isAtPosition .
	result := aResult. 
	(result   <= cells) ifTrue: [ 
		newLap:=aShipPosition isAtLap.
		parsec := aShipPosition isAtParsec .
		newShipPosition := ShipPosition createWith: result  at: newLap and: parsec .] .
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
	[ result   > cells ] whileTrue: [ 
		position:=result-cells.
		newLap:= ((aShipPosition isAtLap)+1) .
		parsec := aShipPosition isAtParsec .
		newShipPosition := ShipPosition createWith: position at: newLap and: parsec .
		result := result - cells ].
	
	^ newShipPosition 

]

{ #category : #action }
GameBoard >> verifyParsecsOf: aShipPosition at: aNewParsec [
	|newShipPosition  result  position newLap parsecs |
	result := aNewParsec + (aShipPosition isAtParsec )nominalValue . 
	(result   <= parsecsByCell ) ifTrue: [ 
		newLap:=aShipPosition isAtLap.
		position := aShipPosition isAtPosition . 
		newShipPosition := ShipPosition createWith: position   at: newLap and: (Parsecs with: aNewParsec)   .] .
	[ result   < 0 ] whileTrue: [ 
		position:=aShipPosition isAtPosition -1.
		newShipPosition := self verifyCellsOf: aShipPosition  at: position.
		position := newShipPosition isAtPosition .
		newLap := newShipPosition isAtLap .
		parsecs := Parsecs with: (result+parsecsByCell ) .
		newShipPosition := ShipPosition createWith: position at: newLap and: parsecs .
		result :=result +parsecsByCell . 
		  ].
		
	[ result   > parsecsByCell  ] whileTrue: [ 
		
		position:=aShipPosition isAtPosition +1.
		newShipPosition := self verifyCellsOf: aShipPosition  at: position.
		position := newShipPosition isAtPosition .
		newLap := newShipPosition isAtLap .
		parsecs := Parsecs with: (result-parsecsByCell) .
		newShipPosition := ShipPosition createWith: position at: newLap and: parsecs  .
		result := result - parsecsByCell ].
	
	^ newShipPosition 
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
