//
//  WalletDetailViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/13.
//

import Foundation

class WalletDetailViewModel {
    
//    var model: [WalletDetail] = [
//        WalletDetail(base: "ETH", target: "BTC", lastesPrice: "0.0335812", persent: "-1.29", volume: "123.38277622", twd: "62.312.0"),
//        WalletDetail(base: "ETH", target: "BTC", lastesPrice: "0.0335812", persent: "+1.29", volume: "123.38277622", twd: "62.312.0")
//    ]
    
    var model = [WalletDetailPairs]()
    
    func getChangeAndPriceList(coinname: String, completion: @escaping () -> Void) {
        let param = "coinname=\(coinname)"
            APIManager.shared.fetchRobotAPI(apiURL: APIPath.getChangeAndPriceList.value, param: param, completion: { data, response, error in
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(WalletDetailPairsList.self, from: data)
                        print(jsonData)
                        self.model = jsonData.data
                        print(self.model)
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
