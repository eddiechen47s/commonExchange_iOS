//
//  AllWithdrawalRecordViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/20.
//

import UIKit

class AllWithdrawalRecordViewController: UIViewController {
    var viewModel = AllWithdrawalRecordViewModel()
    private var addressValue = ""
    private let topView = BaseView(color: .white)
    private let bottomlineView = BaseView(color: #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1))
    private let pairsLabel = BaseLabel(text: "幣種/時間", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 15, weight: .medium), alignments: .left)
    private let priceLabel = BaseLabel(text: "提領地址/手續費", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 15, weight: .medium), alignments: .right)
    private let amountLabel = BaseLabel(text: "數量/狀態", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 15, weight: .medium), alignments: .right)
    //    var viewModel = RecordOrderDetailViewModel()
    
    private lazy var tableView: UITableView = {
        let tab = UITableView()
        tab.backgroundColor = .white
        tab.separatorColor = .clear
        tab.tableFooterView = UIView()
        tab.dataSource = self
        tab.delegate = self
        tab.isEditing = false
        tab.showsVerticalScrollIndicator = false
        tab.register(AllWithdrawalRecordViewCell.self, forCellReuseIdentifier: AllWithdrawalRecordViewCell.identifier)
        return tab
    }()
    
    var tipView = BaseView(color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1))
    private let tipImgView = BaseImageView(image: "DepositRecord", color: nil)
    private let getLabel = BaseLabel(text: "提領至", color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: .systemFont(ofSize: 24, weight: .medium), alignments: .center)
    private let addressLabel = BaseLabel(text: "1NjiRs3uoVsszsYzP4ixiGCWVTgR4s7R3U", color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: .systemFont(ofSize: 14, weight: .medium), alignments: .center)
    private let copyButton: UIButton = {
        let button = UIButton()
        button.setTitle("複製地址", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapCopy), for: .touchUpInside)
        return button
    }()
    var copyAddressStr: String?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "提領記錄"
        
        setupUI()
        binding()
        self.addressLabel.numberOfLines = 2
    }
    
    // MARK: - Helpers
    func binding() {
        if userDefaults.bool(forKey: "isUserLogin") {
            LoadingView.shared.showLoader()
            viewModel.getTurnInOutList {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                LoadingView.shared.hideLoader()
            }
        }
    }
    
    func setupUI() {
        tipView.isHidden = true
        view.addSubViews(topView,
                         tableView,
                         tipView
        )
        topView.addSubViews(pairsLabel,
                            priceLabel,
                            amountLabel,
                            bottomlineView)
        
        tipView.addSubViews(tipImgView,
                            getLabel,
                            addressLabel,
                            copyButton
        )
        
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
            make.left.equalTo(pairsLabel.snp.right)
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
        
        tipView.snp.makeConstraints { (make) in
            make.centerY.equalTo(view.snp.centerY).offset(-30)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(320)
        }
        
        tipImgView.snp.makeConstraints { (make) in
            make.top.equalTo(tipView.snp.top).offset(50)
            make.centerX.equalTo(view.snp.centerX)
            make.width.height.equalTo(60)
        }
        
        getLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tipImgView.snp.bottom).offset(20)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(tipView.snp.width)
            make.height.equalTo(40)
        }
        
        addressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(getLabel.snp.bottom).offset(0)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(tipView.snp.width)
            make.height.equalTo(40)
        }
        
        copyButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(tipView.snp.bottom).offset(-30)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(tipView.snp.width).inset(20)
            make.height.equalTo(50)
        }
    }
    
    @objc private func didTapCopy() {
        tipView.isHidden = true
        UIPasteboard.general.string = copyAddressStr
        setupToast()
    }
}

extension AllWithdrawalRecordViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = viewModel.model[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: AllWithdrawalRecordViewCell.identifier, for: indexPath) as! AllWithdrawalRecordViewCell
        cell.configure(with: vm)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.height / 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tipView.isHidden = false
        let vm = viewModel.model[indexPath.row]
        self.addressLabel.text = vm.address
        self.copyAddressStr = vm.address
    }
    
}
