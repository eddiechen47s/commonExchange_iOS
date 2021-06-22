//
//  ExchangePair.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/9.
//

import Foundation

enum ExchangePairPageType: String, CaseIterable {
    case kLine = "K 線圖"
    case lastesResult = "最新成交"
    case transaction = "買入 / 賣出"
}
