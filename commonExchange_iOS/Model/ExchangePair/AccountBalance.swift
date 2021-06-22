//
//  AccountBalance.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/30.
//

import Foundation

struct AccountBalanceList: Codable {
    let status: Int
    let data: AccountBalance
    let errorCode: Int
}

struct AccountBalance: Codable {
    let num: Double
}

