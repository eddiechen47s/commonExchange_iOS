//
//  DepositViewModel.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/4/22.
//

import Foundation

class DepositViewModel {
    
    var addressModel = [ChainDetail]()
    
    func getMyAddrByCoinNameNew(apiURL: String, param: String, completion: @escaping ([ChainDetail]) -> Void) {
        APIManager.shared.handleFetchAPI(apiURL: apiURL, param: param, completion: { data, response, error in
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(Deposit.self, from: data)
                        self.addressModel = jsonData.data.address
                        completion(self.addressModel)
                    } catch {
                        print(APIError.jsonConversionFailure)
                    }
                    
                }
            }
        })
    }
    
}
