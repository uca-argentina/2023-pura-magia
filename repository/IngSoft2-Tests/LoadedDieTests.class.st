Class {
	#name : #LoadedDieTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
LoadedDieTests >> test01ChargeDice [
	|aLoadedDice|
	aLoadedDice := LoadedDie new.
	self assert: (aLoadedDice isKindOf: LoadedDie).
	
]

{ #category : #tests }
LoadedDieTests >> test02ChargeDiceWithCollection [
	|aLoadedDice numbers|
	
	numbers := #(1 2 3 4)  .
	aLoadedDice := LoadedDie with: numbers .

	self assert: (aLoadedDice throw) equals: 1.
	
]
