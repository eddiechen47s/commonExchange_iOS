//
//  Exchange.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/21.
//

import Foundation

struct ExchangeTitle: Codable {
    let status: Int
    let data: [String]
    let errorCode: Int
}

