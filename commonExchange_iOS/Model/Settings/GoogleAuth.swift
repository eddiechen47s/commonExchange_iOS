//
//  GoogleAuth.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/26.
//

import Foundation

struct GoogleAuth: Codable {
    let status: Int
    let data: AuthDetail
    let errorCode: Int
}

struct AuthDetail: Codable {
    let qrcode: String
    let title: String
    let key: String
}
