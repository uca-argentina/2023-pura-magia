Class {
	#name : #ShipCards,
	#superclass : #Object,
	#instVars : [
		'aCollectionOfCards',
		'aCollectionOfCardsForMe'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ShipCards class >> createNew [
	^(self new) initializeNew.
]

{ #category : #adding }
ShipCards >> add: aCard [ 
	aCollectionOfCards add: aCard.
]

{ #category : #action }
ShipCards >> cardsForMe [
	^aCollectionOfCardsForMe.
]

{ #category : #action }
ShipCards >> cardsInHand [
	^aCollectionOfCards
]

{ #category : #action }
ShipCards >> fillRedoWith: lastUsedCard [ 
	|counter|
	counter := 1.
	
	[ counter <= aCollectionOfCards size ] whileTrue: [ 
		((aCollectionOfCards at: counter) isKindOf: Redo) ifTrue: [ 
				(aCollectionOfCards at: counter) redo: lastUsedCard .
			 ].
			counter := counter + 1.
	 ]
]

{ #category : #initialization }
ShipCards >> initializeNew [
	aCollectionOfCards := OrderedCollection new.
	aCollectionOfCardsForMe := OrderedCollection new.
]

{ #category : #action }
ShipCards >> resultOfCards [
	|counter result|
	counter := 1.
	result :=0.
	[ counter <= aCollectionOfCardsForMe size  ] whileTrue: [ 
		result:= result+  (aCollectionOfCardsForMe at: counter) amountToChange.
		counter:= counter+1.
	 ].
	^result.
]

{ #category : #action }
ShipCards >> store: aCardChosenForMe [ 
	aCollectionOfCardsForMe add: aCardChosenForMe.
]
