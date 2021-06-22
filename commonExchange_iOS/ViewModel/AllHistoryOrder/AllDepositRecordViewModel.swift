//
//  AllDepositRecordViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/27.
//

import Foundation

class AllDepositRecordViewModel {
    
    var model = [DepositRecordList]()
    
    func getTurnInOutList(completion: @escaping () -> Void) {
        guard let token = userDefaults.string(forKey: "UserToken") else {
            return
        }
        APIManager.shared.handleFetchAPI(apiURL: APIPath.getTurnInOutList.value, param: APIParam.allHistoryDeposit.value+"&token=\(token)", completion: { data, response, error in
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(DepositRecordData.self, from: data)
                        self.model = jsonData.data.list
                        print(jsonData.data.list)
                        completion()
                    } catch {
                        print(APIError.jsonConversionFailure)
                    }
                }
            }
        })
    }
    
    
}
