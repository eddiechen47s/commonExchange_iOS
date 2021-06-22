//
//  MainBannerViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/28.
//

import Foundation
import RxSwift
import RxCocoa

class MainBannerViewModel {
    
    var model = [String]()
    var netWorkError = PublishRelay<Bool>()
    
    func loadBannerImg(completion: @escaping ([String]) -> Void) {
        let apiUrl = URL(string: apiUrlPrefix+APIPath.banner.value)!
        print(apiUrl)
        let resource = Resource<MainBannerList>(url: apiUrl)
        
        APIClient.shared.load(resource: resource) { [weak self] result in
            switch result {
            case .success(let json):
                for imgStr in json.data {
                    self?.model.append(imgStr.imgandroidpath)
                }
                self?.netWorkError.accept(true)
                completion(self?.model ?? [])
            case .failure(let error):
                print(error)
                self?.netWorkError.accept(false)
            }
        }
    }
    
}

