//
//  WithdrawalLimitViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/30.
//

import Foundation

class WithdrawalLimitViewModel {
    
    var model: WithdrawalLimit?
    
    func getCoinByName(apiURL: String, param: String, completion: @escaping (WithdrawalLimit) -> Void) {
        
        APIManager.shared.handleFetchAPI(apiURL: apiURL, param: param, completion: { data, response, error in
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(WithdrawalLimitList.self, from: data)
                        self.model = jsonData.data
//                        self.model.append(jsonData.data)
                        completion(jsonData.data)
                    } catch {
                        print(APIError.jsonConversionFailure)
                    }
                    
                }
            }
        })
    }
    
}
