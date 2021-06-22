//
//  RecordOrderDetailViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/8.
//

import UIKit

class RecordOrderDetailViewController: UIViewController {
    
    private let toplineView = BaseView(color: .systemGray)
    private let bottomlineView = BaseView(color: .systemGray)
    private let titleLabel = BaseLabel(text: "ETH / USDT", color: #colorLiteral(red: 0.1328194737, green: 0.2377011478, blue: 0.3250451386, alpha: 1), font: .systemFont(ofSize: 22, weight: .medium), alignments: .center)
    
    var viewModel = RecordOrderDetailViewModel()
    var model: AllFinishRecord!
    var dealModel = [DealModel]()
    lazy var market = model.market.uppercased()
    
    private lazy var tableView: UITableView = {
        let tab = UITableView()
        tab.backgroundColor = .clear
        tab.separatorColor = .clear
        tab.tableFooterView = UIView()
        tab.dataSource = self
        tab.delegate = self
        tab.isScrollEnabled = false
        tab.isEditing = false
        tab.showsVerticalScrollIndicator = false
        tab.register(RecordOrderDetailViewCell.self, forCellReuseIdentifier: RecordOrderDetailViewCell.identifier)
        return tab
    }()
    var status = ""
    var fee = ""

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9763647914, green: 0.9765316844, blue: 0.9763541818, alpha: 1)
        title = "成交紀錄明細"
        print(market)
        self.titleLabel.text = market.uppercased()
            .replacingOccurrences(of: "_", with: " / ")
        setupUI()
        setupTableData()
        bindingVM()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.popViewController(animated: false)
    }
    // MARK: - Helpers
    private func bindingVM() {
//        viewModel.getTurnInOutList(tradeId: model.id) { (data) in
//            print(data)
//        }
    }
    
    private func setupTableData() {
        LoadingView.shared.showLoader()
        if model.type == 1 {
            status = "買入"
        } else {
            status = "賣出"
        }
        let price = (model.price as NSString).doubleValue
        let num = (model.num as NSString).doubleValue
        let mum = (model.mum as NSString).doubleValue
        let fee = (model.fee as NSString).doubleValue.toString(maxF:9)
        self.dealModel = [
            DealModel(title: "訂單編號", data: model.id.toString()),
            DealModel(title: "交易時間", data: self.timeToTimeStamp(time: String(model.addtime))),
            DealModel(title: "類型", data: status),
            DealModel(title: "掛單價格", data: price.toString(maxF:9)),
            DealModel(title: "成交價格", data: (num*mum).toString(maxF: 8)),
            DealModel(title: "數量", data: model.num),
            DealModel(title: "總額", data: mum.toString(maxF: 8)),
            DealModel(title: "手續費", data: fee)
        ]
        self.tableView.reloadData()
        LoadingView.shared.hideLoader()
    }
    
    func setupUI() {
        view.addSubViews(titleLabel,
                         toplineView,
                         tableView,
                         bottomlineView
                        )
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view.snp.left)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(50)
        }
        
        toplineView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalTo(tableView).inset(-5)
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(toplineView.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(view.snp.height).multipliedBy(0.33)
        }
        
        bottomlineView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(1)
        }
    }
}

extension RecordOrderDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dealModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dealModel[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: RecordOrderDetailViewCell.identifier, for: indexPath) as! RecordOrderDetailViewCell
        cell.backgroundColor = .systemGray
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = model.title
            cell.detailLabel.text = model.data
        case 1:
            cell.titleLabel.text = model.title
            cell.detailLabel.text = model.data

        case 2:
            cell.titleLabel.text = model.title
            cell.detailLabel.text = model.data
            if model.data == "賣出" {
                cell.detailLabel.textColor = .systemRed
                cell.detailLabel.font = .systemFont(ofSize: 16, weight: .bold)
            } else {
                cell.detailLabel.textColor = .systemGreen
                cell.detailLabel.font = .systemFont(ofSize: 16, weight: .bold)
            }
        case 3:
            cell.titleLabel.text = model.title
            cell.detailLabel.text = model.data+" "+market.uppercased().split(separator: "_")[1]

        case 4:
            cell.titleLabel.text = model.title
            cell.detailLabel.text = model.data+" "+market.uppercased().split(separator: "_")[0]

        case 5:
            cell.titleLabel.text = model.title
            cell.detailLabel.text = model.data+" "+market.uppercased().split(separator: "_")[0]

        case 6:
            cell.titleLabel.text = model.title
            cell.detailLabel.text = model.data+" "+market.uppercased().split(separator: "_")[1]
        case 7:
            cell.titleLabel.text = model.title
            cell.detailLabel.text = model.data+" "+market.split(separator: "_")[1]
        default:
            break
        }
        cell.selectionStyle = .none
        cell.backgroundColor = #colorLiteral(red: 0.9763647914, green: 0.9765316844, blue: 0.9763541818, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.height / 8
    }
    
}

struct DealModel {
    let title: String
    let data: String
}
