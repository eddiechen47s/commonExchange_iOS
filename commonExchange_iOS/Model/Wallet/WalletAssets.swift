//
//  WalletAssets.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/17.
//

import Foundation

struct WalletAssetsList: Codable {
    let status: Int
    let errorCode: Int
    let data: WalletAssetsData
}

struct WalletAssetsData: Codable {
    let data: [WalletAssets]
    let twdSum: String
    let cnySum: String
}

struct WalletAssets: Codable {
    let amount:String
    let num: String
    let coinname: String
    let numd: String
    let twd: String
}
