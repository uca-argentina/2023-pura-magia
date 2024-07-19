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
Cell class >> with: aSpecialEffect and: aNumberOfCell [ 
	^(self new)initializeWith: aSpecialEffect and: aNumberOfCell.
]

{ #category : #action }
Cell >> changeEffect: specialEffectNewState [
	effect := specialEffectNewState.
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
Cell >> reverse: aStateToChange [

	effect stateReverse == aStateToChange ifTrue: [ ^ self ].
	effect changeState: aStateToChange.
	self changeEffect: effect.
]

{ #category : #validation }
Cell >> typeOfSpecialEffect [
	^effect .
]
