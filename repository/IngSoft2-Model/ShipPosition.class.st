Class {
	#name : #ShipPosition,
	#superclass : #Object,
	#instVars : [
		'cellNumber',
		'actualLap',
		'parsecs',
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
ShipPosition class >> createWith: aNumberOfCell at: aNumberOfLap and: aParsec [
	 ^(self new) initializeWith: aNumberOfCell and: aNumberOfLap and: aParsec. 
]

{ #category : #initialization }
ShipPosition >> initializeNew [
	cellNumber := 0 .
	actualLap :=1.
	parsecs := Parsecs with:0.
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
