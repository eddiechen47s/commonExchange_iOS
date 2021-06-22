//
//  InternalTransfer.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/27.
//

import Foundation

struct InternalTransferRecordData: Codable {
    let status: Int
    let data: InternalTransferRecord
    let errorCode: Int
}

struct InternalTransferRecord: Codable {
    let total: Int
    let currentPage: Int
    let pageSize: Int
    let list: [InternalTransferRecordList]
}

struct InternalTransferRecordList: Codable {
    let coinname: String
    let num: String
    let addtime: Double
    let address: String
    let type: Int
    let status: Int
}
