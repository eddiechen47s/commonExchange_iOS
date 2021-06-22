//
//  TradingPairAPI.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/1.
//

import Foundation

enum TradingPairAPI: String, CaseIterable {
    case mainTradingPair
    case TradingMarket
    case IncreaseRanking
    case MostPoplurPairs

    var value: String {
        switch self {
        case .mainTradingPair:
//            return "https://www.ktrade.io/tapi/markets/threeCoinPriceForFirst"
            return apiUrlprefixRobot+"threeCoinPriceForFirst"
        case .TradingMarket:
            return apiUrlprefixRobot+"top5CoinVolume"
        case .IncreaseRanking:
            return apiUrlprefixRobot+"top5HighPriced"
        case .MostPoplurPairs:
            return apiUrlprefixRobot+"top5HighGecko"
        }
      
    }
}


enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}
