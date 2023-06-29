Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'numberOfShip',
		'aShipPosition',
		'aShipCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Ship class >> with: aNumberOfShip [ 
	^(self new) initializeWith: aNumberOfShip.
]

{ #category : #adding }
Ship >> add: aCard [ 
	aShipCards add: aCard.
]

{ #category : #action }
Ship >> changePosition: aNewShipPosition [  
	aShipPosition := aNewShipPosition.
]

{ #category : #initialization }
Ship >> initializeWith: aNumberOfShip [ 
	numberOfShip:= aNumberOfShip.
	aShipPosition:= ShipPosition createNew.
	aShipCards := ShipCards createNew.
]

{ #category : #validation }
Ship >> isTheSameAs: aShip [ 
	^ aShip numberOfShip = numberOfShip.
]

{ #category : #validation }
Ship >> numberOfShip [
	^ numberOfShip
]

{ #category : #action }
Ship >> resultOfCards [
	^(aShipCards resultOfCards).
]

{ #category : #validation }
Ship >> shipCards [
	^aShipCards.
]

{ #category : #action }
Ship >> shipPosition [
	^aShipPosition.
]
