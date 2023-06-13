Class {
	#name : #ShipPosition,
	#superclass : #Object,
	#instVars : [
		'cellNumber',
		'actualLap',
		'parsecs',
		'shipNumber',
		'aCollectionOfCards',
		'aCollectionOfCardsForMe'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
ShipPosition class >> createNew [
	^(self new)initializeNew.
]

{ #category : #creation }
ShipPosition class >> createWith: aNumberOfCell at: aNumberOfLap [ 
	 ^(self new) initializeWith: aNumberOfCell and: aNumberOfLap. 
]

{ #category : #creation }
ShipPosition class >> createWith: aNumberOfCell at: aNumberOfLap and: aParsec [
	 ^(self new) initializeWith: aNumberOfCell and: aNumberOfLap and: aParsec. 
]

{ #category : #initialization }
ShipPosition class >> with: aNumberOfPlayer [
	^ (self new) initializeWith: aNumberOfPlayer .
]

{ #category : #action }
ShipPosition >> add: aCard [ 
	aCollectionOfCards add: aCard.
]

{ #category : #action }
ShipPosition >> cardsForMe [
	^aCollectionOfCardsForMe 
]

{ #category : #action }
ShipPosition >> changeParsecs: anAmountOfParsecs [ 
	parsecs := parsecs  plus: (Parsecs with: anAmountOfParsecs)   .
]

{ #category : #changes }
ShipPosition >> changePosition: anInteger [ 
	cellNumber := anInteger 
]

{ #category : #action }
ShipPosition >> decreaseLap [
	actualLap := actualLap -1.
]

{ #category : #action }
ShipPosition >> fillRedoWith: lastUsedCard [ 
	|counter|
	counter := 1.
	
	[ counter <= aCollectionOfCards size ] whileTrue: [ 
		((aCollectionOfCards at: counter) isKindOf: Redo) ifTrue: [ 
				(aCollectionOfCards at: counter) redo: lastUsedCard .
			 ].
			counter := counter + 1.
	 ]
	
]

{ #category : #changes }
ShipPosition >> increaseLap [
	actualLap:=actualLap +1.
]

{ #category : #initialization }
ShipPosition >> initializeNew [
	cellNumber := 0 .
	actualLap :=1.
	parsecs := Parsecs with:0.
]

{ #category : #initialization }
ShipPosition >> initializeWith: aNumberOfCell and: aNumberOfLap [ 
	cellNumber := aNumberOfCell .
	actualLap := aNumberOfLap .
]

{ #category : #initialization }
ShipPosition >> initializeWith: aNumberOfCell and: aNumberOfLap and: aParsec [
	cellNumber := aNumberOfCell .
	actualLap := aNumberOfLap .
	parsecs := aParsec .
]

{ #category : #validation }
ShipPosition >> isAtLap [
	^actualLap.
]

{ #category : #validation }
ShipPosition >> isAtParsec [
	^parsecs .
]

{ #category : #validation }
ShipPosition >> isAtPosition [
	^ cellNumber 
]

{ #category : #validation }
ShipPosition >> numberOfShip [
	^ shipNumber .
]

{ #category : #action }
ShipPosition >> resultOfCards [
	|counter result|
	counter := 1.
	result :=0.
	[ counter <= aCollectionOfCardsForMe size  ] whileTrue: [ 
		result:= result+  (aCollectionOfCardsForMe at: counter) amountToChange.
		counter:= counter+1.
	 ].
	^result.
]

{ #category : #playing }
ShipPosition >> store: aCardChosenForMe [ 
	aCollectionOfCardsForMe add: aCardChosenForMe.
]
