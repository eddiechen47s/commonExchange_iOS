//
//  AllFinishRecordViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/28.
//

import Foundation

class AllFinishRecordViewModel {
    
    var model = [AllFinishRecord]()
    
    func getMyTradeListByStatus(completion: @escaping () -> Void) {
        guard let token = userDefaults.string(forKey: "UserToken") else {
            return
        }
        APIManager.shared.handleFetchAPI(apiURL: APIPath.getMyTradeListByStatus.value, param: APIParam.allFinishRecord.value+"&token=\(token)", completion: { data, response, error in
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(AllFinishRecordList.self, from: data)
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
