Class {
	#name : #BytePairEncoderTest,
	#superclass : #TestCase,
	#category : #BytePairEncoder
}

{ #category : #tests }
BytePairEncoderTest >> testSplitText [

	| enc |
	enc := BytePairEncoder new. 
	enc splitText: self text.
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
