Class {
	#name : #HyperJump,
	#superclass : #Object,
	#instVars : [
		'anAmountOfParsecsToMove',
		'round'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
HyperJump class >> validateCanExistWith: aCollectionOfProbabilities [

	| isOrdered previous result |
	isOrdered := aCollectionOfProbabilities allSatisfy: [ :eachArray | 
		             previous := eachArray first.
		             eachArray allSatisfy: [ :value | 
			             result := ((value) parsecs)nominalValue  <= ((previous)parsecs)nominalValue.
			             previous := value.
			             result ] ].

	isOrdered ifFalse: [ 
		Error signal:
			'Cannot create HyperJump with a collection out of order' ]
]

{ #category : #initialization }
HyperJump class >> with: arrayOfPosibilities [
	|randomNumber|
	self validateCanExistWith: arrayOfPosibilities.
	randomNumber := (arrayOfPosibilities size)atRandom.
	^(self new)initializeWith: (arrayOfPosibilities at: randomNumber )
]

{ #category : #action }
HyperJump >> applyTo: aGameBoard [ 
	|parsecs turn aShip newPosition|
	round := round +1.
	turn:= aGameBoard turn.
	aShip:=aGameBoard player: turn.
	(round > anAmountOfParsecsToMove  size) ifTrue: [ 
		round :=1 ].
	parsecs := ((anAmountOfParsecsToMove  at: round) parsecs)nominalValue.
	newPosition := aGameBoard  createWithNew: parsecs with: aShip shipPosition  .
	(aShip) changePosition:  newPosition.
]

{ #category : #initialization }
HyperJump >> initializeWith: amountOfParsecsToMove [ 
	anAmountOfParsecsToMove:=amountOfParsecsToMove  .
	round:= 0.
]

{ #category : #action }
HyperJump >> repeatFor: aChosenShip using: aGameBoard [ 
	|result parsecs newPosition|
	round := round +1.
		(round > anAmountOfParsecsToMove  size) ifTrue: [ 
		round :=1 ].
	parsecs := ((anAmountOfParsecsToMove  at: round) parsecs)nominalValue.
	newPosition := aGameBoard  createWithNew: parsecs with: (aChosenShip shipPosition)  .
	(aChosenShip) changePosition:  newPosition.
]
