//
//  Login.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/9.
//

import Foundation

struct UserLogin: Codable {
    let status: Int
    let data: UserLoginList
}

struct UserLoginList: Codable {
    let username: String
    let token: String
    let id: Int
}

