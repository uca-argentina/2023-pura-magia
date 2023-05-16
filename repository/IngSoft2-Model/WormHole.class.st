Class {
	#name : #WormHole,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
WormHole >> activatedBy: aPlayer with: aNewPosition [ 
	aPlayer changePosition: (aPlayer isAtPosition -4)
]

{ #category : #validation }
WormHole >> destinatary [
	^0.
]
