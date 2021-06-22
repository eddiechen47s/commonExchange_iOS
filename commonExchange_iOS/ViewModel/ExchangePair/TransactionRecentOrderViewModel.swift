//
//  TransactionRecentOrderViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/3.
//

import Foundation

class TransactionRecentOrderViewModel {
    var model = [TransactionRecentOrder]()
    
    func getRecentOrder(market: String, completion: @escaping () -> Void) {
        guard let token = userDefaults.string(forKey: "UserToken") else {
            return
        }
        let param = APIParam.transactionRecentOrder.value+"&market=\(market)&token=\(token)"
        print(param)
        APIManager.shared.handleFetchAPI(apiURL: APIPath.getMyTradeListByStatus.value, param: param, completion: { data, response, error in
            
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(TransactionRecentOrderList.self, from: data)
                        print(jsonData.data.list)
                        self.model = jsonData.data.list
                        completion()
                    } catch {
                        print(APIError.jsonConversionFailure)
                        completion()
                    }
                }
            }
        })
    }
    
}
