//
//  WithdrawalRecord.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/27.
//

import Foundation

struct WithdrawalRecordData: Codable {
    let status: Int
    let data: WithdrawalRecord
    let errorCode: Int
}

struct WithdrawalRecord: Codable {
    let total: Int
    let currentPage: Int
    let pageSize: Int
    let list: [WithdrawalRecordList]
}

struct WithdrawalRecordList: Codable {
    let coinname: String
    let num: String
    let addtime: Double
    let address: String
    let fee: String
    let status: Int
}
