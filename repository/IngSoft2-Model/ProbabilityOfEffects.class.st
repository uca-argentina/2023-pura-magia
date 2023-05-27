Class {
	#name : #ProbabilityOfEffects,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #calculating }
ProbabilityOfEffects >> averageProbabilities: aCollectionOfTemporalVariables [

|finalAverages index sizeOfCollection total numberWithDecimals|
finalAverages := OrderedCollection new.
index := 1.
sizeOfCollection:= aCollectionOfTemporalVariables size.
[ index <= (sizeOfCollection - 1) ] whileTrue: [
	
	numberWithDecimals:= ((aCollectionOfTemporalVariables at: index )/(aCollectionOfTemporalVariables at: sizeOfCollection)) .
	total:= (numberWithDecimals * 100) asFloat .
	finalAverages add: total .
	index := index + 1.
	
	 ].
^ finalAverages .

	
]

{ #category : #calculating }
ProbabilityOfEffects >> calculate: arrayOfEffectsProbabilities forHyperJump: aCollectionOfDifferentParsecs [ 
	|index gameboards totalWormHoles totalSpeedUps totalMoonWalks totalHyperJumps totalAtomicBombs totalNormalCells totalCells finalArray arrayWithTemporalVariables|
	gameboards := self createArrayOfGameBoards: arrayOfEffectsProbabilities forHyperJump: aCollectionOfDifferentParsecs .
	index := 1.
		totalWormHoles := 0.
		totalSpeedUps := 0. 
		totalMoonWalks := 0. 
		totalHyperJumps := 0. 
		totalAtomicBombs := 0. 
		totalNormalCells := 0.
		totalCells:= 0.
		
	[ index <= (gameboards size) ] whileTrue: [
		
		totalWormHoles := totalWormHoles + (gameboards at: index) amountOfWormHoles.
		totalSpeedUps := totalSpeedUps + (gameboards at: index) amountOfSpeedUps. 
		totalMoonWalks := totalMoonWalks + (gameboards at: index) amountOfMoonWalks. 
		totalHyperJumps := totalHyperJumps + (gameboards at: index) amountOfHyperJumps. 
		totalAtomicBombs := totalAtomicBombs + (gameboards at: index) amountOfAtomicBombs. 
		totalNormalCells := totalNormalCells + (gameboards at: index) amountOfNormalCells.
		
		totalCells:= (gameboards at: index) amountOfCells + totalCells.
		
		index := index + 1.
	 ].
	
	arrayWithTemporalVariables := OrderedCollection new.
	arrayWithTemporalVariables add: totalNormalCells.
	arrayWithTemporalVariables add: totalWormHoles.
	arrayWithTemporalVariables add: totalSpeedUps.
	arrayWithTemporalVariables add: totalMoonWalks.
	arrayWithTemporalVariables add: totalHyperJumps.
	arrayWithTemporalVariables add: totalAtomicBombs.
	arrayWithTemporalVariables add: totalCells.
	
	finalArray := self averageProbabilities: arrayWithTemporalVariables .
	
	^ finalArray
]

{ #category : #creation }
ProbabilityOfEffects >> createArrayOfGameBoards: arrayOfEffectsProbabilites forHyperJump: aCollectionOfDifferentParsecs [  
	|index array|
	index:= 1.
	array := OrderedCollection new.
	
[ index <= 10000 ] whileTrue: [ 
	array add: ((GameBoard with: 100 and: 1) addEffects: arrayOfEffectsProbabilites forHyperJump: aCollectionOfDifferentParsecs ).
	index := index + 1.
	 ].

^ array .
]
