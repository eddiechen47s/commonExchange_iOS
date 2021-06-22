//
//  WebSocekt.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/25.
//

import Foundation

enum WSURL: String, CaseIterable {
    case mainTradingPair = "ws://192.168.1.114:8088/api/websocket/threeCoinPrice"
    case tradingMarketPair = "ws://192.168.1.114:8088/api/websocket/top5CoinVolume"
    case topFiveHeight = "ws://192.168.1.114:8088/api/websocket/top5HighPriced"
    case mostPoplurSearch = "ws://192.168.1.114:8088/api/websocket/top5HighGecko"
}
