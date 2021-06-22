//
//  SMSSendPhone.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/7.
//

import Foundation

struct SMSSendPhoneList: Codable {
    let status: Int
    let data: SMSSendPhone
    let errorCode: Int
}

struct SMSSendPhone: Codable {
    let result: String
}
