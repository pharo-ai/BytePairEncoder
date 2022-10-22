"
I implement the Byte-Pair Encoding: Subword-based tokenization algorithm as defined in A New Algorithm for Data Compression.

BPE is a simple form of data compression algorithm in which the most common pair of consecutive bytes of data is replaced with a byte that does not occur in that data. It was first described in the article ""A New Algorithm for Data Compression"" published in 1994. 

Suppose we have data aaabdaaabac which needs to be encoded (compressed). The byte pair aa occurs most often, so we will replace it with Z as Z does not occur in our data. So we now have ZabdZabac where Z = aa. The next common byte pair is ab so let’s replace it with Y. We now have ZYdZYac where Z = aa and Y = ab. The only byte pair left is ac which appears as just one so we will not encode it. We can use recursive byte pair encoding to encode ZY as X. Our data has now transformed into XdXac where X = ZY, Y = ab, and Z = aa. It cannot be further compressed as there are no byte pairs appearing more than once. We decompress the data by performing replacements in reverse order. A variant of this is used in NLP.

The current implementation is super naive. 
Not a single optimization. 

Read [https://guillaume-be.github.io/2021-09-16/byte_pair_encoding](https://guillaume-be.github.io/2021-09-16/byte_pair_encoding) for possible optimization. 


Step 0. Initialize vocabulary.
Step 1. Represent each word in the corpus as a combination of the characters along with the special end of word token </w>.
Step 2. Iteratively count character pairs in all tokens of the vocabulary.
Step 3. Merge every occurrence of the most frequent pair, add the new character n-gram to the vocabulary.
Step 4. Repeat step 3 until the desired number of merge operations are completed or the desired vocabulary size is achieved (which is a hyperparameter).
"
Class {
	#name : #BytePairEncoder,
	#superclass : #Object,
	#instVars : [
		'words',
		'characterVocabulary',
		'pairs'
	],
	#category : #BytePairEncoder
}

{ #category : #vocabulary }
BytePairEncoder >> addToVocabulary: aString [
	
	characterVocabulary add: aString
	
]

{ #category : #vocabulary }
BytePairEncoder >> buildVocabulary [
	
	"we do not add characters but string because in the merge phase we will have sequences of characters."
	words do: [ :each | each do: [ :aChar | self addToVocabulary: aChar asString ]].
	
]

{ #category : #compute }
BytePairEncoder >> computePairs [
	
	words associationsDo: [ :association | 
		self pairForAssociation: association ] 
]

{ #category : #accessing }
BytePairEncoder >> frequencyOf: aString [ 
	^ characterVocabulary occurrencesOf: aString 
]

{ #category : #initialization }
BytePairEncoder >> initialize [

	super initialize.
	words := Bag new.
	characterVocabulary := Set new.
	pairs := Bag new.
	
]

{ #category : #merging }
BytePairEncoder >> mergeOneStep [

	"We should probably keep the sorted version... for later."
	self addToVocabulary: pairs sortedCounts first value.
	
	"Now should update all the corpus to reflect that we want to replace the most frequent pairs with a new vocabulary element."
]

{ #category : #accessing }
BytePairEncoder >> numberOfPairs [
	
	^ pairs keys size
]

{ #category : #accessing }
BytePairEncoder >> numberOfTokens [
	^ characterVocabulary keys size
]

{ #category : #accessing }
BytePairEncoder >> occurrencesOf: aString [ 
	^ words occurrencesOf: aString 
]

{ #category : #compute }
BytePairEncoder >> pairForAssociation: anAssociation [ 
	
	| word |
	word := anAssociation key.
	word overlappingPairsWithIndexDo: [ :a :b :index | pairs add:  a asString , b asString withOccurrences: anAssociation value ]
]

{ #category : #accessing }
BytePairEncoder >> pairOccurrencesOf: aString [ 
	
	^ pairs occurrencesOf: aString
]

{ #category : #'as yet unclassified' }
BytePairEncoder >> prepareWordsFromText: aText [

	|  rawWords |
	rawWords := (aText substrings: {Character space . Character cr. Character tab}).
	words addAll: (rawWords collect: [ :each | each , '_' ])
]

{ #category : #vocabulary }
BytePairEncoder >> vocabulary [

	^ characterVocabulary
]
