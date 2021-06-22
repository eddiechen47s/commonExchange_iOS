//
//  SearchPairs.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/9.
//

import Foundation

struct SearchPairs: Codable {
    let status: Int
    let data: [SearchListData]
    let errorCode: Int
}

struct SearchListData: Codable {
    let symbol: String
}
