//
//  HistoryOrderViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/4.
//  歷史委託

import UIKit

class HistoryOrderViewController: UIViewController {
    
    var viewModel = AllRecordOrderViewModel()
    var orderDetailVM = OderDetailViewModel()

    private let historyDetailView = UIView()
    private let bottomView = BaseView(color: #colorLiteral(red: 0.9532666802, green: 0.9592470527, blue: 0.9771805406, alpha: 1))
    private let tradingPairLabel = BaseLabel(text: "交易對 / 時間", color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), font: .systemFont(ofSize: 13, weight: .medium), alignments: .left)
    private let priceLabel = BaseLabel(text: "價格", color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), font: .systemFont(ofSize: 13, weight: .medium), alignments: .right)
    private let finishOrderLabel = BaseLabel(text: "成交 / 數量", color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), font: .systemFont(ofSize: 13, weight: .medium), alignments: .right)
    
    private lazy var tableView: UITableView = {
        let tab = UITableView()
        tab.backgroundColor = #colorLiteral(red: 0.9763647914, green: 0.9765316844, blue: 0.9763541818, alpha: 1)
        tab.separatorColor = .clear
        tab.tableFooterView = UIView()
        tab.dataSource = self
        tab.delegate = self
        tab.isEditing = false
        tab.showsVerticalScrollIndicator = false
        tab.register(HistoryOrderViewCell.self, forCellReuseIdentifier: HistoryOrderViewCell.identifier)
        return tab
    }()
    var timer = Timer()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        bindingVM()
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
        print("HistoryOrderViewController deinit")
    }
    
    // MARK: - Helpers
    func setupTimeReload() {
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(setupTableData), userInfo: nil, repeats: true)
    }
    
    private func bindingVM() {
//        LoadingView.shared.showLoader()
        viewModel.getMyTradeListByStatus {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
//            LoadingView.shared.hideLoader()
        }
    }
    
    private func setupUI() {
        view.addSubViews(historyDetailView,
                         tableView)
        historyDetailView.addSubViews(tradingPairLabel,
                                      priceLabel,
                                      finishOrderLabel,
                                      bottomView)
        
        historyDetailView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        tradingPairLabel.snp.makeConstraints { make in
            make.centerY.equalTo(historyDetailView.snp.centerY)
            make.left.equalTo(historyDetailView.snp.left).offset(15)
            make.width.equalTo(historyDetailView.snp.width).multipliedBy(0.3)
            make.height.equalTo(historyDetailView.snp.height)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(historyDetailView.snp.centerY)
            make.right.equalTo(finishOrderLabel.snp.left)
            make.width.equalTo(historyDetailView.snp.width).multipliedBy(0.2)
            make.height.equalTo(historyDetailView.snp.height)
        }
        
        finishOrderLabel.snp.makeConstraints { make in
            make.centerY.equalTo(historyDetailView.snp.centerY)
            make.right.equalTo(historyDetailView.snp.right).offset(-15)
            make.width.equalTo(historyDetailView.snp.width).multipliedBy(0.28)
            make.height.equalTo(historyDetailView.snp.height)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(historyDetailView.snp.bottom)
            make.left.right.equalTo(historyDetailView)
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(historyDetailView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Selector
    @objc private func setupTableData() {
        bindingVM()
    }
}

extension HistoryOrderViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = viewModel.model[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryOrderViewCell.identifier, for: indexPath) as! HistoryOrderViewCell
        cell.configure(with: vm)
        orderDetailVM.getMyTradeLogList(tradeId: vm.id) { data in
            for r in data {
                let num = (r.num as NSString).doubleValue
                DispatchQueue.main.async {
                    if num == 0 {
                        cell.backgroundColor = .systemFill
                    } else {
                        cell.backgroundColor = .white
                        cell.baseLabel.textColor = #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1)
                        cell.targetLabel.textColor = #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1)

                        if vm.type == 1 {
                            cell.dealLabel.textColor = #colorLiteral(red: 0.2333128452, green: 0.7429219484, blue: 0.5215145946, alpha: 1)
                            cell.priceLabel.textColor = #colorLiteral(red: 0.2333128452, green: 0.7429219484, blue: 0.5215145946, alpha: 1)
                        } else {
                            cell.dealLabel.textColor = #colorLiteral(red: 0.9601823688, green: 0.2764334977, blue: 0.3656736016, alpha: 1)
                            cell.priceLabel.textColor = #colorLiteral(red: 0.9601823688, green: 0.2764334977, blue: 0.3656736016, alpha: 1)
                        }
                    }
                }
            }
        }

        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.height / 9
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let vm = viewModel.model[indexPath.row]
        print(vm)
        
        let controller = OderDetailViewController()
        controller.model = vm
        controller.coinPair = vm.market
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(controller, animated: true)
    }

    
}
