Class {
	#name : #ProbabilityTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ProbabilityTests >> test001CheckDistributionOfEffectsIn1000GameboardsWithHyperJumpArrays [
| parsecs aProbability effectsProbabilities array|

parsecs := 4. 
aProbability := ProbabilityOfEffects new.
array:=#(#(6 5 2) #(9 9 8 6 5 4 -5) #(2 1 -9) #(6 6 4 2 1) #(3 2 1) #(9 2) #(4 1) #(9 5)).
effectsProbabilities := aProbability calculate: #(40 20 20 10 8 2 0) forHyperJump: array.

self assert: ((effectsProbabilities at: 1) >39  and: (effectsProbabilities at: 1) < 40) .
self assert: ((effectsProbabilities at: 2) >19  and: (effectsProbabilities at: 2) < 21) .
self assert: ((effectsProbabilities at: 3) >19  and: (effectsProbabilities at: 3) < 21) .
self assert: ((effectsProbabilities at: 4) >9  and: (effectsProbabilities at: 4) < 11) .
self assert: ((effectsProbabilities at: 5) >7  and: (effectsProbabilities at: 5) < 9) .
self assert: ((effectsProbabilities at: 6) >1  and: (effectsProbabilities at: 6) < 3) .





  
]

{ #category : #tests }
ProbabilityTests >> test002CheckDifferentDistributionOfEffectsIn1000GameboardsWithHyperJumpArrays [
| parsecs aProbability effectsProbabilities array|

parsecs := 4. 
aProbability := ProbabilityOfEffects new.
array:=#(#(6 5 2) #(9 9 8 6 5 4 -5) #(2 1 -9) #(6 6 4 2 1) #(3 2 1) #(9 2) #(4 1) #(9 5)).
effectsProbabilities := aProbability calculate: #(40 30 10 10 10 0 0) forHyperJump: array.

self assert: ((effectsProbabilities at: 1) >39  and: (effectsProbabilities at: 1) < 41) .
self assert: ((effectsProbabilities at: 2) >29  and: (effectsProbabilities at: 2) < 31) .
self assert: ((effectsProbabilities at: 3) >9  and: (effectsProbabilities at: 3) < 11) .
self assert: ((effectsProbabilities at: 4) >9  and: (effectsProbabilities at: 4) < 11) .
self assert: ((effectsProbabilities at: 5) >9  and: (effectsProbabilities at: 5) < 11) .
self assert: ((effectsProbabilities at: 6) >(-1)  and: (effectsProbabilities at: 6) < 1) .





  
]

{ #category : #tests }
ProbabilityTests >> test003CheckDifferentDistributionOfEffectsIn1000GameboardsWithCardAssignationCell [
| parsecs aProbability effectsProbabilities array|

parsecs := 4. 
aProbability := ProbabilityOfEffects new.
array:=#(#(6 5 2) #(9 9 8 6 5 4 -5) #(2 1 -9) #(6 6 4 2 1) #(3 2 1) #(9 2) #(4 1) #(9 5)).
effectsProbabilities := aProbability calculate: #(38 20 20 10 8 2 2) forHyperJump: array.

self assert: ((effectsProbabilities at: 1) >37  and: (effectsProbabilities at: 1) < 39) .
self assert: ((effectsProbabilities at: 2) >19  and: (effectsProbabilities at: 2) < 21) .
self assert: ((effectsProbabilities at: 3) >19  and: (effectsProbabilities at: 3) < 21) .
self assert: ((effectsProbabilities at: 4) >9  and: (effectsProbabilities at: 4) < 11) .
self assert: ((effectsProbabilities at: 5) >7  and: (effectsProbabilities at: 5) < 9) .
self assert: ((effectsProbabilities at: 6) >1  and: (effectsProbabilities at: 6) < 3) .
self assert: ((effectsProbabilities at: 7) >1  and: (effectsProbabilities at: 7) < 3) .





  
]
