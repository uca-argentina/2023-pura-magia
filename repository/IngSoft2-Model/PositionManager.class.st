Class {
	#name : #PositionManager,
	#superclass : #Object,
	#instVars : [
		'cells',
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
PositionManager class >> with: amountOfCells and: amountOfParsecs [ 
	^(self new) initializeWith: amountOfCells and: amountOfParsecs.
]

{ #category : #action }
PositionManager >> change: aShipPosition changingLap: aResult [ 
|result position newLap parsec newShipPosition|
	result := aResult .
		[ result   > cells ] whileTrue: [ 
		position:=result-cells.
		newLap:= ((aShipPosition isAtLap )+1) .
		parsec := aShipPosition isAtParsec.
		newShipPosition := ShipPosition createWith: position at: newLap and: parsec .
		result := result - cells ].
	^newShipPosition .
]

{ #category : #action }
PositionManager >> change: aShipPosition withMoreParsecsThanMax: aResult [
	|result position newShipPosition newLap parsecsVar|
	result:= aResult .
	[ result   > parsecs  ] whileTrue: [ 
		position:=aShipPosition isAtPosition  +1.
		newShipPosition := self manageCellsOf: aShipPosition  at: position.
		position := newShipPosition isAtPosition .
		newLap := newShipPosition isAtLap .
		parsecsVar := Parsecs with: (result-parsecs) .
		newShipPosition := ShipPosition createWith: position at: newLap and: parsecsVar  .
		result := result - parsecs ].
	^newShipPosition .
]

{ #category : #'as yet unclassified' }
PositionManager >> change: aShipPosition withNegative: aResult [ 
	|newShipPosition result position newLap parsec|
	result := aResult .
	[ result   < 0 ] whileTrue: [ 
		(aShipPosition isAtLap  = 1) ifTrue: [ 
				newShipPosition := ShipPosition createNew.
				result :=0 .
			] ifFalse: [  
				position:=cells + result.
				newLap:= ((aShipPosition isAtLap )-1) .
				parsec := aShipPosition isAtParsec .
				newShipPosition := ShipPosition createWith: position at: newLap and: parsec .
				result := cells + result ] ].
		
		^newShipPosition 
]

{ #category : #'as yet unclassified' }
PositionManager >> change: aShipPosition withNegativeParsecs: aResult [ 
	|newShipPosition  result  position newLap parsecsVar |
	result := aResult .
	position := aShipPosition isAtPosition.
	[ result   < 0 ] whileTrue: [ 
		position:= position -1.
		newShipPosition := self manageCellsOf: aShipPosition  at: position.
		position := newShipPosition isAtPosition .
		newLap := newShipPosition isAtLap  .
		parsecsVar := Parsecs with: (result+parsecs) .
		newShipPosition := ShipPosition createWith: position at: newLap and: parsecsVar .
		result :=result + parsecs . 
		  ].
	^newShipPosition 

]

{ #category : #initialization }
PositionManager >> initializeWith: anAmountOfCells and: anAmountOfParsecs [
	cells := anAmountOfCells .
	parsecs := anAmountOfParsecs .
]

{ #category : #action }
PositionManager >> manageCellsOf: aShipPosition at: newCell [
	|newShipPosition  result playerPosition  newLap parsec|
	playerPosition := aShipPosition isAtPosition .
	result := newCell. 
	(result   <= cells) ifTrue: [ 
		newLap:=aShipPosition isAtLap .
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
PositionManager >> manageParsecsOf: aShipPosition at: aNewParsec [
|newShipPosition  result  position newLap |
	result := aNewParsec + (aShipPosition isAtParsec  )nominalValue . 
	(result   <= parsecs ) ifTrue: [ 
		newLap:=aShipPosition isAtLap .
		position := aShipPosition isAtPosition . 
		newShipPosition := ShipPosition createWith: position   at: newLap and: (Parsecs with: aNewParsec)   .] .
	(result <0)ifTrue:[
		newShipPosition := self change: aShipPosition  withNegativeParsecs: result  .
		].
	(result   > parsecs) ifTrue:[
		newShipPosition := self change: aShipPosition  withMoreParsecsThanMax: result  .
		].
	
	^ newShipPosition 
]
