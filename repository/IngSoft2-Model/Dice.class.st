Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Dice class >> with: aFace [
	^(self new) initializeWith: aFace.
]

{ #category : #initialization }
Dice >> initializeWith: aFace [
	faces := aFace.
]

{ #category : #action }
Dice >> throw [
	^faces  atRandom.
]
