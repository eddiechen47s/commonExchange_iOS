//
//  WalletDetailPairs.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/3.
//

import Foundation

struct WalletDetailPairsList: Codable {
    let status: Int
    let data: [WalletDetailPairs]
    let errorCode: Int
}

struct WalletDetailPairs: Codable {
    let symbol: String
    let count: Double
    let price: Double
    let change: Double
}
