//
//  BuySellViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/6.
//

import Foundation
import RxSwift
import RxCocoa

// 買賣提交鍵 vm
class BuySellViewModel {
    
    var buySellResult = BehaviorRelay<String>(value: "")
    
    func tradeTobuyOrSell(param: String, completion: @escaping (Bool) -> Void) {

        APIManager.shared.handleFetchAPI(apiURL: APIPath.tradeTobuyOrSell.value, param: param, completion: { data, response, error in
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let js = try JSONSerialization.jsonObject(with: data, options: [])
                        print(js)
                        let jsonData = try JSONDecoder().decode(BuySellList.self, from: data)
                        if jsonData.data.result == "SUCCESS" {
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
