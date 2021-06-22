//
//  DepositRuleText.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/4/25.
//

import Foundation

enum DepositRuleText: String, CaseIterable {
    case BTC
    case ETH
    case KT
    case KCOIN
    case NULS
    case DASH
    case USDT
    case XMR
    case XRP
    case SBT
    case SOSR
    case HLC
    case FTO
    
    var text: String {
        switch self {
        case .BTC:
            return """
                * 禁止向 BTC 地址存入除 BTC 以外的資產，任何存入 BTC 地址的非 BTC 資產將不可找回。
                * 您存入至上述地址後，需要整個網路節點的確認，1 次網路確認後入帳，2 次網路確認後可提領。
                """
        case .ETH:
            return """
                * 禁止向 ETH 地址存入除 ETH 以外的資產，任何存入 ETH 地址的非 ETH 資產將不可找回。
                * 您存入至上述地址後，需要整個網路節點的確認，所需時間為 12 次網路確認後入帳，12次網路確認後可提領。
                """
        case .KT:
            return """
                * 禁止向 KT 地址存入除 KT 以外的資產，任何存入 KT 地址的非 KT 資產將不可找回。
                * 您存入至上述地址後，需要整個網路節點的確認，所需時間為 12 次網路確認後入帳，12次網路確認後可提領。
                """
        case .KCOIN:
            return """
                * 禁止向 KCOIN 地址存入除 KCOIN 以外的資產，任何存入 KCOIN 地址的非 KCOIN 資產將不可找回。
                * 您存入至上述地址後，需要整個網路節點的確認，所需時間為 12 次網路確認後入帳，12 次網路確認後可提領。
                """
        case .NULS:
            return """
                * 禁止向 NULS 地址存入除 NULS 以外的資產，任何存入 NULS 地址的非 NULS 資產將不可找回。
                * 您存入至上述地址後，需要整個網路節點的確認，所需時間為 30 次網路確認後入帳，60次網路確認後可提領。
                """
        case .USDT:
            return """
                * 禁止向 USDT 地址存入除 USDT 以外的資產，任何存入 USDT地址的非 USDT資產將不可找回。
                * OMNI USDT 存入地址為數字「3」或「1」開頭，需要3個區塊確認。
                * ERC20 USDT 存入地址為「0x」開頭，需要12個區塊確認。
                * KTrade同時支援 ERC20 及 OMNI 兩種協定的USDT，兩者使用地址格式不同，存入前請確認使用正確的地址。
                """
        case .DASH:
            return """
                * 禁止向 DASH 地址存入除 DASH 以外的資產，任何存入 DASH 地址的非 DASH 資產將不可找回。
                * 您存入至上述地址後，需要整個網路節點的確認，所需時間為 12 次網路確認後入帳，25次網路確認後可提領。
                """
        case .XMR:
            return """
                * 禁止向 XMR 地址存入除 XMR 以外的資產，任何存入 XMR 地址的非 XMR 資產將不可找回。
                * 將 XMR 存入您的KTrade帳戶時，請務必一起輸入 PaymentID 以及地址資訊，否則資產將不可找回。
                * 您存入至上述地址後，需要整個網路節點的確認，所需時間為 12 次網路確認後入帳。
                """
        case .XRP:
            return """
                * 禁止向 XRP 地址存入除 XRP 以外的資產，任何存入 XRP 地址的非 XRP 資產將不可找回。
                * 將 XRP 存入您的KTrade帳戶時，請務必一起輸入 Tag 以及地址資訊，否則資產將不可找回。
                * 您存入至上述地址後，需要整個網路節點的確認，所需時間為 1 次網路確認後入帳。
                """
        case .SBT:
            return """
                * 禁止向 SBT 地址存入除 SBT 以外的資產，任何存入 SBT 地址的非 SBT 資產將不可找回。
                * 您存入至上述地址後，需要整個網路節點的確認，所需時間為 12 次網路確認後入帳，12次網路確認後可提領。
                """
        case .SOSR:
            return """
                * 禁止向 SOSR 地址存入除 SOSR 以外的資產，任何存入 SOSR 地址的非 SOSR 資產將不可找回。
                * 您存入至上述地址後，需要整個網路節點的確認，所需時間為 12 次網路確認後入帳，12次網路確認後可提領。
                """
        case .HLC:
            return """
                * 禁止向 HLC 地址存入除 HLC 以外的資產，任何存入 HLC 地址的非 HLC 資產將不可找回。
                * 您存入至上述地址後，需要整個網路節點的確認，所需時間為 12 次網路確認後入帳，12次網路確認後可提領。
                """
        case .FTO:
            return """
                * 禁止向 FTO 地址存入除 FTO 以外的資產，任何存入 FTO 地址的非 FTO 資產將不可找回。
                * 您存入至上述地址後，需要整個網路節點的確認，實際入帳時間依主網交易驗證時間為主。
                """
        }
    }
}
