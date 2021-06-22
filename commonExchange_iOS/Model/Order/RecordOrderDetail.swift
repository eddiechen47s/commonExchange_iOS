//
//  RecordOrderDetail.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/2.
//

import Foundation

struct RecordOrderDetailList: Codable {
    let status: Int
    let data: [RecordOrderDetail]
    let errorCode: Int
}

struct RecordOrderDetail: Codable {
    let id: Int
    let addtime: Double
    let type: Int
    let price: String
    let num: String
    let feeBuy: String
    let feeSell: String
    let mun: String
}
