//
//  MainTradingPairViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/24.
//

import UIKit

class MainTradingPairViewModel {
    
    var model = [MainTradingPairCoin]()
    
    func load(completion: @escaping () -> Void) {
        let apiUrl = URL(string: TradingPairAPI.mainTradingPair.value)!
        let resource = Resource<MainTradingPairList>(url: apiUrl)
        APIClient.shared.load(resource: resource) { [weak self] result in
            switch result {
            case .success(let json):
                print(json)
                self?.model.append(json.data.left)
                self?.model.append(json.data.center)
                self?.model.append(json.data.right)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func wsLoad(wsData: [MainTradingPairCoin]) {
        self.model.removeAll()
        self.model = wsData
    }
    
    
    
    
}
