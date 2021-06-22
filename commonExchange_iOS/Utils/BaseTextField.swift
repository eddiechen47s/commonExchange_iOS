//
//  BaseTextField.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/12.
//

import UIKit

class BaseTextField: UITextField, UITextFieldDelegate {
    
    init(text: String, placeholder: String) {
        super.init(frame: .zero)
        self.delegate = self
        self.text = text
        self.placeholder = placeholder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class RegisterTextField: UITextField {
    
    init(text: String, placeholder: String) {
        super.init(frame: .zero)
        self.text = text
        self.placeholder = placeholder
        let bottomView = BaseView(color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1))
        addSubview(bottomView)
        bottomView.snp.makeConstraints {
            $0.top.equalTo(snp.bottom)
            $0.left.equalTo(snp.left)
            $0.right.equalTo(snp.right)
            $0.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
