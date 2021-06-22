//
//  BaseMainTradingViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/2.
//

import UIKit
var userDidSelectedPair = ""

class BaseMainTradingViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tab = UITableView(frame: .zero, style: .plain)
        tab.backgroundColor = .white
        tab.isScrollEnabled = false
        tab.register(BaseMainTradingView.self, forCellReuseIdentifier: BaseMainTradingView.identifier)
        tab.delegate = self
        tab.dataSource = self
        tab.tableFooterView = UIView()
//        tab.separatorColor = .clear
        return tab
    }()
    
    private let topDetailView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let topDetailBottomView = BaseView(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    
    private let marketLabel = BaseLabel(text: "交易市場", color: .systemGray, font: .systemFont(ofSize: 14, weight: .heavy), alignments: .left)
    private let newPriceLabel = BaseLabel(text: "最新價", color: .systemGray, font: .systemFont(ofSize: 14, weight: .heavy), alignments: .center)
    private let changePercentLabel = BaseLabel(text: "24h 漲跌", color: .systemGray, font: .systemFont(ofSize: 14, weight: .heavy), alignments: .center)
    
    var tradingPairsModel = [TradingPairs]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        setupVM()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func setupUI() {
        view.addSubViews(topDetailView,
                         tableView)
        topDetailView.addSubViews(marketLabel,
                                  newPriceLabel,
                                  changePercentLabel,
                                  topDetailBottomView)
        
        topDetailView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        marketLabel.snp.makeConstraints { make in
            make.centerY.equalTo(topDetailView.snp.centerY)
            make.left.equalTo(topDetailView.snp.left).offset(20)
            make.width.equalTo(topDetailView.snp.width).multipliedBy(0.3)
            make.height.equalTo(topDetailView.snp.height)
        }
        
        newPriceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(topDetailView.snp.centerY)
            make.centerX.equalTo(topDetailView.snp.centerX).offset(-20)
            make.width.equalTo(topDetailView.snp.width).multipliedBy(0.3)
            make.height.equalTo(topDetailView.snp.height)
        }
        
        changePercentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(topDetailView.snp.centerY)
            make.right.equalTo(topDetailView.snp.right).offset(-20)
            make.width.equalTo(topDetailView.snp.width).multipliedBy(0.3)
            make.height.equalTo(topDetailView.snp.height)
        }
        
        topDetailBottomView.snp.makeConstraints { make in
            make.bottom.equalTo(topDetailView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(0.2)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topDetailView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    
    func setupVM() {
    }
    
}

extension BaseMainTradingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tradingPairsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = tradingPairsModel[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseMainTradingView.identifier, for: indexPath) as! BaseMainTradingView
        cell.configure(with: vm)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let titles = tradingPairsModel[indexPath.item].base + " / " + tradingPairsModel[indexPath.item].target
        let controller = createNavController(vc: ExchangePairViewController(), title: titles.uppercased(), image: nil, selectedImage: nil, tag: 1)
        controller.modalPresentationStyle = .fullScreen

        let pairsTitle = tradingPairsModel[indexPath.item].base + "_" + tradingPairsModel[indexPath.item].target
        userDidSelectedPair = pairsTitle
        self.present(controller, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.height / 5
    }

}
