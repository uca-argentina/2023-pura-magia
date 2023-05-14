Class {
	#name : #LoadedDiceTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
LoadedDiceTests >> test01ChargeDice [
	|aLoadedDice|
	aLoadedDice := LoadedDice new.
	self assert: (aLoadedDice isKindOf: LoadedDice).
	
]

{ #category : #tests }
LoadedDiceTests >> test02ChargeDiceWithCollection [
	|aLoadedDice numbers|
	
	numbers := #(1 2 3 4)  .
	aLoadedDice := LoadedDice with: numbers .

	self assert: (aLoadedDice throw) equals: 1.
	
]
