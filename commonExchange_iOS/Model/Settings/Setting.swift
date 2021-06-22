//
//  Setting.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/8.
//

import UIKit

struct Sections {
    let title: String
    let options: [SettingOption]
}

struct SettingOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor?
    let handle: (() -> Void)?
}

struct SettingDetail {
    let title: String
}
