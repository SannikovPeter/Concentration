//
//  Concentration.swift
//  Concentration
//
//  Created by Пётр Санников on 13.05.22.
//

import Foundation

struct Concentration {
    
    var cards = [Card]()
    
    private var indexOfOnlyOneFaceUpCard: Int? {
        get{
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
        
    }
    
    private(set) var isEndGame = false
    
    private var matchesCounter = 0 {
        didSet{
            isEndGame = matchesCounter == cards.count
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOnlyOneFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    matchesCounter += 2
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOnlyOneFaceUpCard = index
            }
        }
    }
    
    init (numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0 , "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        cards.shuffle()
    }
    
    mutating func startAgane() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        cards.shuffle()
        matchesCounter = 0
        isEndGame = false
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
