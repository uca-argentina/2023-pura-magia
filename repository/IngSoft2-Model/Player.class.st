Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'cellNumber',
		'actualLap',
		'parsecs',
		'shipNumber',
		'aCollectionOfCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Player class >> with: aNumberOfPlayer [
	^ (self new) initializeWith: aNumberOfPlayer .
]

{ #category : #action }
Player >> add: aCard [ 
	aCollectionOfCards add: aCard.
]

{ #category : #action }
Player >> cardsInHand [
	^aCollectionOfCards
]

{ #category : #action }
Player >> changeParsecs: anAmountOfParsecs [ 
	parsecs := anAmountOfParsecs.
]

{ #category : #changes }
Player >> changePosition: anInteger [ 
	cellNumber := anInteger 
]

{ #category : #action }
Player >> decreaseLap [
	actualLap := actualLap -1.
]

{ #category : #changes }
Player >> increaseLap [
	actualLap:=actualLap +1.
]

{ #category : #initialization }
Player >> initializeWith: aNumber [ 
	shipNumber  := aNumber .
	cellNumber := 0 .
	actualLap :=1.
	parsecs := 0.
	aCollectionOfCards := OrderedCollection new.
]

{ #category : #validation }
Player >> isAtLap [
	^actualLap.
]

{ #category : #validation }
Player >> isAtParsec [
	^parsecs.
]

{ #category : #validation }
Player >> isAtPosition [
	^ cellNumber 
]

{ #category : #'tests - validation' }
Player >> isTheSameAs: aShip [ 
	^ aShip numberOfShip = shipNumber  .
]

{ #category : #validation }
Player >> numberOfShip [
	^ shipNumber .
]
