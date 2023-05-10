Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'number'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Ship class >> number: aNumber [ 
	^(self new) initializeWith: aNumber.
]

{ #category : #initialization }
Ship >> initializeWith: aNumber [ 
	number := aNumber .
]

{ #category : #validation }
Ship >> numberOfShip [
	^ number.
]
