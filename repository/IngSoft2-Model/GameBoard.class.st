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

{ #category : #validation }
GameBoard >> amountOfCells [
	^cells 
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

{ #category : #initialization }
GameBoard >> initializeWith: numberOfCells and: numberOfLaps andAlso: numberOfParsecs [
	cells := numberOfCells .
	laps := numberOfLaps.
	parsecsByCell := numberOfParsecs .
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
	result := positionOfShip + diceResult. "12"
	auxResult:= self updateResult: result.
	

	specialEffect:= (self specialEffectAtCell: auxResult ).
	(specialEffect == 0) ifFalse: [ "Si hay special effect"
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
	 ifTrue:[ "si no hay efecto"
	
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
