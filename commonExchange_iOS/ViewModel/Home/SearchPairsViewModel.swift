//
//  SearchPairsViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/9.
//

import Foundation

class SearchPairsViewModel {
    
    var model = [SearchListData]()
    
    func load(completion: @escaping () -> Void) {
        let apiUrl = URL(string: apiUrlprefixRobot+APIPath.search.value)!
        let resource = Resource<SearchPairs>(url: apiUrl)
        
        APIClient.shared.load(resource: resource) { [weak self] result in
            switch result {
            case .success(let json):
                print(json)
                self?.model = json.data
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
}
