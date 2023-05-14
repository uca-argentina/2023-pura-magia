Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
Dice class >> validateCanExistWith: anAmount [ 
	anAmount > 2 ifFalse:  [ 
		Error signal:  'Cannot create die with negative amount of faces']
]

{ #category : #initialization }
Dice class >> with: aFace [
	 self validateCanExistWith: aFace.
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
