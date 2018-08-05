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
    var preCards = [Card]()
    var numberOfPairsOfCardsNotMatched: Int
    var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil{
                        foundIndex = index
                    }
                    else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    //optional pues podria no haber una carta boca arriba! Tendria valor "not set"
    
    func chooseCard(at index: Int)
    {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                }
                cards[index].isFaceUp = true
            }
            else {
                //either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
        if numberOfPairsOfCardsNotMatched == 0 {
            print("Fin del juego")
        }
        
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            //let matchingCard = card se copia, no referencia la variable
            preCards += [card,card]
        }
        
        while preCards.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(preCards.count)))
            cards.append(preCards.remove(at: randomIndex))
        }
        
        self.numberOfPairsOfCardsNotMatched = numberOfPairsOfCards
    }
    
}
