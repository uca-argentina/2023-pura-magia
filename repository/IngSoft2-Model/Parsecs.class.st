Class {
	#name : #Parsecs,
	#superclass : #Object,
	#instVars : [
		'nominalValue'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Parsecs class >> with: aNominalValue [ 
	^(self new) initializeWith: aNominalValue .
]

{ #category : #initialization }
Parsecs >> initializeWith: aNominalValue [ 
	nominalValue := aNominalValue.
]

{ #category : #value }
Parsecs >> nominalValue [
	^ nominalValue
]

{ #category : #calculating }
Parsecs >> parsecs [
	^self.
]

{ #category : #action }
Parsecs >> plus: aMeasureUnit [

	^ self class with: nominalValue + aMeasureUnit parsecs nominalValue
]
