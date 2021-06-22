//
//  LatestPirceViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/29.
//

import Foundation

// 掛單簿-最新價格
class LatestPirceViewModel {
    
    func latestPrice(apiURL: String, param: String, completion: @escaping (String) -> Void) {
        APIManager.shared.handleFetchAPI(apiURL: apiURL, param: param, completion: { data, response, error in
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(LatestPirceList.self, from: data)
                        completion(jsonData.data.price)
                    } catch {
                        print(APIError.jsonConversionFailure)
                        completion("")
                    }
                    
                }
            }
        })
    }
    
}

