//
//  SMSSendPhoneViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/7.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class SMSSendPhoneViewModel {
    var userSmsResult = PublishRelay<Bool>()
    
    func sendSMS(parameters: [String: String]) {
        Alamofire.request(apiUrlPrefix+APIPath.sendPhoneCode.value, method: .post, parameters: parameters, encoding: URLEncoding()).response { response in
            if let err = response.error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = response.data {
                    do {
                        let jsonData = try JSONDecoder().decode(SMSSendPhoneList.self, from: data)
                        print(jsonData.data.result)
                        if jsonData.data.result == "SUCCESS" {
                            self.userSmsResult.accept(true)
                        } else {
                            self.userSmsResult.accept(false)
                        }
                    } catch {
                        print(APIError.jsonConversionFailure)
                        self.userSmsResult.accept(false)
                    }
                }
            }
        }
    }
}
