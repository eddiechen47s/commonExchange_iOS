//
//  UploadIdentyImg.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/17.
//

import Foundation

struct TrueUserToImg: Codable {
    let status: Int
    let data: imgNameDetail
    let errorCode: Int
}

struct imgNameDetail: Codable {
    let imgName: String
}
