//
//  IncreaseRankingViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/29.
//

import UIKit

class IncreaseRankingViewModel {
    
    var model = [TradingPairs]()
    
    func load(completion: @escaping () -> Void) {
        let apiUrl = URL(string: TradingPairAPI.IncreaseRanking.value)!
        let resource = Resource<TradingPairList>(url: apiUrl)
        
        APIClient.shared.load(resource: resource) { [weak self] result in
            switch result {
            case .success(let json):
                self?.model = json.data
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func wsLoad(wsData: [TradingPairs]) {
        print(wsData)
        self.model.removeAll()
        self.model = wsData
    }
    
}
