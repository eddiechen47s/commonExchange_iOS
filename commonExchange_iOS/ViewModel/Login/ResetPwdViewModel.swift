//
//  ResetPwdViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/7.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class ResetPwdViewModel {
    var resetResult = PublishRelay<Bool>()
    
    func updateForgetPwd(email: String, password: String, confirmPwd: String, validate: String) {
        let param = [
            "email": email,
            "password": password,
            "confirmPwd": confirmPwd,
            "validate": validate
        ]
        print(email)
        print(password)
        print(confirmPwd)
        print(validate)
        Alamofire.request(apiUrlPrefix+APIPath.updateForgetPwd.value, method: .post, parameters: param, encoding: URLEncoding()).response { response in
            if let err = response.error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = response.data {
                    do {
                        let jsonData = try JSONDecoder().decode(ResetPwdList.self, from: data)
                        if jsonData.data.result == "SUCCESS" {
                            self.resetResult.accept(true)
                        } else {
                            self.resetResult.accept(false)
                        }
                    } catch {
                        print(APIError.jsonConversionFailure)
                        self.resetResult.accept(false)
                    }
                }
            }
        }
    }
}
