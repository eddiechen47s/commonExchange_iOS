//
//  BaseImageView.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/4/11.
//

import UIKit

class BaseImageView: UIImageView {
    
    init(image: String, color: UIColor?) {
        super.init(frame: .zero)
        self.image = UIImage(named: image)
        self.tintColor = color
        self.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class NavbarImageView: UIImageView {
    init(image: String, color: UIColor?) {
        super.init(frame: .zero)
        
        if image != nil {
            self.image = UIImage(named: image)?.withTintColor(color ?? .black)
        } else {
            self.image = UIImage(systemName: image)
        }
        self.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
