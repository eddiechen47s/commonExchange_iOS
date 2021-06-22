//
//  KlineList.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/10.
//

import Foundation

struct KlineList: Codable {
    let status: Int
    let data: Klines
    let errorCode: Int
}

struct Klines: Codable {
    let t: [Double]
    let o: [String]
    let h: [String]
    let l: [String]
    let c: [String]
    let v: [String]
}
