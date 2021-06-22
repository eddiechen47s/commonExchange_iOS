//
//  OderDetail.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/2.
//

import Foundation

struct OderDetailList: Codable {
    let status: Int
    let data: [OderDetail]
    let errorCode: Int
}

struct OderDetail: Codable {
    let price: String
    let num: String
    let feeBuy: String
    let feeSell: String
    let addtime: Int
}
