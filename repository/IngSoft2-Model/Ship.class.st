Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'aPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Ship class >> withPosition: aPosition [
	^(self new)initializeWith: aPosition.
]

{ #category : #initialization }
Ship >> initializeWith: aPositionInstance [
	aPosition:= aPositionInstance.
	 
]

{ #category : #validation }
Ship >> isValid [
	^true
]
