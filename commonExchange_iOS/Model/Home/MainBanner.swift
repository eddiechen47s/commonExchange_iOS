//
//  MainBanner.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/28.
//

import Foundation

struct MainBannerList: Codable {
    let status: Int
    let data: [MainBanner]
}

struct MainBanner: Codable {
    let imgandroidpath: String
}
