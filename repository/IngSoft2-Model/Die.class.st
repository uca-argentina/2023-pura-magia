Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
Die class >> validateCanExistWith: anAmount [ 
	anAmount > 2 ifFalse:  [ 
		Error signal:  'Cannot create die with negative amount of faces']
]

{ #category : #initialization }
Die class >> with: aFace [
	 self validateCanExistWith: aFace.
	^(self new) initializeWith: aFace.
]

{ #category : #initialization }
Die >> initializeWith: aFace [
	faces := aFace.
]

{ #category : #action }
Die >> throw [
	^faces  atRandom.
]
