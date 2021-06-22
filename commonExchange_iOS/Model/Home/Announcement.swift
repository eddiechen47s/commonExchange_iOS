//
//  Announcement.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/19.
//

import Foundation

// 系統公告
struct SystemAnnouncementList: Codable {
    let status: Int
    let data: AnnouncementModel
}

struct AnnouncementModel: Codable {
    let total: Double
    let currentPage: Double
    let pageSize: Double
    let list: [ListModel]
}

struct ListModel: Codable {
    let addtime: Double
    let title: String
    let contentCt: String?
}
