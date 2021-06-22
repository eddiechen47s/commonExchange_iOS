//
//  RecordOrderDetailViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/12.
//

import Foundation

class RecordOrderDetailViewModel {

    func getTurnInOutList(tradeId:Int, completion: @escaping ([RecordOrderDetail]) -> Void) {
        guard let token = userDefaults.string(forKey: "UserToken") else {
            return
        }
        APIManager.shared.handleFetchAPI(apiURL: APIPath.getMyTradeLogList.value, param: "tradeId=\(tradeId)&token=\(token)", completion: { data, response, error in
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(RecordOrderDetailList.self, from: data)
                        print(jsonData.data)
                        completion(jsonData.data)
                    } catch {
                        print(APIError.jsonConversionFailure)
                    }
                }
            }
        })
    }
}
