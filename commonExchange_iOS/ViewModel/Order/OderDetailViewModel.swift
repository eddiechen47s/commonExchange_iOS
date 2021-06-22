//
//  OderDetailViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/2.
//

import Foundation

class OderDetailViewModel {
    
    var model = [OderDetail]()
    
    func getMyTradeLogList(tradeId:Int, completion: @escaping ([OderDetail]) -> Void) {
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
                        let jsonData = try JSONDecoder().decode(OderDetailList.self, from: data)
                        self.model = jsonData.data
                        completion(self.model)
                    } catch {
                        print(APIError.jsonConversionFailure)
                        completion([])
                    }
                }
            }
        })
    }
}
