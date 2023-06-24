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
	|counter collectionCards|
	counter:= 1.
	[counter <= aGameBoard amountOfPlayers]whileTrue: [ 
			collectionCards:= ((aGameBoard player: counter)shipCards ) cardsForMe.
			self removeFrom: collectionCards. 
			counter:=counter+1.
	 ].
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

{ #category : #action }
Cancellation >> permanent [
	^false.
]

{ #category : #validation }
Cancellation >> permanent: aShipsGame verify: aNumberOfShip [ 
	(aShipsGame verify: self IsInHand: aNumberOfShip) ifTrue: [ 
			aShipsGame chosenCard: self.
			aShipsGame cardDirectedTo: aNumberOfShip.
			 ].
]

{ #category : #action }
Cancellation >> removeAcceleration: aGameBoard [ 
	|collectionOfAccelerations|
	collectionOfAccelerations := aGameBoard accelerations.
	collectionOfAccelerations remove: cardToRemove .
]

{ #category : #action }
Cancellation >> removeFrom: collectionCards [ 
	|counter|
	counter :=1.
	[ counter <= collectionCards size ]whileTrue:[
		((collectionCards at: counter) =  cardToRemove ) ifTrue: [ 
			(collectionCards) remove: (collectionCards at: counter) .
			 ].
		counter:=counter +1.
	] 
]

{ #category : #instance }
Cancellation >> selected: aShipPosition [  
	chosenShip := aShipPosition.
]
