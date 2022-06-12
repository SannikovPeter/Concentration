//
//  ViewController.swift
//  Concentration
//
//  Created by Пётр Санников on 11.05.22.
//

import UIKit

 class ConcentrationViewController: UIViewController {
    
     private var game: Concentration?
     
     @IBOutlet private weak var startAgane: UIButton!
    
     @IBOutlet var cardsList: [CardView]!
     
     @IBOutlet private weak var flipsLabel: UILabel! {
        didSet {
            updateFlipCount()
        }
    }
     
     var theme: String = "👻🧟‍♀️🥶😈🎃🦇👽🙀☠️🦠"
     
     private var flipCounter = 0 {
         didSet {
             updateFlipCount()
         }
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()
         game = Concentration(numberOfPairsOfCards: (cardsList.count + 1) / 2, theme: theme)
         for (index, card) in cardsList.enumerated() {
             card.image = game?.cards[index].image ?? Character("?")
         }
         for cardView in cardsList {
             cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard(_:))))
         }
     }
     
     @objc func flipCard(_ recognizer: UITapGestureRecognizer) {
         switch recognizer.state {
         case .ended:
             if let chosenCard = recognizer.view as? CardView {
                 UIView.transition(
                     with: chosenCard,
                     duration: 0.6,
                     options: [.transitionFlipFromLeft],
                     animations: {
                         chosenCard.isFaceUp = !chosenCard.isFaceUp
                     }
                 )
             }
         default: break
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
     
    @IBAction private func startAganeAction(_ sender: UIButton) {
//        game.startAgane()
        startAgane.alpha = 0
        startAgane.isEnabled = false
        flipCounter = 0
    }
}



