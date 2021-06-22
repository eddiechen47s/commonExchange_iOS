//
//  RecentOrderViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/4.
//  委託中

import UIKit

class RecentOrderViewController: UIViewController {
    
    private let recentDetailView = UIView()
    private let bottomView = BaseView(color: #colorLiteral(red: 0.9532666802, green: 0.9592470527, blue: 0.9771805406, alpha: 1))
    private let pairsLabel = BaseLabel(text: "交易對 / 價格", color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), font: .systemFont(ofSize: 13, weight: .medium), alignments: .left)
  
    private let amountLabel = BaseLabel(text: "數量 / 總額", color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), font: .systemFont(ofSize: 13, weight: .medium), alignments: .right)
    var viewModel = RecentOrderViewModel()

    private lazy var tableView: UITableView = {
        let tab = UITableView()
        tab.backgroundColor = #colorLiteral(red: 0.9763647914, green: 0.9765316844, blue: 0.9763541818, alpha: 1)
        tab.separatorColor = .clear
        tab.tableFooterView = UIView()
        tab.dataSource = self
        tab.delegate = self
        tab.isEditing = false
        tab.showsVerticalScrollIndicator = false
        tab.register(AllRecordOrderViewCell.self, forCellReuseIdentifier: AllRecordOrderViewCell.identifier)
        return tab
    }()
    
    var timer = Timer()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        recentDetailView.backgroundColor = .white
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
    
    // MARK: - Helpers
    func setupTimeReload() {
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(setupTableData), userInfo: nil, repeats: true)
    }
    
    func bindingVM() {
//        LoadingView.shared.showLoader()
        viewModel.getMyTradeListByStatus {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
//            LoadingView.shared.hideLoader()
        }
        print("recentOrder",viewModel.model)

    }
    
    func setupUI() {
        view.addSubViews(recentDetailView,
                         tableView)
        
        recentDetailView.addSubViews(pairsLabel,
                                     amountLabel,
                                     bottomView)
        
        recentDetailView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        pairsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(recentDetailView.snp.centerY)
            make.left.equalTo(recentDetailView.snp.left).offset(15)
            make.width.equalTo(view.snp.width).multipliedBy(0.3)
            make.height.equalTo(recentDetailView.snp.height)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(recentDetailView.snp.centerY)
            make.right.equalTo(recentDetailView.snp.right).offset(-15)
            make.width.equalTo(recentDetailView.snp.width).multipliedBy(0.3)
            make.height.equalTo(recentDetailView.snp.height)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(recentDetailView.snp.bottom)
            make.left.right.equalTo(recentDetailView)
            make.height.equalTo(1.5)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(recentDetailView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Selector
    @objc private func setupTableData() {
        bindingVM()
    }

}

extension RecentOrderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = viewModel.model[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: AllRecordOrderViewCell.identifier, for: indexPath) as! AllRecordOrderViewCell
        cell.configure(with: vm)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.height / 9
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = viewModel.model[indexPath.row]
        print(vm)
        let controller = OderDetailViewController()
        controller.model = vm
        controller.coinPair = vm.market
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(controller, animated: true)
    }

    
    
}

extension RecentOrderViewController: RecentOrderCancel {
    // 刪除 cell
    func cancelOrder(in cell: RecentOrderViewCell) {
        guard let index = tableView.indexPath(for: cell) else { return }
//        self.models.remove(at: index.row)
        self.tableView.deleteRows(at: [index], with: .automatic)
    }
    
}
