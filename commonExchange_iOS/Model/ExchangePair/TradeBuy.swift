//
//  TradeBuy.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/29.
//

import Foundation

struct TradeBuyList: Codable {
    let status: Int
    let data: [TradeBuy]
}

struct TradeBuy: Codable {
    let amount: String
    let price: String
}
