//
//  LogoutViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/27.
//

import Foundation

class LogoutViewModel {
    static let shared = LogoutViewModel()
    
    // MARK: - LogOutAPI
    func loginOutAPI(username: String, completion: @escaping (Bool) -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        guard let Url = URL(string: apiUrlPrefix+"/user/loginOut") else { return }
        
        //傳遞予 API 的參數
        // isMobile 恆為 true
        let postString = "username=\(username)"
        
        do {
            //建立 API 連線要求
            var request = URLRequest(url: Url)
            request.httpMethod = "POST"
            request.httpBody =  postString.data(using: String.Encoding.utf8)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            //傳送 request(with: request)，並非同步接收 Response
            let task = session.dataTask(with: request) { (data, request, error) in
                if let error = error {
                    print("Error to get data",error)
                } else {
                    //取得回傳值，並且解析
                    if let data = data {
                        do {
                            let json = try JSONDecoder().decode(Logout.self, from: data)
                            // 登出成功
                            if json.data.result == "SUCCESS" {
                                completion(true)
                            } else {
                                // 登出失敗
                                completion(false)
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            //非同步傳送 request，不等待 response，讓程式先繼續往下執行
            task.resume()
        }
        
    }
    
}
