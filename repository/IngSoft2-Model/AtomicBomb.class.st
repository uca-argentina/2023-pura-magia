Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBomb >> applyEffect: aCollectionOfPlayers activatedBy: aPlayer [ 
	|index|
	index := 1.	
	[ index < aCollectionOfPlayers size ] whileTrue: [ 
		(aCollectionOfPlayers at: index ) changePosition: 0.
		index:= index + 1.
	 ]
]

{ #category : #validation }
AtomicBomb >> destinatary [
	^1
]
