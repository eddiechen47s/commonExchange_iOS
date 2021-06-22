//
//  Deposit.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/4/22.
//

import Foundation

struct Deposit: Codable {
    let status: Int
    let data: AddressList
}

struct AddressList: Codable {
    let address: [ChainDetail]
}

struct ChainDetail: Codable {
    let chain: String
    let address: String
    let payment_id: String?
}
