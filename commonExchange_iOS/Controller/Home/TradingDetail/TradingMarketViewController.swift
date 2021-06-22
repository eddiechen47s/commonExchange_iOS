//
//  TradingMarketViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/2.
//

import UIKit
import RxSwift
import RxCocoa

class TradingMarketViewController: BaseMainTradingViewController {
    
    var viewModel = TradingMarketViewModel()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        WsManager.shared.initTradingPairsSocket(url: WSURL.tradingMarketPair.rawValue)

        viewModel.load {
            self.tradingPairsModel = self.viewModel.model
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        WsManager.shared.tradingMarketChange
            .subscribe(onNext: { [weak self] wsData in

                self?.viewModel.model.removeAll()
                self?.viewModel.model = wsData
                self?.tradingPairsModel.removeAll()
                self?.tradingPairsModel = wsData
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            })
            .disposed(by: disposeBag)
            
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        WsManager.shared.mainTradingSocket.disconnect()
    }
    
    override func setupVM() {

    }

    

}
