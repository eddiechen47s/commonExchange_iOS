//
//  ExchangePairTitle.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/29.
//

import UIKit
import RxSwift
import RxCocoa

class ExchangePairTitle {
    let userDidSelectedPair = BehaviorRelay<String>(value: "")
    
    func selectedTitle(title: String) {
        self.userDidSelectedPair.accept(title)
    }
}
