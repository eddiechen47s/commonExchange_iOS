//
//  GoogleVerifiedViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/26.
//

import Foundation

class GoogleVerifiedViewModel {
    
    func saveGoogleKey(apiURL: String, param: String, completion: @escaping (String) -> Void) {
        APIManager.shared.handleFetchAPI(apiURL: apiURL, param: param, completion: { data, response, error in
            
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(SaveGoogleAuth.self, from: data)
                        let status = jsonData.data.result
                        print(status)
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
