//
//  Concentration.swift
//  Concentration
//
//  Created by Benja Muñoz  on 7/29/18.
//  Copyright © 2018 Benja Munoz. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    func chooseCard(at index: Int)
    {
        if cards[index].isFaceUp {
            cards[index].isFaceUp = false
        }
        else {
            cards[index].isFaceUp = true
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards{
        let card = Card()
        //let matchingCard = card se copia, no referencia la variable
        cards += [card,card]
    }

}
}
