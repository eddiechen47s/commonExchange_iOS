//
//  CommunityType.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/18.
//

import Foundation

enum CommunityType: String, CaseIterable {
    case fb
    case telegram
    case twitter
    case line
    case officialWeb
    case ig
    case med
    
    var url: String {
        switch self {
        case .fb:
            return "https://www.facebook.com/StatecraftTech/"
        case .telegram:
            return "https://t.me/ktradetaiwan"
        case .twitter:
            return "https://twitter.com/StatecraftTech"
        case .line:
            return "https://page.line.me/statecraft?openQrModal=true"
        case .officialWeb:
            return "https://www.ktrade-official.com/"
        case .ig:
            return "https://t.me/ktradetaiwan"
        case .med:
            return "https://medium.com/ktrade"
        }
    }
}
