//
//  TradeBuyViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/11.
//

import UIKit
import RxSwift
import RxCocoa

class TradeBuyViewController: UIViewController {
    var viewModel = TradeBuyViewModel()
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
    
    var number = Double.random(in: 0.1..<0.5)
    var number1 = Double.random(in: 0.4..<1)
    var number2 = Double.random(in: 0.1..<1)
    var number3 = Double.random(in: 0.2..<0.5)
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
//        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(adjustViewReload), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    
    deinit {
        print("TradeBuyViewController deinit")
    }
    
    // MARK: - Helpers
    func binding() {
        let param = "type=buy&symbol=\(userDidSelectedPair)"
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
    
    @objc private func setupTableData() {
        binding()
    }

}

extension TradeBuyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionViewCell.identifier, for: indexPath) as! TransactionViewCell
        cell.adjustView.backgroundColor = #colorLiteral(red: 0.7800678611, green: 0.9011700749, blue: 0.8249022365, alpha: 1)
        cell.priceLabel.textColor = #colorLiteral(red: 0.2776432037, green: 0.6590948701, blue: 0.4378901124, alpha: 1)
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
        print(indexPath.row)
        let vm = viewModel.model[indexPath.row]
        let selectedPrice = (vm.price as NSString).doubleValue.toString(maxF: 4)
        self.userDidSelectedPrice.accept(selectedPrice)
    }
    
    
}
