Class {
	#name : #Crupier,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #adding }
Crupier >> add: aCard to: numberOfPlayer using: aGameBoard [
		| aShip |
	aShip :=(aGameBoard player: numberOfPlayer). 
	aShip add: aCard.
]

{ #category : #assign }
Crupier >> designateRandomCardTo: numberOfShip using: aGameBoard [
	|probabilities randomNumber|
	probabilities := #(0 10 20 30 40 50 60) .
		
		randomNumber:= 60 atRandom.
		
		( randomNumber >= (probabilities  at: 1) and: randomNumber < (probabilities at: 2)) ifTrue: [
			self add: (Overload new) to: numberOfShip using: aGameBoard.
		 ].
	 (randomNumber >= (probabilities  at: 2) and: randomNumber < (probabilities at: 3)) ifTrue: [ 
			self add: (Speed new) to: numberOfShip using: aGameBoard.
		 ].
	 (randomNumber >= (probabilities  at: 3) and: randomNumber < (probabilities at: 4)) ifTrue: [ 
			self add: (Cancellation new) to: numberOfShip using: aGameBoard.
		 ].
	 (randomNumber >= (probabilities  at: 4) and: randomNumber < (probabilities at: 5)) ifTrue: [ 
			self add: (Redo new) to: numberOfShip using: aGameBoard.
		 ].
	(randomNumber >= (probabilities  at: 5) and: randomNumber < (probabilities at: 6)) ifTrue: [ 
			self add: (Acceleration new) to: numberOfShip using: aGameBoard. 
		 ].
	(randomNumber >= (probabilities  at: 6) and: randomNumber <= (probabilities at: 7)) ifTrue: [ 
			self add: (Repeat new) to: numberOfShip using: aGameBoard. 
		 ].
]

{ #category : #action }
Crupier >> fillWith: players using: aGameBoard [ 
	aGameBoard fill: players.

	1 to: aGameBoard collectionOfShipPositions size do: [ :counter | 
		self designateRandomCardTo: counter using: aGameBoard.
		self designateRandomCardTo: counter using: aGameBoard ]
]
