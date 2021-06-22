//
//  BaseView.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/28.
//

import UIKit

class BaseView: UIView {
    
    init(color: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
