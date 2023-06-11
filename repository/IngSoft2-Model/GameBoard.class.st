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
		'lastEffectUsed'
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
GameBoard >> add: aCard to: numberOfPlayer [ 
	| aShipPosition |
	aShipPosition :=(self player: numberOfPlayer). 
	aShipPosition add: aCard.
	
	
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
	^ anotherShip isAtLap.
]

{ #category : #validation }
GameBoard >> checkPositionOf: aShip [

	| anotherShip |
	anotherShip := self positionAtCollectionOf: aShip.
	^ anotherShip isAtPosition
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
GameBoard >> move: aPlayer [ 
	| index positionOfShip result specialEffect auxResult dieResult |

	dieResult  := 0.
	dieResult  := self throwVariousDices: dieCollection .
	dieResult := dieResult + (aPlayer resultOfCards).
	
	index := 1.
	[ (collectionOfShipPositions  at: index) isTheSameAs: aPlayer ] 
		whileFalse: [ index := index + 1 ].
	positionOfShip := (collectionOfShipPositions  at: index) isAtPosition.
	result := positionOfShip + dieResult .
	auxResult := self updateResult: result.
	specialEffect := self specialEffectAtCell: auxResult.
	(specialEffect == 0)
		ifFalse: [ 
					(collectionOfShipPositions  at: index) changePosition: result.
					specialEffect applyTo: self.
					self verifyAllPositions.
					lastEffectUsed := specialEffect.
					 ]
		ifTrue: [ 
			(collectionOfShipPositions  at: index) changePosition: result.
			self verifyAllPositions ]
]

{ #category : #validation }
GameBoard >> numberOfParsecs: aShip [ 
	| anotherShip |
	anotherShip := self positionAtCollectionOf: aShip.
	^ anotherShip isAtParsec
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
	sortedArray := array sorted: [:player1 :player2 | player1 isAtLap    < player2  isAtLap  ].
	sortedArray := sortedArray sorted: [:player1 :player2 | player1 isAtPosition  < player2  isAtPosition ].
	sortedArray :=sortedArray sorted: [:player1 :player2 | (player1 isAtParsec)nominalValue < (player2 isAtParsec)nominalValue  ].
	^sortedArray 
	 
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

{ #category : #validation }
GameBoard >> verifyAllPositions [

	| index player playerPosition playerParsec |
	index := 1.
	[ index <= collectionOfShipPositions  size ] whileTrue: [ 
		player := collectionOfShipPositions  at: index.
		playerPosition := player isAtPosition.
		playerParsec := self verifyParsecOf: player at: playerPosition.
		playerPosition := self verifyCellsOf: player.
		index := index + 1 ]
]

{ #category : #validation }
GameBoard >> verifyCellsOf: player [

	| playerPosition |
	playerPosition := player isAtPosition.
	[ playerPosition < 0 ] whileTrue: [ 
		(player isAtLap = 1) ifTrue: [ 
				player changePosition: 0.
				playerPosition := 0.
			] ifFalse: [  
				player changePosition: cells + playerPosition.
				player decreaseLap. 
				playerPosition := cells + playerPosition ] ].
	[ playerPosition > cells ] whileTrue: [ 
		player changePosition: playerPosition - cells.
		player increaseLap.
		playerPosition := playerPosition - cells ].
	^ playerPosition
]

{ #category : #validation }
GameBoard >> verifyParsecOf: player at: playerPosition [

	| playerParsec |
	playerParsec := (player isAtParsec)nominalValue.
	[ playerParsec > parsecsByCell ] whileTrue: [ 
		player changeParsecs:  ((-1)*(parsecsByCell)).
		player changePosition: playerPosition + 1.
		playerParsec := playerParsec - parsecsByCell ].
	[ playerParsec < 0 ] whileTrue: [ 
		player changeParsecs: parsecsByCell.
		player changePosition: playerPosition - 1.
		playerParsec := playerParsec + parsecsByCell ].
	^ playerParsec
]

{ #category : #validation }
GameBoard >> winner [

	| counter shipLap|
	counter := 1.
	shipLap:=(collectionOfShipPositions  at: counter) isAtLap. 
	[ (counter >= collectionOfShipPositions  size or:
			 (shipLap >= (laps + 1))) ] 
		whileFalse: [ counter := counter + 1 ].

	(counter <= collectionOfShipPositions  size and:
		 (shipLap >= (laps + 1)))
		ifTrue: [ 
		^ (collectionOfShipPositions  at: counter) numberOfShip ]
		ifFalse: [ ^ 0 ]
]
