//
//  WithdrawalOutSideViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/19.
//

import Foundation

// 外轉 API
class WithdrawalOutSideViewModel {
    func turnOut(param: String, completion: @escaping (Bool) -> Void) {
        APIManager.shared.handleFetchAPI(apiURL: APIPath.turnOut.value, param: param, completion: { data, response, error in
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(WithdrawalVerified.self, from: data)
                        if jsonData.status == 1 {
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
