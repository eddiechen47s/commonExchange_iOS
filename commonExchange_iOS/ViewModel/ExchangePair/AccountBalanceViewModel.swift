//
//  AccountBalanceViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/30.
//

import Foundation

class AccountBalanceViewModel {
    
    func accountBalance(apiURL: String, param: String, completion: @escaping (Double) -> Void) {
        APIManager.shared.handleFetchAPI(apiURL: apiURL, param: param, completion: { data, response, error in
            print(apiURL)
            print(param)
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(AccountBalanceList.self, from: data)
                        print(jsonData.data.num)
                        completion(jsonData.data.num)
                    } catch {
                        print(APIError.jsonConversionFailure)
                        completion(0)
                    }
                    
                }
            }
        })
    }
    
}
