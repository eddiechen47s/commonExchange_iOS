//
//  TradingPair.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/16.
//

import Foundation

struct TradingPair {
    let mainCoin: String
    let minorCoin: String
    let lastesPrice: String
    let percentPrice: String
    let usdPrice: String
    let dealAmount: String
}

struct TradingPairList: Codable {
    let status: Int
    let data: [TradingPairs]
    let errorCode: Int
}

struct TradingPairs: Codable {
    let base: String
    let target: String
    let last: Double
    let lastNt: Double
    let bidAskSpreadPercentage: Double
    let volume: Double
}

