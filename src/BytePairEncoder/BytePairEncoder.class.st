Class {
	#name : #BytePairEncoder,
	#superclass : #Object,
	#instVars : [
		'words'
	],
	#category : #BytePairEncoder
}

{ #category : #accessing }
BytePairEncoder >> occurrencesOf: aString [ 
	^ words occurrencesOf: aString 
]

{ #category : #'as yet unclassified' }
BytePairEncoder >> splitText: aText [

	|  rawWords |
	rawWords := (aText substrings: {Character space . Character cr. Character tab}).
	words := Bag new addAll: (rawWords collect: [ :each | each , '_' ])
]
