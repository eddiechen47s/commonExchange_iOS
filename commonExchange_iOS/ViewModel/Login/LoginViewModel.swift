//
//  LoginViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/28.
//

import Foundation

class LoginViewModel {
    static let shared = LoginViewModel()
    var model: UserLoginList?
    
    // MARK: - Login
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {

        APIManager.shared.handleFetchAPI(apiURL: APIPath.login.value, param: "username=\(email)&password=\(password)&isMobile=true", completion: { data, response, error in
            print(APIPath.login.value)
            print("username=\(email)&password=\(password)&isMobile=true")
            if let err = error {
                //發生錯誤, google
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: [])
//                        print(json)
                        let jsonData = try JSONDecoder().decode(UserLogin.self, from: data)
                        if jsonData.status == 1 {
                            // = 1，表示使用者成功登入
//                            isUserLogin = true
                            userDefaults.set(true, forKey: "isUserLogin")

                            completion(true)
//                                userToken = userDefaults.string(forKey: "UserToken")!
                            userDefaults.set( jsonData.data.username, forKey: "UserName")
                            userDefaults.set(jsonData.data.token, forKey: "UserToken")
                        }
                        
                        print("\n\n----------------------------------------------------")
                        print("UserToken:", userDefaults.string(forKey: "UserToken")!)
                        print("UserName:", userDefaults.string(forKey: "UserName")!)
                        print("----------------------------------------------------\n\n")
                        
                    } catch {
                        print(error)
                        completion(false)
                    }
                }
            }
        })
    }

}
