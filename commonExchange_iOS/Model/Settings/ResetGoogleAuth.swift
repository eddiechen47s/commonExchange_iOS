//
//  ResetGoogleAuth.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/26.
//

import Foundation

struct ResetGoogleAuth: Codable {
    let status: Int
    let data: SaveGA
    let errorCode: Int
}

struct ResetGA: Codable {
    let result: String
}
