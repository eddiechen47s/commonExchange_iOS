//
//  APIParam.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/27.
//

import Foundation

enum APIParam: String, CaseIterable {
    case allOrderRecord
    case allFinishRecord
    case allHistoryWithdrawal
    case allHistoryDeposit
    case allInternalInOut
    case username
    case recentOrder //訂單->委託中
    case transactionRecentOrder // 買賣->當前訂單
    case getArticleList
    
    var value: String {
        switch self {
        case .transactionRecentOrder:
            return "currentPage=1&pageSize=10&allOrSelf=1&listType=0"
        case .recentOrder:
            return "currentPage=1&pageSize=10&allOrSelf=1&listType=0"
        case .allOrderRecord:
            return "currentPage=1&pageSize=10&allOrSelf=1"
        case .allFinishRecord:
            return "currentPage=1&pageSize=10&allOrSelf=1&listType=1"
        case .allHistoryDeposit:
            return "currentPage=1&pageSize=10&type=1"
        case .allHistoryWithdrawal:
            return "currentPage=1&pageSize=10&type=2"
        case .allInternalInOut:
            return "currentPage=1&pageSize=10"
        case .username:
            return "username="
        case .getArticleList:
            return "currentPage=1&pageSize=10"
        }
    }
}
