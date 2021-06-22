//
//  ResetPwd.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/7.
//

import Foundation

struct ResetPwdList: Codable {
    let status: Int
    let data: ResetPwd
    let errorCode: Int
}

struct ResetPwd: Codable {
    let result: String
}
