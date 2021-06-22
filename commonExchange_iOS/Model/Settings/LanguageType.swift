//
//  LanguageType.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/17.
//

import Foundation

struct LanguageType {
    let zh_tw: String
}

enum Languages: String, CaseIterable {
    case zh_tw = "繁體中文"
}

enum Rates: String, CaseIterable {
    case usd = "TWD"
}

enum RecommendCode: String, CaseIterable {
    case code = "rx2r8al"
}
