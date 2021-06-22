//
//  TradeSell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/29.
//

import Foundation

struct TradeSellList: Codable {
    let status: Int
    let data: [TradeSell]
}

struct TradeSell: Codable {
    let amount: String
    let price: String
}
