Class {
	#name : #BytePairEncoder,
	#superclass : #Object,
	#instVars : [
		'words',
		'characterVocabulary'
	],
	#category : #BytePairEncoder
}

{ #category : #build }
BytePairEncoder >> buildFrequencyTable [
	
	characterVocabulary := Bag new.
	"we do not add characters but string because in the merge phase we will have sequences
	of characters."
	
	words do: [ :each | each do: [ :aChar | characterVocabulary add: aChar asString ]].
	
]

{ #category : #accessing }
BytePairEncoder >> frequencyOf: aString [ 
	^ characterVocabulary occurrencesOf: aString 
]

{ #category : #accessing }
BytePairEncoder >> occurrencesOf: aString [ 
	^ words occurrencesOf: aString 
]

{ #category : #'as yet unclassified' }
BytePairEncoder >> prepareWordsFromText: aText [

	|  rawWords |
	rawWords := (aText substrings: {Character space . Character cr. Character tab}).
	words := Bag new addAll: (rawWords collect: [ :each | each , '_' ])
]
