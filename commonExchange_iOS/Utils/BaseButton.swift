//
//  BaseButton.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/3/13.
//

import UIKit

class BaseButton: UIButton {
    
    init(title: String, titleColor: UIColor, font: UIFont, backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 5
        self.titleLabel?.font = font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomButton: UIButton {
    
    init(title: String, titleColor: UIColor, font: UIFont, backgroundColor: UIColor, action: Selector, vc: UIViewController) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 5
        self.titleLabel?.font = font
        self.addTarget(vc, action: action, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BaseImgButton: UIButton {
    
    init(img: BaseImageView, action: Selector, vc: UIViewController) {
        super.init(frame: .zero)
        let image: UIImage = img.image ?? UIImage()
        self.setImage(image, for: .normal)
        self.addTarget(vc, action: action, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NavBarButton: UIButton {
    
    init(img: NavbarImageView, action: Selector, vc: UIViewController) {
        super.init(frame: .zero)
        let image: UIImage = img.image ?? UIImage()
        self.setImage(image, for: .normal)
        self.addTarget(vc, action: action, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class WithdrawalButton: UIButton {
    
    init(title: String, textColor: UIColor, backgroundColor: UIColor, action: Selector, vc: UIViewController) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.addTarget(vc, action: action, for: .touchUpInside)
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
