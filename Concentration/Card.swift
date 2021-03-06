//
//  Card.swift
//  Concentration
//
//  Created by Пётр Санников on 13.05.22.
//

import Foundation

struct Card: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    var isFaceUp = false
    var isMatched = false
    var id : Int
    var image: Character = "?"
    
    private static var idFactory = 0
    
    private static func getUniqueId() -> Int {
        idFactory += 1
        return idFactory
    }
    
    init(image: Character) {
        id = Card.getUniqueId()
        self.image = image
    }
}
