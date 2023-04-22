Class {
	#name : #GameTest,
	#superclass : #Object,
	#instVars : [
		'result',
		'gameboard'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
GameTest class >> initializeEmpty [
	^(self new) initializeWith: 'The Game does not have a winner'
]

{ #category : #creation }
GameTest >> create: amountOfPlayers [
	|playersCollection count|
	count:=1.
	playersCollection := OrderedCollection new.
	[ count <= amountOfPlayers  ] whileTrue: [ 
		playersCollection add: Player new.
		count :=count +1
	 ].
^playersCollection.
	
	
]

{ #category : #intialization }
GameTest >> initializeWith: aResult [ 
	result := aResult.
	gameboard := nil.
]

{ #category : #validations }
GameTest >> playUntilWinner: aDice [ 
	[(gameboard winner)= false ] whileTrue: [ 
		 gameboard playRoundWith: aDice 
	
	 ].
	result := 'The Game has ended' .
]

{ #category : #validation }
GameTest >> result [
	^ result
]

{ #category : #start }
GameTest >> start [
	result := 'The Game does not have a winner' 
]

{ #category : #starting }
GameTest >> startwith: aPlayer [ 
	result:= aPlayer 
]

{ #category : #starting }
GameTest >> startwith: aPlayer and: aGameboard [

gameboard := aGameboard .

aGameboard fillPlayers: aPlayer  .
"((aGameboard player aPlayer) = (aGameboard amountOfCells)) ifTrue: [result:= aPlayer  ]."
	 
]

{ #category : #validating }
GameTest >> winner [
	 
	^gameboard winner
]
