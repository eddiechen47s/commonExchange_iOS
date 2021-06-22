//
//  MainTradingPair.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/24.
//

import Foundation

struct MainTradingPairList: Codable {
    let status: Int
    let data: MainTradingPair
    let errorCode: Int
}

struct MainTradingPair: Codable {
    let left: MainTradingPairCoin
    let center: MainTradingPairCoin
    let right: MainTradingPairCoin
}

struct MainTradingPairCoin: Codable {
    let twd: Double
    let usd: Double
    let usd_24h_vol: Double
    let usd_24h_change: Double
    let base: String
    let target: String
}

enum MainTradingPairTitle: String, CaseIterable {
    case btc = "ETH / USDT"
    case eth = "Tether"
    case tether = "BTC / USDT"
}
