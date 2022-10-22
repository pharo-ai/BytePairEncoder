"
Some tutorials on internet take the frequency of individual character and merge the two most frequent (https://towardsdatascience.com/byte-pair-encoding-subword-based-tokenization-algorithm-77828a70bee0)

While the real algorithm takes the two most frequent *adjacent* pairs in the corpus.
"
Class {
	#name : #WrongBytePairEncoder,
	#superclass : #Object,
	#instVars : [
		'words',
		'characterVocabulary'
	],
	#category : #BytePairEncoder
}

{ #category : #build }
WrongBytePairEncoder >> buildFrequencyTable [
	
	characterVocabulary := Bag new.
	"we do not add characters but string because in the merge phase we will have sequences of characters."
	words do: [ :each | each do: [ :aChar | characterVocabulary add: aChar asString ]].
	
]

{ #category : #accessing }
WrongBytePairEncoder >> frequencyOf: aString [ 
	^ characterVocabulary occurrencesOf: aString 
]

{ #category : #accessing }
WrongBytePairEncoder >> numberOfTokens [
	^ characterVocabulary keys size
]

{ #category : #accessing }
WrongBytePairEncoder >> occurrencesOf: aString [ 
	^ words occurrencesOf: aString 
]

{ #category : #'as yet unclassified' }
WrongBytePairEncoder >> prepareWordsFromText: aText [

	|  rawWords |
	rawWords := (aText substrings: {Character space . Character cr. Character tab}).
	words := Bag new addAll: (rawWords collect: [ :each | each , '_' ])
]
