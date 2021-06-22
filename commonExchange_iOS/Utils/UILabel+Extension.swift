//
//  UILabel+Extension.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/2.
//

import UIKit

class BaseLabel: UILabel {
    init(text: String, color: UIColor?, font: UIFont?, alignments: NSTextAlignment?) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = color ?? .white
        self.font = font ?? .systemFont(ofSize: 12)
        self.textAlignment = alignments ?? .left
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
