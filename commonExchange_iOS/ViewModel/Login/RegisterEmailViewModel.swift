//
//  RegiserEmailViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/7.
//

import Foundation
import RxSwift
import RxCocoa

class RegiserEmailViewModel {
    var userEmailResult = PublishRelay<Bool>()
    
    func registSendEmail(email: String) {
        let param = "username=\(email)"
        APIManager.shared.handleFetchAPI(apiURL: APIPath.registSendEmail.value, param: param, completion: { data, response, error in
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(RegiserEmail.self, from: data)
                        if jsonData.status == 1 {
                            self.userEmailResult.accept(true)
                        } else {
                            self.userEmailResult.accept(false)
                        }
                    } catch {
                        print(APIError.jsonConversionFailure)
                        self.userEmailResult.accept(false)
                    }
                }
            }
        })
    }
    
    
}
