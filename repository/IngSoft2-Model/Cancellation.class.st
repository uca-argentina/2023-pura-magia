Class {
	#name : #Cancellation,
	#superclass : #Object,
	#instVars : [
		'cardToRemove',
		'chosenShip'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Cancellation >> apply: aGameBoard [ 
	|collectionCards counter|
	counter :=1.
	
	[counter <= aGameBoard amountOfPlayers]whileTrue: [ 
			collectionCards:= (aGameBoard player: counter) cardsForMe.
			self removeFrom: collectionCards. 
			counter:=counter+1.
	
	 ] 
	
	
]

{ #category : #initialization }
Cancellation >> canceled: aCardToRemove [
	cardToRemove:= aCardToRemove.
]

{ #category : #action }
Cancellation >> permanent [
	^false.
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
