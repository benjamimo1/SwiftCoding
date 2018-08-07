//
//  Card.swift
//  Concentration
//
//  Created by Benja Muñoz  on 7/29/18.
//  Copyright © 2018 Benja Munoz. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int{
        Card.identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
