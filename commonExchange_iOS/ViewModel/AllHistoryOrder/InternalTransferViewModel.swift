//
//  InternalTransferViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/27.
//

import Foundation

class InternalTransferViewModel {
    
    var model = [InternalTransferRecordList]()
    
    func getInternalInOutList(completion: @escaping () -> Void) {
        guard let token = userDefaults.string(forKey: "UserToken") else {
            return
        }
        APIManager.shared.handleFetchAPI(apiURL: APIPath.getInternalInOutList.value, param: APIParam.allInternalInOut.value+"&token=\(token)", completion: { data, response, error in
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(InternalTransferRecordData.self, from: data)
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
