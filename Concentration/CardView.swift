//
//  CardView.swift
//  Concentration
//
//  Created by Пётр Санников on 9.06.22.
//

import UIKit

@IBDesignable
class CardView: UIView {
    
    var isFaceUp = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    var image: Character = "😛" { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes: [NSAttributedString.Key: Any] = [.paragraphStyle: paragraphStyle, .font: font]
        return NSAttributedString(string: string, attributes: attributes)
    }

    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 10)
        roundedRect.addClip()
        UIColor.blue.setFill()
        roundedRect.fill()
        
        if isFaceUp {
            UIColor.gray.setFill()
            roundedRect.fill()
            let cardImage = centeredAttributedString(String(image), fontSize: 40)
            cardImage.draw(in: CGRect(x: bounds.origin.x, y: (bounds.origin.y + bounds.height/2 - cardImage.size().height/2), width: bounds.width, height: cardImage.size().height))
        } else {
            UIColor.blue.setFill()
            roundedRect.fill()
        }
        
        self.contentMode = .redraw
        isOpaque = false
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
}
