Class {
	#name : #ShipTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ShipTests >> test001ShipExistsThenIsValid [

	| aShip|
	
	aShip := Ship new.
	self assert: (aShip isValid ).
]

{ #category : #tests }
ShipTests >> test002 [

	| aShip position|
	position := 3.
	aShip := Ship withPosition: position.
	self deny: (aShip isValid ).
]
