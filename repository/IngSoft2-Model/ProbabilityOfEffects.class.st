Class {
	#name : #ProbabilityOfEffects,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #calculating }
ProbabilityOfEffects >> averageProbabilities: aCollectionOfTemporalVariables [

	| finalAverages sizeOfCollection total numberWithDecimals |
	finalAverages := OrderedCollection new.
	sizeOfCollection := aCollectionOfTemporalVariables size.

	1 to: sizeOfCollection - 1 do: [ :index | 
		numberWithDecimals := (aCollectionOfTemporalVariables at: index) / (aCollectionOfTemporalVariables at: sizeOfCollection).
		total := (numberWithDecimals * 100) asFloat.
		finalAverages add: total ].

	^ finalAverages
]

{ #category : #calculating }
ProbabilityOfEffects >> calculate: arrayOfEffectsProbabilities forHyperJump: aCollectionOfDifferentParsecs [ 
	|gameboards totalWormHoles totalSpeedUps totalMoonWalks totalHyperJumps totalAtomicBombs totalNormalCells totalCells finalArray arrayWithTemporalVariables totalSpecialCardsCells|
	gameboards := self createArrayOfGameBoards: arrayOfEffectsProbabilities forHyperJump: aCollectionOfDifferentParsecs .
	
		totalWormHoles := 0.
		totalSpeedUps := 0. 
		totalMoonWalks := 0. 
		totalHyperJumps := 0. 
		totalAtomicBombs := 0. 
		totalNormalCells := 0.
		totalSpecialCardsCells := 0.
		totalCells:= 0.
		
	   gameboards do: [ :each | 
		totalWormHoles := totalWormHoles + each amountOfWormHoles.
		totalSpeedUps := totalSpeedUps + each amountOfSpeedUps. 
		totalMoonWalks := totalMoonWalks + each amountOfMoonWalks. 
		totalHyperJumps := totalHyperJumps + each amountOfHyperJumps. 
		totalAtomicBombs := totalAtomicBombs + each amountOfAtomicBombs.
		totalSpecialCardsCells := totalSpecialCardsCells + each amountOfSpecialCardsCells.
		totalNormalCells := totalNormalCells + each amountOfNormalCells.
		
		
		totalCells:= each amountOfCells + totalCells.].
		
	
	arrayWithTemporalVariables := OrderedCollection new.
	arrayWithTemporalVariables add: totalNormalCells.
	arrayWithTemporalVariables add: totalWormHoles.
	arrayWithTemporalVariables add: totalSpeedUps.
	arrayWithTemporalVariables add: totalMoonWalks.
	arrayWithTemporalVariables add: totalHyperJumps.
	arrayWithTemporalVariables add: totalAtomicBombs.
	arrayWithTemporalVariables add: totalSpecialCardsCells.
	arrayWithTemporalVariables add: totalCells.
	
	
	finalArray := self averageProbabilities: arrayWithTemporalVariables .
	
	^ finalArray
]

{ #category : #creation }
ProbabilityOfEffects >> createArrayOfGameBoards: arrayOfEffectsProbabilites forHyperJump: aCollectionOfDifferentParsecs [

	| array |
	array := OrderedCollection new.
	1 to: 5000 do: [ :index | 
		array add: ((GameBoard with: 100 and: 1) addEffects: arrayOfEffectsProbabilites
		forHyperJump: aCollectionOfDifferentParsecs) ].

	^ array
]
