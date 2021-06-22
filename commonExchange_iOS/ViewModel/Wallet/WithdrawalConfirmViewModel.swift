//
//  WithdrawalConfirmViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/30.
//

import Foundation
//ktrade.dev@gmail.com
class WithdrawalConfirmViewModel {
    
    func checkCanWithdraw(apiURL: String, param: String, completion: @escaping (Bool) -> Void) {
        
        APIManager.shared.handleFetchAPI(apiURL: apiURL, param: param, completion: { data, response, error in
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(WithdrawalConfirmList.self, from: data)
                        if jsonData.data.result {
                            completion(true)
                        } else {
                            completion(false)
                        }
                    } catch {
                        print(APIError.jsonConversionFailure)
                        completion(false)
                    }
                }
            }
        })
    }
    
}
