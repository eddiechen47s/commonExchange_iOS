//
//  SaveGoogleAuth.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/26.
//

import Foundation

struct SaveGoogleAuth: Codable {
    let status: Int
    let data: SaveGA
    let errorCode: Int
}

struct SaveGA: Codable {
    let result: String
}
