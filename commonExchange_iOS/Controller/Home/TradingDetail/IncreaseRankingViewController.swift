//
//  IncreaseRankingViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/2.
//

import UIKit
import RxSwift
import RxCocoa

class IncreaseRankingViewController: BaseMainTradingViewController {
    let viewModel = IncreaseRankingViewModel()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

 
//        WsManager.shared.initTopFiveHeightSocket(url: WSURL.topFiveHeight.rawValue)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.load {
            self.tradingPairsModel = self.viewModel.model
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        WsManager.shared.topFiveHeightChange
            .subscribe(onNext: { [weak self] wsData in
//                print(self?.tradingPairsModel)
                self?.tradingPairsModel.removeAll()
                self?.viewModel.model = wsData
                self?.tradingPairsModel = self!.viewModel.model
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            })
            .disposed(by: disposeBag)
            
    }
    

    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        WsManager.shared.topFiveHeightSocket?.disconnect()

    }
    

    

}
