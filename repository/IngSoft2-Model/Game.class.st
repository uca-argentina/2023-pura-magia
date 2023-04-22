Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'result',
		'gameboard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> initializeEmpty [
	^(self new) initializeWith: 'The Game does not have a winner'
]

{ #category : #intialization }
Game >> initializeWith: aResult [ 
	result := aResult.
	gameboard := nil.
]

{ #category : #validations }
Game >> playUntilWinner: aDice [ 
	[(gameboard winner)= false ] whileTrue: [ 
		 gameboard throwDice: aDice 
	
	 ].
]

{ #category : #validation }
Game >> result [
	^ result
]

{ #category : #start }
Game >> start [
	result := 'The Game does not have a winner' 
]

{ #category : #starting }
Game >> startwith: aPlayer [ 
	result:= aPlayer 
]

{ #category : #starting }
Game >> startwith: aPlayer and: aGameboard [
gameboard := aGameboard .
aGameboard fillPlayers: aPlayer .
"((aGameboard player aPlayer) = (aGameboard amountOfCells)) ifTrue: [result:= aPlayer  ]."
	 
]
