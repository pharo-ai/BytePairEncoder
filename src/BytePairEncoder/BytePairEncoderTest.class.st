Class {
	#name : #BytePairEncoderTest,
	#superclass : #TestCase,
	#category : #BytePairEncoder
}

{ #category : #tests }
BytePairEncoderTest >> testBuildVocabularyProducesCorrectVocabulary [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text.
	enc computeVocabulary.
	self 
		assertCollection: enc vocabulary asSet
		hasSameElements: { '_' . 'd' . 'e' . 'i' . 'l' . 'f' . 'n' . 'o' . 'r' . 's' . 't' . 'w'} asSet


]

{ #category : #'tests - text2' }
BytePairEncoderTest >> testBuildVocabularyProducesCorrectVocabularyText2 [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text2.
	enc computeVocabulary.
	self assertCollection: enc vocabulary asSet hasSameElements: { '_' . 'd' . 'e' . 'i' . 'l' . 'n' . 'o' . 'r' . 's' . 't' . 'w'} asSet

]

{ #category : #tests }
BytePairEncoderTest >> testComputePairs [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text.
	enc computePairs.
	
	self assert: (enc pairOccurrencesOf: {'o' . 'l'}) equals: 10. 
	self assert: (enc pairOccurrencesOf: {'l' . 'd'}) equals: 10. 
	self assert: (enc pairOccurrencesOf: {'l' .'d'}) equals: 10. 
	self assert: (enc pairOccurrencesOf: {'s' .'t'}) equals: 13. 
	self assert: (enc pairOccurrencesOf: {'e' . 's'}) equals: 13. 
	self assert: (enc pairOccurrencesOf: {'l' .'o'}) equals: 4. 
	self assert: (enc pairOccurrencesOf: {'t' . '_'}) equals: 13. 
	
	self assert: enc numberOfPairs equals: 15
	
]

{ #category : #'tests - text2' }
BytePairEncoderTest >> testComputePairsText2 [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text2.
	enc computePairs.
	
	self assert: (enc pairOccurrencesOf: {'e' .'s'}) equals: 9. 
	self assert: (enc pairOccurrencesOf: {'i'. 'd'}) equals: 3. 
	self assert: (enc pairOccurrencesOf: {'o' .'w'}) equals: 7. 
	self assert: (enc pairOccurrencesOf: {'s'. 't'}) equals: 9. 
	self assert: (enc pairOccurrencesOf: {'w'. 'e'}) equals: 8. 
	self assert: (enc pairOccurrencesOf: {'w'. 'i'}) equals: 3. 
	self assert: (enc pairOccurrencesOf: {'t'.'_'}) equals: 9. 
	
	 "#('lo' 't_' 'er' 'r_' 'st' 'wi' 'es' 'ne' 'ow' 'we' 'w_' 'id' 'de' 'ew')"
	self assert: enc numberOfPairs equals: 14
	
]

{ #category : #tests }
BytePairEncoderTest >> testMergeOneStepAddMergeToMergeList [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text.
	enc computeVocabulary.
	enc computePairs.
	self assert: enc merges isEmpty.
	enc mergeOneStep.
	self assert: enc merges first equals: #('e' 's')->'es' 
]

{ #category : #tests }
BytePairEncoderTest >> testMergeOneStepIncreaseVocabularyAndMerges [

	| enc mergeOldSize |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text.
	enc computeVocabulary.
	enc computePairs.
	
	self assert: enc vocabulary size equals: 12.
	mergeOldSize := enc merges size.
	enc mergeOneStep.
	self assert: (enc vocabulary includes: 'es').
	self assert: enc merges size equals: mergeOldSize + 1.
	self assert: enc vocabulary size equals: 13
	
]

{ #category : #tests }
BytePairEncoderTest >> testMergeOneStepRecomputePairs [

	| enc finestFrequency |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text.
	finestFrequency := enc frequencyOfWord: #('f' 'i' 'n' 'es' 't').
	enc computeVocabulary.
	enc computePairs.
	
	enc mergeOneStep.
	
	self assert: (enc pairOccurrencesOf: {'o' . 'l'}) equals: 10. 
	self assert: (enc pairOccurrencesOf: {'l' . 'd'}) equals: 10. 
	self assert: (enc pairOccurrencesOf: {'l' .'d'}) equals: 10. 
	self assert: (enc pairOccurrencesOf: {'es' . 't'}) equals: 13. 
	self assert: (enc pairOccurrencesOf: {'l' .'o'}) equals: 4. 
	self assert: (enc pairOccurrencesOf: {'t' . '_'}) equals: 13. 
	self assert: (enc pairOccurrencesOf: {'w' . 'es'}) equals: 4. 
	self assert: (enc pairOccurrencesOf: {'n' . 'es'}) equals: 9. 
]

{ #category : #tests }
BytePairEncoderTest >> testMergeOneStepUpdatesCorpus [

	| enc finestFrequency |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text.
	finestFrequency := enc frequencyOfWord: #('f' 'i' 'n' 'es' 't').
	enc computeVocabulary.
	enc computePairs.
	
	enc mergeOneStep.
	"should have a better assert"
	self assert: (enc uniqueWords includes: #('l' 'o' 'w' 'es' 't' '_') asOrderedCollection).
	self assert: (enc uniqueWords includes: #('f' 'i' 'n' 'es' 't' '_') asOrderedCollection). 
	self assert: (enc frequencyOfWord: #('f' 'i' 'n' 'es' 't' '_')) equals: finestFrequency.
]

{ #category : #tests }
BytePairEncoderTest >> testPrepareWordsFromText [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text.
	self assert: (enc occurrencesOf: #('o' 'l' 'd' '_') asOrderedCollection) equals: 7. 
	self assert: (enc occurrencesOf: #('o' 'l' 'd' 'e' 'r' '_') asOrderedCollection) equals: 3. 
	self assert: (enc occurrencesOf: #('f' 'i' 'n' 'e' 's' 't' '_') asOrderedCollection) equals: 9. 
	self assert: (enc occurrencesOf: #('l' 'o' 'w' 'e' 's' 't' '_') asOrderedCollection) equals: 4. 

]

{ #category : #tests }
BytePairEncoderTest >> testTwoMerges [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text.
	enc computeVocabulary.
	enc computePairs.
	enc mergeOneStep.
	enc mergeOneStep.
	
	self assert: enc merges first equals: #('e' 's')->'es'. 
	self assert: enc merges second equals: #('es' 't')->'est'. 
]

{ #category : #tests }
BytePairEncoderTest >> text [
	^ 'old old old old old old old 
older older older
finest finest finest finest finest finest finest finest finest 
lowest lowest lowest lowest 
'
]

{ #category : #'tests - text2' }
BytePairEncoderTest >> text2 [
	^ '
low low low low low
lower lower
newest newest newest newest newest newest 
widest widest widest'
]
