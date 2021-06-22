//
//  BaseTextView.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/4/26.
//

import UIKit

class BaseTextView: UITextView {
    
    init(text: String, textColor: UIColor, font: UIFont) {
        super.init(frame: .zero, textContainer: nil)
        self.backgroundColor = .clear
        self.isEditable = false
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = 3
        let attributes = [NSAttributedString.Key.foregroundColor:textColor,
                          NSAttributedString.Key.font:font,
                          NSAttributedString.Key.paragraphStyle: paraph]
        self.attributedText = NSAttributedString(string: text, attributes: attributes)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
