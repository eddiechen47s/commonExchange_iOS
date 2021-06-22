//
//  Logout.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/28.
//

import Foundation

struct Logout: Codable {
    let status: Int
    let data: LogoutData
}

struct LogoutData: Codable {
    let result: String
}
