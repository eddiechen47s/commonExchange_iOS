//
//  ExchangePairViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/9.
//

import UIKit
import Parchment
import RxSwift
import RxCocoa

class ExchangePairViewController: UIViewController {
    
    private let pagingViewController = PagingViewController()
    private let kLineViewController = KLineViewController()
    private let latestResultViewController = LatestDealViewController()
    private let transactionViewController = TransactionViewController()
    var titles: String?
    var disposeBag = DisposeBag()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        backToPriviousController()
        configurePagingViewController()
        setupUI()
//        setNavTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 34/255, green: 60/255, blue: 83/255, alpha: 1)
        setNavTitle()
    }
    
    deinit {
        print("ExchangePairViewController deinit")
    }
    
    // MARK: - Helpers
    func setupUI() {
        view.addSubview(pagingViewController.view)
        
        pagingViewController.view.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func configurePagingViewController() {
        pagingViewController.menuItemSize = .fixed(width: view.frame.width / 3, height: 50)
        pagingViewController.font = .systemFont(ofSize: 16, weight: .medium)
        pagingViewController.selectedFont = .systemFont(ofSize: 16, weight: .heavy)
        pagingViewController.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        pagingViewController.selectedTextColor = #colorLiteral(red: 0.1772809327, green: 0.2758469284, blue: 0.5724449158, alpha: 1)
        pagingViewController.indicatorColor = #colorLiteral(red: 0.1772809327, green: 0.2758469284, blue: 0.5724449158, alpha: 1)
        pagingViewController.borderColor = UIColor(white: 0.05, alpha: 0)
        
        pagingViewController.contentInteraction = .none // 關閉 viewContller 手勢滑動
        pagingViewController.menuInteraction = .none // 關閉 viewContller 手勢滑動
        
        pagingViewController.delegate = self
        pagingViewController.dataSource = self
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
    }
    
    func setNavTitle() {
        self.titles = userDidSelectedPair
        if let pairTitle = titles?.replacingOccurrences(of: "_", with: " / ").uppercased() {
            title = pairTitle
        } else if let pairTitle = titles?.split(separator: "/")[0].uppercased() {
            title = pairTitle
        }
    }
}

extension ExchangePairViewController: PagingViewControllerDelegate, PagingViewControllerDataSource {
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        let model = ExchangePairPageType.allCases
        return PagingIndexItem(index: index, title: model[index].rawValue)
    }
    
    
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return ExchangePairPageType.allCases.count
    }
    
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        let index = ExchangePairPageType.allCases[index]
        switch index {
        case .kLine:
            return kLineViewController
        case .lastesResult:
            latestResultViewController.pairTitle = titles ?? "nil"
        return latestResultViewController
        case .transaction:
            return transactionViewController
        }
    }
    
}
