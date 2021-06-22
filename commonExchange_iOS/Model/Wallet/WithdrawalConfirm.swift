//
//  WithdrawalConfirm.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/30.
//

import Foundation

struct WithdrawalConfirmList: Codable {
    let status: Int
    let data: WithdrawalConfirm
    let errorCode: Int
}

struct WithdrawalConfirm: Codable {
    let result: Bool //提領狀態
}
