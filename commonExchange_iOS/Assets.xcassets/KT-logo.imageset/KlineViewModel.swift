//
//  KlineViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/10.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

class KlineViewModels {
    static let shared = KlineViewModels()
    var candleModel = [[Double]]()
    var model = [Klines]()
    var marketDatas = [KlineChartData]()

    func historyForAppKline(symbol: String, timeType: String, size: Int,
                            callback:@escaping (Bool, [KlineChartData]) -> Void) {
        let nowTime = Int(Date().timeIntervalSince1970)
        
        var granularity: Int = 300
        switch timeType {
        case "1":
            granularity = nowTime-(86400*1)
        case "5":
            granularity = nowTime-(86400*5)
        case "15":
            granularity = nowTime-(86400*15)
        case "30":
            granularity = nowTime-(86400*30)
        case "60":
            granularity = nowTime-(86400*60)
        case "240":
            granularity = nowTime-(86400*240)
        case "D":
            granularity = nowTime-(86400*365)
        case "W":
            granularity = nowTime-(86400*365*5)
        case "M":
            granularity = nowTime-(86400*365*30)
        default:
            granularity = 300
        }
        let symbol = symbol.replacingOccurrences(of: " / ", with: "_")
        let param = "resolution=\(timeType)&from=\(granularity)&to=\(nowTime)&symbol=\(symbol)"
        self.marketDatas.removeAll()
        self.candleModel.removeAll()
        self.model.removeAll()
        APIManager.shared.handleFetchAPI(apiURL: APIPath.historyForAppKline.value, param: param, completion: { data, response, error in
            
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                DispatchQueue.main.async {
                
                if let data = data {
                    do {
                        let jsonData = try JSONDecoder().decode(KlineList.self, from: data)
                        self.model.append(jsonData.data)
                        for json in self.model {
                            for num in 0..<json.t.count {
                                let open = (json.o[num] as NSString).doubleValue
                                let close = (json.c[num] as NSString).doubleValue
                                let high = (json.h[num] as NSString).doubleValue
                                let low = (json.l[num] as NSString).doubleValue
                                let vol = (json.v[num] as NSString).doubleValue
                                let time = json.t[num]
                                //                    [
                                //                    T 1620632700,
                                //                    L 58665,
                                //                    H  58814.989999999998,
                                //                    O 58730.029999999999,
                                //                    C 58814.989999999998,
                                //                    V 21.958797529999998
                                //                    ]
                                let candles = [time, low, (high), open, close, vol]
                                self.candleModel.append(candles)
                            }
                        }
                        
                        let jsonEncoder = JSONEncoder()
                        let jsonDatas = try jsonEncoder.encode(self.candleModel)
                        let json = try JSON(data: jsonDatas)
                        let chartDatas = json.arrayValue
                        
                        for data in chartDatas {
                            let marektdata = KlineChartData(json: data.arrayValue)
                            self.marketDatas.append(marektdata)
                        }
//                        self.marketDatas.reverse() // 陣列倒轉
                        callback(true, self.marketDatas)
                    } catch {
                        print(APIError.jsonConversionFailure)
                    }
                }
                
            }
                
                
            }
        })
    }
    
    func transForDouble(with value: String) -> CGFloat {
        let str: NSString = value as NSString
        let newValue: CGFloat = CGFloat(str.doubleValue)
        return newValue
    }
    
}

struct CandleList: Codable {
    let time: Double
    let open: CGFloat
    let high: CGFloat
    let low: CGFloat
    let close: CGFloat
    let vol: CGFloat
}
