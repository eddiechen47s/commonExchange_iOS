//
//  WalletAssetsViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/17.
//

import UIKit
import RxSwift
import RxCocoa

class WalletAssetsViewModel {
    
    var model: [WalletAssets] = []
    var twdSum = BehaviorRelay<String>(value: "0")
    
    func getMyUserCoinList(apiURL: String, param: String, completion: @escaping (String) -> Void) {
        APIManager.shared.handleFetchAPI(apiURL: apiURL, param: param, completion: { data, response, error in
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(WalletAssetsList.self, from: data)
                        self.model = jsonData.data.data
                        self.twdSum.accept(jsonData.data.twdSum)
                        completion("Success")
                    } catch {
                        tokenChange = true
                        print(APIError.jsonConversionFailure)
                        if let token =  userDefaults.string(forKey: "UserToken") {
                            print(token)
                            if tokenChange {
                                userDefaults.setValue(false, forKey: "isUserLogin")
                                completion("tokenChange")
                            }
                        }
                    }
                    
                }
            }
        })
    }
    
    func loadImg(coinName: String ,completion: @escaping () -> Void) {
        let apiUrl = URL(string: apiUrlPrefix+"files/ico/\(coinName).png")!
        let resource = Resource<String>(url: apiUrl)
        
        APIClient.shared.load(resource: resource) { [weak self] result in
            switch result {
            case .success(let json):
                print(json)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

struct CoinImg: Codable {
    
}
