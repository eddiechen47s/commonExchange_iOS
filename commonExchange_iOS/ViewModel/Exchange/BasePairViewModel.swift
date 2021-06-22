//
//  BasePairViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/21.
//

import Foundation

class BasePairViewModel {
    
//    var model = [ExchangeDetail]()
//    var urlPrefix = "https://www.ktrade.io/robot/getChangeAndPriceList?"
    
    func getChangeAndPriceList(apiURL: String, param: String, completion: @escaping ([ExchangeDetail]) -> Void) {
        APIManager.shared.fetchRobotAPI(apiURL: apiURL, param: param) { (data, response, error) in
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
//                        let js = try JSONSerialization.jsonObject(with: data, options: [])
//                        print(js)
                        let jsonData = try JSONDecoder().decode(ExchangeDetailList.self, from: data)
                        print(jsonData)
                        completion(jsonData.data)
                    } catch {
                        print(APIError.jsonConversionFailure)
                    }
                    
                }
            }
        }
    }
    
}
