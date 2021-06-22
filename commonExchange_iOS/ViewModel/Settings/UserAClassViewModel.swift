//
//  UserAClassViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/20.
//

import UIKit
import RxSwift
import RxCocoa

class UserAClassViewModel: APIClientPost {
    
    var model = [UserAClass]()
    var userDetails = PublishRelay<UserAClass>()
    
    func getTradeLogList(param: String, completion: @escaping (UserAClass) -> Void) {
        APIManager.shared.handleFetchAPI(apiURL: APIPath.conformTrueUser.value, param: param, completion: { data, response, error in
            print(apiUrlPrefix)

            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let js = try JSONSerialization.jsonObject(with: data, options: [])
                        print(js)
                        let jsonData = try JSONDecoder().decode(UserAClassList.self, from: data)
                        completion(jsonData.data)
                    } catch {
                        print(APIError.jsonConversionFailure)
                    }
                    
                }
            }
        })
    }

}
