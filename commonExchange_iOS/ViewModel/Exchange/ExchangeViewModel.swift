//
//  ExchangeViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/2.
//

import UIKit
import RxSwift
import RxCocoa

enum ExchangeTitleType: String, CaseIterable {
    case btc = "BTC"
    case eth = "ETH"
    case ustd = "USTD"
    case kt = "KT"
}

class ExchangeViewModel {
    
    func load(completion: @escaping ([String]) -> Void) {
        let apiUrl = URL(string: "https://www.ktrade.io/api/userCoin/getcoinKey")!
        let resource = Resource<ExchangeTitle>(url: apiUrl)
        
        APIClient.shared.load(resource: resource) { result in
            print(result)
            switch result {
            case .success(let json):
                completion(json.data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
