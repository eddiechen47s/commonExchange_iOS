//
//  AllFinishRecordViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/20.
//

import UIKit

class AllFinishRecordViewController: UIViewController {
    
    private let topView = BaseView(color: .white)
    private let bottomlineView = BaseView(color: #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1))
    private let pairsLabel = BaseLabel(text: "交易對/時間", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 15, weight: .medium), alignments: .left)
    private let priceLabel = BaseLabel(text: "價格/手續費", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 15, weight: .medium), alignments: .right)
    private let amountLabel = BaseLabel(text: "數量/總額", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 15, weight: .medium), alignments: .right)
    var viewModel = AllFinishRecordViewModel()
    
    private lazy var tableView: UITableView = {
        let tab = UITableView()
        tab.backgroundColor = .white
        tab.separatorColor = .clear
        tab.tableFooterView = UIView()
        tab.dataSource = self
        tab.delegate = self
        tab.isEditing = false
        tab.showsVerticalScrollIndicator = false
        tab.register(AllFinishRecordViewCell.self, forCellReuseIdentifier: AllFinishRecordViewCell.identifier)
        return tab
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "已成交記錄"
        view.backgroundColor = .white
        
        setupUI()
        binding()
    }
    
    // MARK: - Helpers
    func binding() {
        if userDefaults.bool(forKey: "isUserLogin") {
            LoadingView.shared.showLoader()
            viewModel.getMyTradeListByStatus {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                LoadingView.shared.hideLoader()
            }
        }
    }
    
    func setupUI() {
        view.addSubViews(topView,
                         tableView
                        )
        topView.addSubViews(pairsLabel,
                            priceLabel,
                            amountLabel,
                            bottomlineView)

        topView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        pairsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(topView.snp.centerY)
            make.left.equalTo(topView.snp.left).offset(15)
            make.width.equalTo(topView.snp.width).multipliedBy(0.33)
            make.height.equalTo(topView.snp.height)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(topView.snp.centerY)
            make.right.equalTo(topView.snp.right).offset(-15)
            make.width.equalTo(topView.snp.width).multipliedBy(0.28)
            make.height.equalTo(topView.snp.height)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.right.equalTo(amountLabel.snp.left)
            make.centerY.equalTo(topView.snp.centerY)
            make.width.equalTo(topView.snp.width).multipliedBy(0.3)
            make.height.equalTo(topView.snp.height)
        }
        
        bottomlineView.snp.makeConstraints { make in
            make.bottom.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension AllFinishRecordViewController: UITableViewDataSource, UITableViewDelegate {
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
        return self.tableView.frame.height / 10
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
