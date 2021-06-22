//
//  OrderViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/2/25.
//

import UIKit
import Parchment

class OrderViewController: UIViewController {
    
    private let pagingViewController = PagingViewController()
    private let recentOrderViewController = RecentOrderViewController()
    private let historyOrderViewController = HistoryOrderViewController()
    private let recordOrderViewController = FinishOrderViewController()
    var viewModel = WalletAssetsViewModel()

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupPaging()
        binding()
    }

    // MARK: - Helpers
    private func binding() {
        let apiURL = "userCoin/getMyUserCoinList?"
        guard let token = userDefaults.string(forKey: "UserToken")  else { return }
        let param = "token=\(token)"
        LoadingView.shared.showLoader()

        if !userDefaults.bool(forKey: "isUserLogin") {
            viewModel.getMyUserCoinList(apiURL: apiURL, param: param) { result in
                if result == "tokenChange" {
                    let alert = UIAlertController(title: "錯誤", message: "帳號從其他地方登入過,請重新登入", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "確定", style: .cancel) { (alert) in
                        self.tabBarController?.selectedIndex = 0
                    }
                    alert.addAction(cancel)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        LoadingView.shared.hideLoader()
    }
    
    func setupUI() {
        view.addSubview(pagingViewController.view)
        
        pagingViewController.view.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    private func setupPaging() {
        pagingViewController.menuItemSize = .fixed(width: view.frame.width / 3, height: 50)
        
        pagingViewController.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        pagingViewController.selectedTextColor = #colorLiteral(red: 0.1772809327, green: 0.2758469284, blue: 0.5724449158, alpha: 1)
        pagingViewController.indicatorColor = #colorLiteral(red: 0.1772809327, green: 0.2758469284, blue: 0.5724449158, alpha: 1)
        
        pagingViewController.delegate = self
        pagingViewController.dataSource = self
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        //        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

extension OrderViewController: PagingViewControllerDelegate, PagingViewControllerDataSource {
    
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return OrderTitleType.allCases.count
    }
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        let title = OrderTitleType.allCases[index].rawValue
        return PagingIndexItem(index: index, title: title)
    }
    
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        let index = OrderTitleType.allCases[index]
        switch index {
        case .recent:
            return recentOrderViewController
        case .history:
            return historyOrderViewController
        case .record:
            return recordOrderViewController
        }
    }
    
    
}
