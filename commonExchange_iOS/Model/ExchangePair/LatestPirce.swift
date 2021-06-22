//
//  LatestPirce.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/29.
//

import Foundation

struct LatestPirceList: Codable {
    let status: Int
    let data: LatestPirce
    let errorCode: Int
}

struct LatestPirce: Codable {
    let price: String
}
