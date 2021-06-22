//
//  TradeSellViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/11.
//

import UIKit
import RxSwift
import RxCocoa

class TradeSellViewController: UIViewController {
    private var viewModel = TradeSellViewModel()
    var userDidSelectedPrice = PublishRelay<String>()
    
    lazy var tableView: UITableView = {
        let tab = UITableView(frame: .zero, style: .plain)
        tab.backgroundColor = .clear
        tab.isScrollEnabled = false
        tab.register(TransactionViewCell.self, forCellReuseIdentifier: TransactionViewCell.identifier)
        tab.delegate = self
        tab.dataSource = self
        tab.tableFooterView = UIView()
        tab.separatorColor = .clear
        return tab
    }()
    
    var number = Double.random(in: 0.1..<1)
    var number1 = Double.random(in: 0.1..<1)
    var number2 = Double.random(in: 0.1..<1)
    var number3 = Double.random(in: 0.1..<1)
    var number4 = Double.random(in: 0.1..<1)
    
    var timer = Timer()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        binding()
        setupTimeReload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    
    deinit {
        print("TradeSellViewController deinit")
    }
    
    // MARK: - Helpers
    func binding() {
        let param = "type=sell&symbol=\(userDidSelectedPair)"
        viewModel.getFiveTradeSellList(apiURL: APIPath.getFiveTradeList.value, param: param) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setupTimeReload() {
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(setupTableData), userInfo: nil, repeats: true)
    }
    
    private func setupUI() {
        view.addSubViews(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Selector
    @objc private func setupTableData() {
        binding()
    }
    
    @objc private func adjustViewReload() {
        number = Double.random(in: 0.1..<1)
        number1 = Double.random(in: 0.1..<1)
        number2 = Double.random(in: 0.1..<1)
        number3 = Double.random(in: 0.1..<1)
        number4 = Double.random(in: 0.1..<1)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

extension TradeSellViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionViewCell.identifier, for: indexPath) as! TransactionViewCell
        switch indexPath.row {
        case 0:
            cell.configureAdjustView(with: number)
        case 1:
            cell.configureAdjustView(with: number1)
        case 2:
            cell.configureAdjustView(with: number2)
        case 3:
            cell.configureAdjustView(with: number3)
        case 4:
            cell.configureAdjustView(with: number4)
        default:
            break
        }
        cell.configure(with: viewModel.model[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let vm = viewModel.model[indexPath.row]
        let selectedPrice = (vm.price as NSString).doubleValue.toString(maxF: 4)
        self.userDidSelectedPrice.accept(selectedPrice)
    }
    
    
}
