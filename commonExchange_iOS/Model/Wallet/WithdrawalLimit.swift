//
//  WithdrawalLimit.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/30.
//

import Foundation

struct WithdrawalLimitList: Codable {
    let status: Int
    let data: WithdrawalLimit
    let errorCode: Int
}

struct WithdrawalLimit: Codable {
    let zc_fee: String //提領最小手續費
    let zc_min: String //提領最小數量
}
