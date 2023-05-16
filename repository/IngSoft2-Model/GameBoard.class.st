Class {
	#name : #GameBoard,
	#superclass : #Object,
	#instVars : [
		'cells',
		'collectionOfPositions',
		'laps',
		'aCollectionOfSpecialCells',
		'parsecsByCell'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
GameBoard class >> validateCanExistWith: anAmountOfCells [ 
	anAmountOfCells > 1 ifFalse:  [ 
		 Error signal: 'Cannot create GameBoard with negative amount of cells'].
]

{ #category : #validating }
GameBoard class >> validateCanExistWith: numberOfCells and: numberOfLaps [
	|result|
	result := (numberOfCells > 1 )&(numberOfLaps >= 1 ).
	 result  ifFalse: [ 
		Error signal:
			'Cannot create GameBoard with negative amount of cells or laps' ]
]

{ #category : #initialization }
GameBoard class >> with: numberOfCells [ 
	self validateCanExistWith: numberOfCells.
	^(self new) initializeWith: numberOfCells 
]

{ #category : #creation }
GameBoard class >> with: numberOfCells and: numberOfLaps [ 
	self validateCanExistWith: numberOfCells and: numberOfLaps.
	^(self new) initializeWith: numberOfCells and: numberOfLaps.
	
	
	 
]

{ #category : #adding }
GameBoard >> add: aSpeedUp at: aNumberOfCell [ 
	aCollectionOfSpecialCells add: (Cell with: aSpeedUp and: aNumberOfCell).
]

{ #category : #action }
GameBoard >> addEffects: aCollectionOfProbabilities [
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
			self add: (HyperJump  with: (#(7 3 2 1))) at: index. 
		 ].
	(randomNumber >= (probabilities  at: 5) and: randomNumber < (probabilities at: 6)) ifTrue: [ 
			self add: (AtomicBomb  new) at: index. 
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
GameBoard >> cellsWith: anAmountOfParsecs [
	parsecsByCell := anAmountOfParsecs .
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

{ #category : #creating }
GameBoard >> fillWith: players [
	players do:[:each | collectionOfPositions add: (Position with: each )].
	
]

{ #category : #initialization }
GameBoard >> initializeWith: numberOfCells [ 
	cells := numberOfCells .
	collectionOfPositions := OrderedCollection new.
]

{ #category : #initialization }
GameBoard >> initializeWith: numberOfCells and: numberOfLaps [ 
	cells := numberOfCells .
	laps := numberOfLaps.
	aCollectionOfSpecialCells := OrderedCollection new.
	collectionOfPositions := OrderedCollection new.
]

{ #category : #validation }
GameBoard >> laps [
	^ laps
]

{ #category : #moves }
GameBoard >> move: aPlayer adding: diceResult [

	| index positionOfShip result specialEffect auxResult|
	index := 1.
	
	[ (collectionOfPositions at: index) isTheSameAs: aPlayer ] whileFalse: [ index := index + 1 ].
	
	positionOfShip := (collectionOfPositions at: index) isAtPosition.
	result := positionOfShip + diceResult. 
	auxResult:= self updateResult: result.
	

	specialEffect:= (self specialEffectAtCell: auxResult ).
	(specialEffect == 0) ifFalse: [ 
		specialEffect destinatary == 0 ifTrue:[
			(collectionOfPositions at: index) changePosition: result  .
			specialEffect activatedBy: (collectionOfPositions at: index) with: result .
			
			self verifyAllPositions]
        ifFalse:[ 
            specialEffect applyEffect: collectionOfPositions activatedBy: (collectionOfPositions at: index).
				(specialEffect isKindOf: AtomicBomb) ifTrue: [ result := 0 ].
				(collectionOfPositions at: index) changePosition: result  .
				self verifyAllPositions.
            ].
		]
	 ifTrue:[ 
	
				(collectionOfPositions at: index) changePosition: result  .
				self verifyAllPositions.
				].
]

{ #category : #validation }
GameBoard >> numberOfParsecs: aShip [ 
	| anotherShip |
	anotherShip := self positionAtCollectionOf: aShip.
	^ anotherShip isAtParsec
]

{ #category : #action }
GameBoard >> playRoundWith: aCollectionOfDices [

	| index result |
	index := 1.
	result := 0.
	[ index <= collectionOfPositions size and: self winner = 0 ] 
		whileTrue: [ 
			result := self throwVariousDices: aCollectionOfDices.
			self
				move: (collectionOfPositions at: index) shipInPosition
				adding: result.
			index := index + 1.
			result := 0 ]
]

{ #category : #validation }
GameBoard >> playerPosition: aDice [
	^aDice
	
	"Este mensaje quedó de los primeros tests antes de descubrir Position"
]

{ #category : #validation }
GameBoard >> positionAtCollectionOf: aShip [

	| anotherShip counter |
	counter := 1.
	anotherShip := collectionOfPositions at: counter.
	[ anotherShip isTheSameAs: aShip ] whileFalse: [ 
		counter := counter + 1.
		anotherShip := collectionOfPositions at: counter ].
	^ anotherShip
]

{ #category : #validation }
GameBoard >> ranking [
	| array sortedArray |
	array := collectionOfPositions.
	sortedArray := array sorted: [:player1 :player2 | player1 isAtLap    < player2  isAtLap  ].
	sortedArray := sortedArray sorted: [:player1 :player2 | player1 isAtPosition  < player2  isAtPosition ].
	sortedArray :=sortedArray sorted: [:player1 :player2 | player1 isAtParsec   < player2 isAtParsec ].
	^sortedArray 
	 
]

{ #category : #positioning }
GameBoard >> shipAt: index [ 
	^ (collectionOfPositions at: index ) shipInPosition
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

{ #category : #interactions }
GameBoard >> turnOf: numberOfShip with: aCollectionOfDices [

	| result |
	result := 0.
	result := self throwVariousDices: aCollectionOfDices.
	self
		move: (collectionOfPositions at: numberOfShip) shipInPosition
		adding: result
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

{ #category : #validations }
GameBoard >> verifyAllPositions [
	|index player playerPosition playerParsec|
	index := 1.
	[ index <= collectionOfPositions size ] whileTrue: [ 
		player:= collectionOfPositions at: index.
		playerParsec:=player isAtParsec.
		playerPosition:= player isAtPosition.
		[ playerParsec > parsecsByCell  ] whileTrue:[
			player changeParsecs: (playerParsec - parsecsByCell).
			player changePosition: playerPosition + 1.
			playerParsec := playerParsec - parsecsByCell.
		].
		playerPosition:= player isAtPosition.
		[playerPosition<0] whileTrue: [ 
			player changePosition: cells + playerPosition.
			player decreaseLap.
			playerPosition := cells + playerPosition .
			 ].
		[playerPosition >cells] whileTrue: [ 
			player changePosition: playerPosition - cells .
			player increaseLap.
			playerPosition := playerPosition - cells .
			 ].
		
				
		index := index + 1.
	 ]
	
]

{ #category : #validation }
GameBoard >> winner [

	| counter shipLap|
	counter := 1.
	shipLap:=(collectionOfPositions at: counter) isAtLap. 
	[ (counter >= collectionOfPositions size or:
			 (shipLap >= (laps + 1))) ] 
		whileFalse: [ counter := counter + 1 ].

	(counter <= collectionOfPositions size and:
		 (shipLap >= (laps + 1)))
		ifTrue: [ 
		^ (collectionOfPositions at: counter) shipInPosition numberOfShip ]
		ifFalse: [ ^ 0 ]
]
