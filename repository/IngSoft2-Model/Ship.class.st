Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'aPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #modi }
Ship class >> incrementPosition: anInteger [ 
	self shouldBeImplemented.
]

{ #category : #initialization }
Ship class >> with: aPosition [ 
	^(self new) initializeWith: aPosition.
]

{ #category : #'instance creation' }
Ship class >> withPosition: aPosition [
	^(self new)initializeWith: aPosition.
]

{ #category : #validations }
Ship >> atPosition: anInteger [ 
	anInteger = aPosition ifTrue: [ ^true ]
	ifFalse: [ ^false ]
]

{ #category : #moves }
Ship >> incrementPosition: anIncrement [ 
	aPosition := aPosition+anIncrement.
]

{ #category : #initialization }
Ship >> initializeWith: aPositionInstance [
	aPosition:= aPositionInstance.
	 
]

{ #category : #validation }
Ship >> isValid [
	^true
]
