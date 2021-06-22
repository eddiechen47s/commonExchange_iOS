//
//  Withdrawal.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/4/26.
//

import Foundation

enum WithdrawalToast: String, CaseIterable {
    case title
    
    var text: String {
        switch self {
        case .title:
            return """
                * 會員等級數位資產單筆限額：
                   B Class：等值 490,000 TWD以下（約 15,000USD）
                   A Class：等值 500,000 TWD（約 16,600 USD）
                * 數位資產24小時提領限額：等值 5,000,000TWD以下（約 150,000 USD）
                * 若您提領數位資產的現值超過 500,000 TWD或是綜合評估風險過高，需進行人工審核，可能需耗時 1 個工作天。
                """
        default:
            break
        }
    }
}
