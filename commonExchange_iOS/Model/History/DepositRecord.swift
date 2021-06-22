//
//  DepositRecord.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/27.
//

import Foundation

struct DepositRecordData: Codable {
    let status: Int
    let data: DepositRecord
    let errorCode: Int
}

struct DepositRecord: Codable {
    let total: Int
    let currentPage: Int
    let pageSize: Int
    let list: [DepositRecordList]
}

struct DepositRecordList: Codable {
    let coinname: String
    let num: String
    let addtime: Double
    let address: String
}
