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
ShipTests >> test002CheckPositionShip [

	| aShip position|
	position := 3.
	aShip := Ship with: position.
	self assert: (aShip atPosition: 3 ).
]

{ #category : #tests }
ShipTests >> test003CheckWrongPositionShipTHenInvalid [

	| aShip position|
	position := 3.
	aShip := Ship with: position.
	self deny: (aShip atPosition: 5 ).
]

{ #category : #tests }
ShipTests >> test004MoveShip [

	| aShip position number|
	position := 3.
	number := 4.
	aShip := Ship with: position.
	aShip incrementPosition: number.
	self assert: (aShip atPosition: 7 ).
]
