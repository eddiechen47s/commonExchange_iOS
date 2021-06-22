//
//  RecentOrderViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/21.
//

import Foundation

class RecentOrderViewModel {
    var model = [AllOrderRecord]()
    
    func getMyTradeListByStatus(completion: @escaping () -> Void) {
        guard let token = userDefaults.string(forKey: "UserToken") else {
            return
        }
        APIManager.shared.handleFetchAPI(apiURL: APIPath.getMyTradeListByStatus.value, param: APIParam.recentOrder.value+"&token=\(token)", completion: { data, response, error in
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(AllOrderRecordList.self, from: data)
                        self.model = jsonData.data.list
                        completion()
                    } catch {
                        print(APIError.jsonConversionFailure)
                    }
                }
            }
        })
    }
}
