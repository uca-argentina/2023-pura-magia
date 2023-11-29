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
HyperJump >> applyTo: aGameBoard for: aChosenShip [
	| parsecs newPosition|
	round := round +1.
		(round > anAmountOfParsecsToMove  size) ifTrue: [ 
		round :=1 ].
	parsecs := ((anAmountOfParsecsToMove  at: round) parsecs)nominalValue.
	newPosition := aGameBoard  withNew: parsecs and: (aChosenShip shipPosition)  .
	(aChosenShip) changePosition:  newPosition.
	^self.
]

{ #category : #initialization }
HyperJump >> initializeWith: amountOfParsecsToMove [ 
	anAmountOfParsecsToMove:=amountOfParsecsToMove  .
	round:= 0.
]
