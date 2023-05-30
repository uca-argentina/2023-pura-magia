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

{ #category : #intialization }
Overload >> intializeWith: aNumberOfPlayer [ 
	 numberOfPlayer := aNumberOfPlayer.
]
