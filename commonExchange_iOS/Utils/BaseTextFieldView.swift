//
//  BaseTextFieldBorderView.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/12.
//

import UIKit

class BaseTextFieldView: UIView, UITextFieldDelegate {
    
    init(textField: UITextField, placeholder: String) {
        super.init(frame: .zero)
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        
        addSubview(textField)
        textField.text = ""
        textField.font = .systemFont(ofSize: 18, weight: .bold)
        textField.keyboardType = .decimalPad
        textField.placeholder = placeholder
        textField.textAlignment = .right
        textField.textColor = #colorLiteral(red: 0.2776432037, green: 0.6590948701, blue: 0.4378901124, alpha: 1)
        textField.backgroundColor = .white
        textField.delegate = self
        
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right).offset(-10)
            make.height.equalTo(snp.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
