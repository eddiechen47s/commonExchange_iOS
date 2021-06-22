//
//  ForgetPwdViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/7.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class ForgetPwdViewModel {
    
    var verifyResult = PublishRelay<Bool>()
//    var verifyEmail = BehaviorRelay<String>(value: "")
//    
//    func saveEmail(email: String) {
//        self.verifyEmail.accept(email)
//        print(self.verifyEmail.value)
//    }
    
    func sendBindEMailGoogle(email: String) {
        let param = [
            "email": email,
            "type": "send_password",
            "language": "cn",
            "isMobile": "TRUE"
        ]
        
        Alamofire.request(apiUrlPrefix+APIPath.sendBindEMailGoogle.value, method: .post, parameters: param, encoding: URLEncoding()).response { response in
            if let err = response.error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = response.data {
                    do {
                        let jsonData = try JSONDecoder().decode(ForgetPwdVerifyList.self, from: data)
                        if jsonData.data.result == "SUCCESS" {
                            self.verifyResult.accept(true)
                        } else {
                            self.verifyResult.accept(false)
                        }
                    } catch {
                        print(APIError.jsonConversionFailure)
                        self.verifyResult.accept(false)
                    }
                }
            }
        }
    }
    
}
