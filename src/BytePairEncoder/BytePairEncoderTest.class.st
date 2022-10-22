Class {
	#name : #BytePairEncoderTest,
	#superclass : #TestCase,
	#category : #BytePairEncoder
}

{ #category : #tests }
BytePairEncoderTest >> testComputePairs [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text.
	enc computePairs.
	
	self assert: (enc pairOccurrencesOf: 'ol') equals: 10. 
	self assert: (enc pairOccurrencesOf: 'ld') equals: 10. 
	self assert: (enc pairOccurrencesOf: 'ld') equals: 10. 
	self assert: (enc pairOccurrencesOf: 'st') equals: 13. 
	self assert: (enc pairOccurrencesOf: 'es') equals: 13. 
	self assert: (enc pairOccurrencesOf: 'lo') equals: 4. 
	self assert: (enc pairOccurrencesOf: 't_') equals: 13. 
	
	self assert: enc numberOfPairs equals: 15
	
]

{ #category : #'tests - text2' }
BytePairEncoderTest >> testComputePairsText2 [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text2.
	enc computePairs.
	
	self assert: (enc pairOccurrencesOf: 'es') equals: 9. 
	self assert: (enc pairOccurrencesOf: 'id') equals: 3. 
	self assert: (enc pairOccurrencesOf: 'ow') equals: 7. 
	self assert: (enc pairOccurrencesOf: 'st') equals: 9. 
	self assert: (enc pairOccurrencesOf: 'we') equals: 8. 
	self assert: (enc pairOccurrencesOf: 'wi') equals: 3. 
	self assert: (enc pairOccurrencesOf: 't_') equals: 9. 
	
	 "#('lo' 't_' 'er' 'r_' 'st' 'wi' 'es' 'ne' 'ow' 'we' 'w_' 'id' 'de' 'ew')"
	self assert: enc numberOfPairs equals: 14
	
]

{ #category : #tests }
BytePairEncoderTest >> testMergeOneStep [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text.
	enc buildVocabulary.
	 
	enc computePairs.
	self assert: enc vocabulary size equals: 12.
	enc mergeOneStep.
	self assert: (enc vocabulary includes: 't_').
	self assert: enc vocabulary size equals: 13
	
]

{ #category : #tests }
BytePairEncoderTest >> testPrepareWordsFromText [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text.
	self assert: (enc occurrencesOf: 'old_') equals: 7. 
	self assert: (enc occurrencesOf: 'older_') equals: 3. 
	self assert: (enc occurrencesOf: 'finest_') equals: 9. 
	self assert: (enc occurrencesOf: 'lowest_') equals: 4. 
]

{ #category : #'tests - text2' }
BytePairEncoderTest >> testPrepareWordsFromText2 [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text2.
	enc buildVocabulary.
	self assertCollection: enc vocabulary asSet hasSameElements: { '_' . 'd' . 'e' . 'i' . 'l' . 'n' . 'o' . 'r' . 's' . 't' . 'w'} asSet

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
