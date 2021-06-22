//
//  WsManager.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/25.
//

import UIKit
import Starscream
import RxSwift
import RxCocoa

class WsManager {
    static let shared = WsManager()
    
    var mainPairChange: PublishRelay = PublishRelay<MainTradingPair>()
    var tradingMarketChange: PublishRelay = PublishRelay<[TradingPairs]>()
    var topFiveHeightChange: PublishRelay = PublishRelay<[TradingPairs]>()
    var mostPoplurChange: PublishRelay = PublishRelay<[TradingPairs]>()

    var mainTradingSocket: WebSocket!
    var tradingPairsSocket: WebSocket!
    var topFiveHeightSocket: WebSocket!
    var mostPoplurScoket: WebSocket!
    
    var mainTradingPairViewModel = MainTradingPairViewModel()
    var increaseRankingViewModel = IncreaseRankingViewModel()
    var tradingMarketViewModel = TradingMarketViewModel()
    var mostPoplurPairsViewModel = MostPoplurPairsViewModel()
        
    var isConnected: Bool = false
    
    func initMainTradingSocket(url wsUrl: String){
        mainTradingSocket = WebSocket(request: URLRequest(url: URL(string: wsUrl)!))
        mainTradingSocket.delegate = self
        mainTradingSocket.connect()
    }
    
    func initTradingPairsSocket(url wsUrl: String){
        tradingPairsSocket = WebSocket(request: URLRequest(url: URL(string: wsUrl)!))
        tradingPairsSocket.delegate = self
        tradingPairsSocket.connect()
    }
    
    func initTopFiveHeightSocket(url wsUrl: String){
        topFiveHeightSocket = WebSocket(request: URLRequest(url: URL(string: wsUrl)!))
        topFiveHeightSocket.delegate = self
        topFiveHeightSocket.connect()
    }
    
    func initMostPoplurPairsSocket(url wsUrl: String){
        mostPoplurScoket = WebSocket(request: URLRequest(url: URL(string: wsUrl)!))
        mostPoplurScoket.delegate = self
        mostPoplurScoket.connect()
    }
}
enum WsError: Error {
    case decodingError
}

extension WsManager: WebSocketDelegate {
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        guard let request = client.request.url?.absoluteString else { return }
        print("WS request:", request)
        if request == WSURL.mainTradingPair.rawValue {
            switch event {
            case .connected(let headers):
                isConnected = true
                print("websocket is connected: \(headers)")
            case .text(let string):
                let data = string.data(using: .utf8)!
                do {
                    let jsonArray = try JSONDecoder().decode(MainTradingPair.self, from: data)
                    self.mainPairChange.accept(jsonArray)
//                    mainTradingPairViewModel.model.append(jsonArray)
                } catch {
                    
                }
            default:
                break
            }
        } else if request == WSURL.tradingMarketPair.rawValue {
            switch event {
            case .text(let string):
                let data = string.data(using: .utf8)!
                do {
                    let jsonData = try JSONDecoder().decode([TradingPairs].self, from: data)
//                    self.tradingMarketChange.accept(jsonData)
                    tradingMarketViewModel.wsLoad(wsData: jsonData)
                } catch {
                    print("tradingMarketPair", WsError.decodingError)
                }
            default:
                break
            }
        } else if request == WSURL.topFiveHeight.rawValue {
            switch event {
            case .text(let string):
                let data = string.data(using: .utf8)!
                do {
                    let jsonData = try JSONDecoder().decode([TradingPairs].self, from: data)
                    self.topFiveHeightChange.accept(jsonData)
                    increaseRankingViewModel.wsLoad(wsData: jsonData)
                } catch {
                    print("topFiveHeight", WsError.decodingError)
                }
            default:
                break
            }
        }else if request == WSURL.mostPoplurSearch.rawValue {
            switch event {
            case .text(let string):
                let data = string.data(using: .utf8)!
                do {
                    let jsonData = try JSONDecoder().decode([TradingPairs].self, from: data)
                    self.mostPoplurPairsViewModel.wsLoad(wsData: jsonData)
                    self.mostPoplurChange.accept(jsonData)
                } catch {
                    print("mostPoplurSearch", WsError.decodingError)
                }
            default:
                break
            }
        }
        //886
        //81293
        //15739
        //83364
        
//        switch event {
//        case .connected(let headers):
//            isConnected = true
////            print(headers.keys)
//            print("websocket is connected: \(headers)")
//        case .disconnected(let reason, let code):
//            isConnected = false
//            print("websocket is disconnected: \(reason) with code: \(code)")
//        case .text(let string):
//            print(string)
////            self.tradingPairsModel.removeAll()
//            print("request:", request)
//            let data = string.data(using: .utf8)!
//            do {
//                if request == WSURL.mainTradingPair.rawValue {
//                    let jsonArray = try JSONDecoder().decode(MainTradingPair.self, from: data)
//                    self.mainPairChange.accept(jsonArray)
//                }
//                if request == WSURL.tradingMarketPair.rawValue {
//                    let jsonData = try JSONDecoder().decode([TradingPairs].self, from: data)
//                    self.tradingMarketChange.accept(jsonData)
//                }
////                if request == WSURL.topFiveHeight.rawValue {
////                    let jsonData = try JSONDecoder().decode([TradingPairs].self, from: data)
////                    self.topFiveHeightChange.accept(jsonData)
////                }
//
////
////                if let jsonArray = try? JSONDecoder().decode(MainTradingPair.self, from: data) {
////                    self.mainPairChange.accept(jsonArray)
//////                    print("jsonArray:",jsonArray)
////                } else if let jsonData = try? JSONDecoder().decode([TradingPairs].self, from: data) {
////
////                        self.tradingMarketChange.accept(jsonData)
//////                        print("TradingPairsData:", jsonData)
////                }
//            } catch let error  {
//                print(error.localizedDescription)
//            }
//        case .binary(let data):
//            print("Received data: \(data.count)")
//        case .ping(_):
//            break
//        case .pong(_):
//            break
//        case .reconnectSuggested(_):
//            break
//        case .cancelled:
//            isConnected = false
//        case .error(let error):
//            isConnected = false
//            handleError(error)
//        case .viabilityChanged(_):
//            break
//        }
    }
    
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket encountered an error")
        }
    }
    
}

