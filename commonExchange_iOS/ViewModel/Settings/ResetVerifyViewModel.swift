//
//  ResetVerifyViewModel.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/4/25.
//

import UIKit
import RxSwift
import RxCocoa

class ResetVerifyViewModel {
    var isResetStatus = PublishRelay<Bool>()
    
    func loadAPI() {
        isResetStatus.accept(true)
    }
    
    func resetGoogleKey(apiURL: String, param: String, completion: @escaping (String) -> Void) {
        APIManager.shared.handleFetchAPI(apiURL: apiURL, param: param, completion: { data, response, error in
            
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(SaveGoogleAuth.self, from: data)
                        completion(jsonData.data.result)
                    } catch {
                        print(APIError.jsonConversionFailure)
                        completion("Failed")
                    }
                    
                }
            }
        })
    }
    
    func safetySettingSendEMail(apiURL: String, param: String, completion: @escaping (String) -> Void) {
        APIManager.shared.handleFetchAPI(apiURL: apiURL, param: param, completion: { data, response, error in
            
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(SaveGoogleAuth.self, from: data)
                        completion(jsonData.data.result)
                    } catch {
                        print(APIError.jsonConversionFailure)
                        completion("Failed")
                    }
                    
                }
            }
        })
    }
    
}
