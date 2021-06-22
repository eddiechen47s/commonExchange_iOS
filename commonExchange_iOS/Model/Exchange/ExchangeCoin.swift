//
//  ExchangeDetail.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/21.
//

import Foundation

struct ExchangeCoin: Codable {
    let coinname: String
}

struct ExchangeDetailList: Codable {
    let data: [ExchangeDetail]
}
struct ExchangeDetail: Codable {
    let symbol: String
    let price: Double
    let change: Double
    let count: Double
    let twd: Double
}
