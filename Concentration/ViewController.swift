//
//  ViewController.swift
//  Concentration
//
//  Created by Benja Muñoz  on 7/28/18.
//  Copyright © 2018 Benja Munoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
            return (cardButtons.count+1) / 2
        }
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var restartButton: UIButton!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    
    @IBAction func touchRestart(_ sender: UIButton) {
        if game.numberOfPairsOfCardsNotMatched == 0{
            flipCount = 0
            restartButton.isHidden = true
            emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎","👹","💀","🧟‍♂️"]
            game = Concentration(numberOfPairsOfCards: cardButtons.count/2)
            updateViewFromModel()
            
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            
        } else {
            print("choosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        
        if game.numberOfPairsOfCardsNotMatched == 0{
            print("Restart button appeared")
            restartButton.isHidden = false
        }
    }
        
        private var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎","👹","💀","🧟‍♂️"]
        private var emojis = [Int:String]()
        
        func emoji(for card: Card) -> String {
            if emojis[card.identifier] == nil {
                if emojiChoices.count > 0{
                    emojis[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
                }
            }
            return emojis[card.identifier] ?? "?"
        }
        
        }

extension Int {
    var arc4random: Int {
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        }
        else {
            return 0
        }
    }
}



