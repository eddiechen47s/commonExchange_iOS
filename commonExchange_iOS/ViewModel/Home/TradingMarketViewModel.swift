//
//  TradingMarketViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/26.
//

import Foundation

class TradingMarketViewModel {
    
    var model = [TradingPairs]()
    
    func load(completion: @escaping () -> Void) {
        let apiUrl = URL(string: TradingPairAPI.TradingMarket.value)!
        let resource = Resource<TradingPairList>(url: apiUrl)
        
        APIClient.shared.load(resource: resource) { [weak self] result in
            print(result)
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
        self.model.removeAll()
        self.model = wsData
    }
    
}
