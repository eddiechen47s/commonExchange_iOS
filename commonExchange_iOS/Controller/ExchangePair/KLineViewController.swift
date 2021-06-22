//
//  KLineViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/9.
//

import UIKit

class KLineViewController: UIViewController {
    
    private let kLineDetailViewController = KLineDetailViewController()
    private lazy var chartCustomViewController = ChartCustomViewController()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    deinit {
        print("KLineViewController deinit")
    }
    
    // MARK: - Helpers
    func setupUI() {
        view.addSubViews(kLineDetailViewController.view,
                         chartCustomViewController.view)
        
        addChild(kLineDetailViewController)
        addChild(chartCustomViewController)
        kLineDetailViewController.didMove(toParent: self)
        chartCustomViewController.didMove(toParent: self)
        
        kLineDetailViewController.view.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.15)
        }
        
        chartCustomViewController.view.snp.makeConstraints { make in
            make.top.equalTo(kLineDetailViewController.view.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
}
