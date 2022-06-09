//
//  ViewController.swift
//  Concentration
//
//  Created by Пётр Санников on 11.05.22.
//

import UIKit

 class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: (cardList.count + 1) / 2)

    @IBOutlet private weak var startAgane: UIButton!
    
    @IBOutlet private var cardList: [UIButton]!
    
    @IBOutlet private weak var flipsLabel: UILabel! {
        didSet {
            updateFlipCount()
        }
    }
    
    private var flipCounter = 0 {
        didSet {
            updateFlipCount()
        }
    }
    
    private func updateFlipCount() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.black
        ]
        let atributedString = NSAttributedString(string: "Flips: \(flipCounter)", attributes: attributes)
        flipsLabel.attributedText = atributedString
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardList.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            flipCounter += 1
        }
    }
    
    private func updateViewFromModel() {
        if cardList != nil {
            for index in cardList.indices {
                let button = cardList[index]
                let card = game.cards[index]
                if card.isFaceUp{
                    button.backgroundColor = .lightGray
                    button.setTitle(emoji(for: card), for: .normal)
                } else {
                    button.backgroundColor = card.isMatched ? .clear : .link
                    button.setTitle("", for: .normal)
                }
            }
            if game.isEndGame == true {
                startAgane.alpha = 1
                startAgane.isEnabled = true
            }
        }
    }
     
     var theme: String? {
         didSet {
             emojiChoises = theme ?? ""
             emoji = [:]
             updateViewFromModel()
         }
     }
    
    private var emojiChoises = "👻🧟‍♀️🥶😈🎃🦇👽🙀☠️🦠"

    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoises.count > 0 {
            let randomStringIndex = emojiChoises.index(emojiChoises.startIndex, offsetBy: emojiChoises.count.arc4random)
            emoji[card] = String(emojiChoises.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    @IBAction private func startAganeAction(_ sender: UIButton) {
        game.startAgane()
        startAgane.alpha = 0
        startAgane.isEnabled = false
        updateViewFromModel()
        flipCounter = 0
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else{
            return 0
        }
    }
}


