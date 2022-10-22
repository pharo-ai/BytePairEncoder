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

{ #category : #tests }
BytePairEncoderTest >> text [
	^ 'old old old old old old old 
older older older
finest finest finest finest finest finest finest finest finest 
lowest lowest lowest lowest 
'
]
