//
//  RecentOrder.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/4.
//  委託中 Model

import Foundation

struct RecentOrderList: Codable {
    let status: Int
    let data: AllOrderRecordDetail
    let errorCode: Int
}

struct RecentOrderDetail: Codable {
    let total: Int
    let currentPage: Int
    let pageSize: Int
    let list: [AllOrderRecord]
}

struct RecentOrder: Codable {
    let market: String //交易對
    let addtime: Int //時間戳記
    let deal: String //成交數量
    let num: String //掛單數量
    let twd: String //成交價
    let fee: String //手續費
    let type: Int //買賣類型
    let price: String // 成交均價/價格
    let id: Int
}
