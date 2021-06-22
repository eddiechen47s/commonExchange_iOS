//
//  LatestDeal.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/29.
//

import Foundation

struct LatestDealList: Codable {
    let status: Int
    let data: [LatestDeal]
}

struct LatestDeal: Codable {
    let addtime: Int
    let price: String
    let num: String
    let type: Int
}
