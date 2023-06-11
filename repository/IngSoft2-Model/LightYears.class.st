Class {
	#name : #LightYears,
	#superclass : #Object,
	#instVars : [
		'nominalValue'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
LightYears class >> with: aNominalValue [ 
	^(self new) initializeWith: aNominalValue .
]

{ #category : #initialization }
LightYears >> initializeWith: aNominalValue [ 
	nominalValue := aNominalValue .
]

{ #category : #calculating }
LightYears >> parsecs [
	^( Parsecs with: (nominalValue // 3))
]
