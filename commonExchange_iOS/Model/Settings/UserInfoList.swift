//
//  UserInfoList.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/1.
//

import Foundation

struct UserInfoList: Codable {
    let status: Int
    let data: UserBClass
    let errorCode: Int
}

struct UserBClass: Codable {
    let email: String
    let moble: String
    let invit: String
    let ga: String
    let level: String
    let idcardauth: Int
}
