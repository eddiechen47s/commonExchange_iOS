//
//  ForgetPwdVerify.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/7.
//

import Foundation

struct ForgetPwdVerifyList: Codable {
    let status: Int
    let data: ForgetPwdVerify
    let errorCode: Int
}

struct ForgetPwdVerify: Codable {
    let result: String
}
