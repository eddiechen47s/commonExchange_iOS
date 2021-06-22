//
//  SettingViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/8.
//

import UIKit

enum SettingType: String, CaseIterable {
    case userIdentify = "身份驗證"
    case allHistory = "所有歷史紀錄"
    case verified = "安全驗證"
    case recommendCode = "分享推薦碼"
    case language = "語言"
    case rate = "匯率"
    case Facebook = "Facebook"
    case Telegram = "Telegram"
    case Twitter = "Twitter"
    case Line = "Line"
    case social = "社群"
    case officialWeb = "官方網站"
    case email = "客服信箱"
    
}

class SettingViewModel {
    
    var models = [Sections]()
    
    func configure(on vc: UIViewController) {
        
        self.models.append(Sections(title: "", options: [
            SettingOption(title: "", icon: UIImage(named: "Profile_icon"), iconBackgroundColor: nil, handle: nil)
        ]))
        
        self.models.append(Sections(title: "帳戶", options: [
            SettingOption(title: SettingType.userIdentify.rawValue, icon: UIImage(named: "setting_icon"), iconBackgroundColor: nil, handle: {
                
            }),
            SettingOption(title: SettingType.recommendCode.rawValue, icon: UIImage(named: "share_icon"), iconBackgroundColor: nil, handle: {
                
            }),
            SettingOption(title: SettingType.allHistory.rawValue, icon: UIImage(named: "All historicalrecords_icon"), iconBackgroundColor: nil, handle: {
            }),
            SettingOption(title: SettingType.verified.rawValue, icon: UIImage(named: "verified_icon"), iconBackgroundColor: nil, handle: nil)
        ]))
        
        self.models.append(Sections(title: "設置", options: [
            SettingOption(title: SettingType.language.rawValue, icon: UIImage(named: "language_icon"), iconBackgroundColor: nil, handle: {
                
            }),
            SettingOption(title: SettingType.rate.rawValue, icon: UIImage(named: "rate_icon"), iconBackgroundColor: nil, handle: {
                
            })
        ]))
        
        self.models.append(Sections(title: "聯絡", options: [
            SettingOption(title: "社群", icon: UIImage(named: "social_icon"), iconBackgroundColor: nil, handle: {
            
            }),
            SettingOption(title: "官方網站", icon: UIImage(named: "web_icon"), iconBackgroundColor: nil, handle: {
            
            }),
            SettingOption(title: "客服信箱", icon: UIImage(named: "mail_icon"), iconBackgroundColor: nil, handle: {
            
            })

        ]))

    }
}
