//
//  RegisterViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/7.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class RegisterViewModel {
    var userRegister = PublishRelay<Bool>()

    func register(parameters: [String: String]) {
        print(parameters)
        Alamofire.request(apiUrlPrefix+APIPath.register.value, method: .post, parameters: parameters, encoding: URLEncoding()).response { response in
            if let err = response.error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = response.data {
                    do {
                        let jsonData = try JSONDecoder().decode(RegisterList.self, from: data)
                        if jsonData.data.status == 1 {
                            self.userRegister.accept(true)
                        } else {
                            self.userRegister.accept(false)
                        }
                    } catch {
                        print(APIError.jsonConversionFailure)
                        self.userRegister.accept(false)
                    }
                }
            }
        }
    }
    
}
