//
//  MainTradingDetailViewController.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/3/1.
//

import UIKit
import Parchment

class MainTradingDetailViewController: UIViewController {
    
    private let pagingViewController = PagingViewController()
    private let tradingMarketViewController = TradingMarketViewController()
    private let increaseRankingViewController = IncreaseRankingViewController()
    private let declineRankingViewController = MostPoplurPairsViewController()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9507853389, green: 0.9660757184, blue: 0.9805125594, alpha: 1)
        
        setupUI()
        configurePagingViewController()
    }
    
    // MARK: - Helpers
    func setupUI() {
        view.addSubview(pagingViewController.view)
        
        pagingViewController.view.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    private func configurePagingViewController() {
        pagingViewController.menuItemSize = .fixed(width: view.frame.width / 3, height: 50)
        pagingViewController.font = .systemFont(ofSize: 14, weight: .medium)
        pagingViewController.selectedFont = .systemFont(ofSize: 14, weight: .medium)
        pagingViewController.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        pagingViewController.selectedTextColor = #colorLiteral(red: 0.1772809327, green: 0.2758469284, blue: 0.5724449158, alpha: 1)
        pagingViewController.indicatorColor = #colorLiteral(red: 0.1772809327, green: 0.2758469284, blue: 0.5724449158, alpha: 1)

//        pagingViewController.contentInteraction = .none // 關閉 viewContller 手勢滑動
//        pagingViewController.menuInteraction = .none // 關閉 viewContller 手勢滑動

        pagingViewController.delegate = self
        pagingViewController.dataSource = self
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
    }
    


}

extension MainTradingDetailViewController: PagingViewControllerDelegate, PagingViewControllerDataSource {
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        let model = TradingDetail.allCases
        return PagingIndexItem(index: index, title: model[index].rawValue)
    }
    
    
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return TradingDetail.allCases.count
    }
    
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        let index = TradingDetail.allCases[index]
        switch index {
        case .Market:
            return tradingMarketViewController
        case .Increase:
        return increaseRankingViewController
        case .Decline:
            return declineRankingViewController
        }
    }
    
}
