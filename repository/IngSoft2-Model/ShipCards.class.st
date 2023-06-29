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

	aCollectionOfCards do: [ :each | 
		(each isKindOf: Redo) ifTrue: [ 
			each redo: lastUsedCard ] ]
]

{ #category : #initialization }
ShipCards >> initializeNew [
	aCollectionOfCards := OrderedCollection new.
	aCollectionOfCardsForMe := OrderedCollection new.
]

{ #category : #action }
ShipCards >> resultOfCards [

	| result |
	result := 0.
	aCollectionOfCardsForMe do: [ :each | 
		result := result + each amountToChange ].

	^ result
]

{ #category : #action }
ShipCards >> store: aCardChosenForMe [ 
	aCollectionOfCardsForMe add: aCardChosenForMe.
]
