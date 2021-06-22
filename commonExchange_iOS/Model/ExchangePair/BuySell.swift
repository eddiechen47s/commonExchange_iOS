//
//  BuySell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/6.
//

import Foundation

struct BuySellList: Codable {
    let status: Int
    let data: BuySell
    let errorCode: Int
}

struct BuySell: Codable {
    let result: String
}
