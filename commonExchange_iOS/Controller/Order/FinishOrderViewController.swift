//
//  RecordOrderViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/4.
//  已成交

import UIKit

class FinishOrderViewController: UIViewController {
    private let recordOrderDetailView = UIView()
    private let bottomView = BaseView(color: #colorLiteral(red: 0.9532666802, green: 0.9592470527, blue: 0.9771805406, alpha: 1))
    
    private let tradingPairLabel = BaseLabel(text: "交易對 / 時間", color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), font: .systemFont(ofSize: 13, weight: .medium), alignments: .left)
    private let priceLabel = BaseLabel(text: "價格 / 手續費", color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), font: .systemFont(ofSize: 13, weight: .medium), alignments: .left)
    private let finishOrderLabel = BaseLabel(text: "數量 / 總額", color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), font: .systemFont(ofSize: 13, weight: .medium), alignments: .right)
    
    private lazy var tableView: UITableView = {
        let tab = UITableView()
        tab.backgroundColor = #colorLiteral(red: 0.9763647914, green: 0.9765316844, blue: 0.9763541818, alpha: 1)
        tab.separatorColor = .clear
        tab.tableFooterView = UIView()
        tab.dataSource = self
        tab.delegate = self
        tab.isEditing = false
        tab.showsVerticalScrollIndicator = false
        tab.register(AllFinishRecordViewCell.self, forCellReuseIdentifier: AllFinishRecordViewCell.identifier)
        return tab
    }()
    var viewModel = AllFinishRecordViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        bindingVM()
    }
    
    // MARK: - Helpers
    func bindingVM() {
//        LoadingView.shared.showLoader()
        viewModel.getMyTradeListByStatus {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
//            LoadingView.shared.hideLoader()
        }
    }
    
    private func setupUI() {
        view.addSubViews(recordOrderDetailView,
                         tableView)
        
        recordOrderDetailView.addSubViews(tradingPairLabel,
                                          priceLabel,
                                          finishOrderLabel,
                                          bottomView)
        
        recordOrderDetailView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        tradingPairLabel.snp.makeConstraints { make in
            make.centerY.equalTo(recordOrderDetailView.snp.centerY)
            make.left.equalTo(recordOrderDetailView.snp.left).offset(15)
            make.width.equalTo(recordOrderDetailView.snp.width).multipliedBy(0.3)
            make.height.equalTo(recordOrderDetailView.snp.height)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(recordOrderDetailView.snp.centerY)
            make.right.equalTo(finishOrderLabel.snp.left)
            make.width.equalTo(recordOrderDetailView.snp.width).multipliedBy(0.23)
            make.height.equalTo(recordOrderDetailView.snp.height)
        }
        
        finishOrderLabel.snp.makeConstraints { make in
            make.centerY.equalTo(recordOrderDetailView.snp.centerY)
            make.right.equalTo(recordOrderDetailView.snp.right).offset(-15)
            make.width.equalTo(recordOrderDetailView.snp.width).multipliedBy(0.28)
            make.height.equalTo(recordOrderDetailView.snp.height)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(recordOrderDetailView.snp.bottom)
            make.left.right.equalTo(recordOrderDetailView)
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(recordOrderDetailView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }


}

extension FinishOrderViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = viewModel.model[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: AllFinishRecordViewCell.identifier, for: indexPath) as! AllFinishRecordViewCell
        cell.configure(with: vm)
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
        let controller = RecordOrderDetailViewController()
        controller.model = vm
        controller.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(controller, animated: true)
    }

    
}

