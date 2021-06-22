//
//  BindingGoogleViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/26.
//

import Foundation

class BindingGoogleViewModel {
        
    func getGoogleKey(apiURL: String, param: String, completion: @escaping (AuthDetail) -> Void) {
        APIManager.shared.handleFetchAPI(apiURL: apiURL, param: param, completion: { data, response, error in
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(GoogleAuth.self, from: data)
                        print(jsonData)
                        completion(jsonData.data)
                    } catch {
                        print(APIError.jsonConversionFailure)
                    }
                    
                }
            }
        })
    }
    
}
