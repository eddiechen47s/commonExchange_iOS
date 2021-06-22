//
//  UserBClassViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/1.
//

import Foundation
import RxSwift
import RxCocoa

class UserInfoViewModel {
    var model = [String]()
    var models: [String: String] = [:]
    
    var inviteCode = BehaviorRelay<String>(value: "")
    var userLoginStatus = PublishRelay<Bool>() // Setting 判斷 user 是否登入
    var userGAStatus = PublishRelay<Bool>() // 判斷 user 是否為 A Class && Idauth = 3
    var userIdcardauth = BehaviorRelay<Int>(value: 0)
    
    func getUserInfo(param: String, completion: @escaping ([String]) -> Void) {
        let apiPath = APIPath.getUserInfo.value
        self.model.removeAll()
        APIManager.shared.handleFetchAPI(apiURL: apiPath, param: param, completion: { data, response, error in
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(UserInfoList.self, from: data)
                        if jsonData.status == 1 {
                            self.userLoginStatus.accept(true)
                            userDefaults.set(true, forKey: "isUserLogin")
                        }
                        if jsonData.data.email.count > 0 && jsonData.data.moble.count > 0 {
                            self.model.append(jsonData.data.email)
                            self.model.append(jsonData.data.moble)
                            self.model.append(jsonData.data.level)
                            self.model.append(jsonData.data.idcardauth.toString())
                            self.userIdcardauth.accept(jsonData.data.idcardauth)
                            if jsonData.data.ga != "" {
                                self.userGAStatus.accept(true)
                            } else {
                                self.userGAStatus.accept(false)
                            }
                            
                        }
                        self.inviteCode.accept(jsonData.data.invit)
                        completion(self.model)
                    } catch {
                        print(APIError.jsonConversionFailure)
                        completion([])
                        self.model.removeAll()
                        self.userLoginStatus.accept(false)
                        self.inviteCode.accept("")
                        self.userGAStatus.accept(false)
                    }
                }
            }
        })
    }
    
}
