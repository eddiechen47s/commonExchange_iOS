//
//  LatestResultViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/29.
//

import Foundation

// 最新成交
class LatestDealViewModel {
    var model = [LatestDeal]()
    
    func latestDeal(apiURL: String, param: String, completion: @escaping () -> Void) {
        APIManager.shared.handleFetchAPI(apiURL: apiURL, param: param, completion: { data, response, error in
            
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(LatestDealList.self, from: data)
                        self.model = jsonData.data
                        completion()
                    } catch {
                        print(APIError.jsonConversionFailure)
                        completion()
                    }
                    
                }
            }
        })
    }
    
}
