Class {
	#name : #Cell,
	#superclass : #Object,
	#instVars : [
		'effect',
		'numberCell'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Cell class >> with: aSpeedUp and: aNumberOfCell [ 
	^(self new)initializeWith: aSpeedUp and: aNumberOfCell.
]

{ #category : #initialization }
Cell >> initializeWith: aSpeedUp and: aNumberOfCell [ 
	effect := aSpeedUp.
	numberCell := aNumberOfCell. 
	 
]

{ #category : #validation }
Cell >> numberOfSpecialCell [
	^numberCell .
]

{ #category : #validation }
Cell >> typeOfSpecialEffect [
	^effect .
]
