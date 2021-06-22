//
//  APIPath.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/27.
//

import Foundation

enum APIPath: String, CaseIterable {
    case login
    case register
    case registSendEmail // 註冊->信箱驗證碼
    case search // 搜尋
    case banner
    case getTurnInOutList
    case getMyTradeListByStatus
    case getTradeLogList // 交易對 -> 最新成交
    case getFiveTradeList // 交易對 -> 掛單簿(賣)
    case getMarketNewestPrice // 掛單簿 -> 左中的最新價格
    case getUserCoinNum //買賣頁面 -> 餘額
    case getCoinByName // 錢包提領頁面(手續費＆最小數量)
    case checkCanWithdraw // 提領頁面 -> 提交鍵
    case getUserInfo // Setting B Class API
    case getMyTradeLogList //訂單流水 API
    case getChangeAndPriceList // 錢包幣種點擊->下面的 cell & 交易頁面 API
    case transfer // 錢包->提領->內轉
    case turnOut // 錢包->提領->外轉
    case tradeTobuyOrSell //買賣頁面 -> 提交鍵
    case sendPhoneCode // 註冊->簡訊驗證碼
    case sendBindEMailGoogle //忘記密碼
    case updateForgetPwd //重置密碼
    case historyForAppKline // Kline API
    case getMyAddrByCoinNameNew
    case conformTrueUserToImg
    case conformTrueUser
    case getArticleList
    case getInternalInOutList // 紀錄 -> 內部轉賬記錄
       
    var value: String {
        switch self {
        case .login:
            return "user/login?"
        case .register:
            return "user/register"
        case .registSendEmail:
            return "user/registSendEmail?"
        case .search:
            return "getAllOfChangeAndPriceList"
        case .banner:
            return "common/getBannerList"
        case .getTurnInOutList:
            return "turnIn/getTurnInOutList?"
        case .getMyTradeListByStatus:
            return "trade/getMyTradeListByStatus?"
        case .getTradeLogList:
            return "fistTradingView/getTradeLogList"
        case .getFiveTradeList:
            return "fistTradingView/getFiveTradeList?"
        case .getMarketNewestPrice:
            return "fistTradingView/getMarketNewestPrice?"
        case .getUserCoinNum:
            return "transfer/getUserCoinNum"
        case .getCoinByName:
            return "coin/getCoinByName?"
        case .checkCanWithdraw:
            return "turnOut/checkCanWithdraw?"
        case .getUserInfo:
            return "user/getUserInfo?"
        case .getMyTradeLogList:
            return "tradeLog/getMyTradeLogList?"
        case .getChangeAndPriceList:
            return "getChangeAndPriceList?"
        case .turnOut:
            return "turnOut/turnOut"
        case .transfer:
            return "transfer/transfer?"
        case .tradeTobuyOrSell:
            return "trade/tradeTobuyOrSell?"
        case .sendPhoneCode:
            return "user/sendPhoneCode"
        case .sendBindEMailGoogle:
            return "common/sendBindEMailGoogle?"
        case .updateForgetPwd:
            return "user/updateForgetPwd?"
        case .historyForAppKline:
            return "RefreshKLineData/historyForAppKline?"
        case .getMyAddrByCoinNameNew:
            return "turnIn/getMyAddrByCoinNameNew?"
        case .conformTrueUserToImg:
            return "user/conformTrueUserToImg"
        case .conformTrueUser:
            return "user/conformTrueUser?"
        case .getArticleList:
            return "/article/getArticleList?"
        case .getInternalInOutList:
            return "turnIn/getInternalInOutList"
        }
    }
}
