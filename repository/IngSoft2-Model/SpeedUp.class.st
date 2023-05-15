Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedUp >> activatedBy: aPlayer with: aNewPosition [ 
	aPlayer changePosition: (aPlayer isAtPosition +4)
]

{ #category : #validation }
SpeedUp >> destinatary [
	^0.
]
