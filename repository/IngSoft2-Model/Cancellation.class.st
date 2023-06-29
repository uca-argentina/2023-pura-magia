Class {
	#name : #Cancellation,
	#superclass : #Object,
	#instVars : [
		'cardToRemove',
		'chosenShip',
		'shipsGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Cancellation class >> with: aShipsGame [ 
	^(self new) initializeWith: aShipsGame .
]

{ #category : #action }
Cancellation >> apply: aGameBoard [ 
	self applyForAccelerationTo: aGameBoard .
	self applyForOtherCardsTo: aGameBoard .
	
	^(self)
	
]

{ #category : #action }
Cancellation >> applyForAccelerationTo: aGameBoard [ 
	(aGameBoard accelerations includes: cardToRemove) ifTrue: [
		self removeAcceleration: aGameBoard.
		 ].
]

{ #category : #action }
Cancellation >> applyForOtherCardsTo: aGameBoard [

	| collectionCards |
	1 to: aGameBoard amountOfPlayers do: [ :counter | 
		collectionCards := (aGameBoard player: counter) shipCards cardsForMe.
		self removeFrom: collectionCards ]
]

{ #category : #initialization }
Cancellation >> canceled: aCardToRemove [
	cardToRemove:= aCardToRemove.
]

{ #category : #action }
Cancellation >> from: aNumberOfShip applyTo: aChosenNumberOfShip canceled: aCard [ 
	shipsGame  chosen: self from: aNumberOfShip.
	self  canceled: aCard .
	shipsGame cardDirectedTo: aChosenNumberOfShip.
	shipsGame applyChosenCard.
]

{ #category : #action }
Cancellation >> from: aNumberOfShip canceled: aCard [ 

	shipsGame  chosen: self from: aNumberOfShip.
	self canceled: aCard .
	shipsGame  applyChosenCard.
]

{ #category : #initialization }
Cancellation >> initializeWith: aShipsGame [ 
	shipsGame := aShipsGame .
]

{ #category : #validation }
Cancellation >> permanent: aShipsGame verify: aNumberOfShip [

	(aShipsGame verify: self IsInHand: aNumberOfShip) ifFalse: [ ^ self ].
	aShipsGame chosenCard: self.
	aShipsGame cardDirectedTo: aNumberOfShip
]

{ #category : #action }
Cancellation >> removeAcceleration: aGameBoard [ 
	|collectionOfAccelerations|
	collectionOfAccelerations := aGameBoard accelerations.
	collectionOfAccelerations remove: cardToRemove .
]

{ #category : #action }
Cancellation >> removeFrom: collectionCards [

	(collectionCards includes: cardToRemove) ifTrue: [ 
		collectionCards remove: cardToRemove ]
	
]

{ #category : #instance }
Cancellation >> selected: aShipPosition [  
	chosenShip := aShipPosition.
]
