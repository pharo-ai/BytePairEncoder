Class {
	#name : #WrongBytePairEncoderTest,
	#superclass : #TestCase,
	#category : #BytePairEncoder
}

{ #category : #tests }
WrongBytePairEncoderTest >> testBuildFrequencyTable [

	| enc |
	enc := WrongBytePairEncoder new. 
	enc prepareWordsFromText: self text.
	enc buildFrequencyTable.
	self assert: (enc frequencyOf: '_') equals: 23. 
	self assert: (enc frequencyOf: 'o') equals: 14. 
	self assert: (enc frequencyOf: 'l') equals: 14. 
	
	self assert: enc numberOfTokens equals: 12.
	
]

{ #category : #tests }
WrongBytePairEncoderTest >> testPrepareWordsFromText [

	| enc |
	enc := WrongBytePairEncoder new. 
	enc prepareWordsFromText: self text.
	self assert: (enc occurrencesOf: 'old_') equals: 7. 
	self assert: (enc occurrencesOf: 'older_') equals: 3. 
	self assert: (enc occurrencesOf: 'finest_') equals: 9. 
	self assert: (enc occurrencesOf: 'lowest_') equals: 4. 
]

{ #category : #tests }
WrongBytePairEncoderTest >> text [
	^ 'old old old old old old old 
older older older
finest finest finest finest finest finest finest finest finest 
lowest lowest lowest lowest 
'
]
