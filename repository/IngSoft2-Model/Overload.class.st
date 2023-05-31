Class {
	#name : #Overload,
	#superclass : #Object,
	#instVars : [
		'numberOfPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Overload class >> applyCardTo: aNumberOfPlayer [ 
	^(self new) intializeWith: aNumberOfPlayer.
]

{ #category : #action }
Overload >> amountToChange [
	^-2.
]

{ #category : #initialization }
Overload >> applyCardTo: aNumberOfPlayer [
	numberOfPlayer := aNumberOfPlayer. 
]

{ #category : #intialization }
Overload >> intializeWith: aNumberOfPlayer [ 
	 numberOfPlayer := aNumberOfPlayer.
]
