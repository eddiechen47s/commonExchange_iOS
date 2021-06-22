//
//  InternalTransferViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/20.
//

import UIKit

class InternalTransferViewController: UIViewController {
    private var addressValue = ""
    private let topView = BaseView(color: .white)
    private let bottomlineView = BaseView(color: #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1))
    private let pairsLabel = BaseLabel(text: "幣種 類型/時間", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 15, weight: .medium), alignments: .left)
    private let accountLabel = BaseLabel(text: "帳號", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 15, weight: .medium), alignments: .right)
    private let amountLabel = BaseLabel(text: "數量/狀態", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 15, weight: .medium), alignments: .right)
    var viewModel = InternalTransferViewModel()
    
    private lazy var tableView: UITableView = {
        let tab = UITableView()
        tab.backgroundColor = .white
        tab.separatorColor = .clear
        tab.tableFooterView = UIView()
        tab.dataSource = self
        tab.delegate = self
        tab.isEditing = false
        tab.showsVerticalScrollIndicator = false
        tab.register(InternalTransferViewCell.self, forCellReuseIdentifier: InternalTransferViewCell.identifier)
        return tab
    }()
    
    var tipView = BaseView(color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1))
    private let tipImgView = BaseImageView(image: "InternalTransfer-Icon", color: nil)
    private let getLabel = BaseLabel(text: "轉帳至", color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: .systemFont(ofSize: 24, weight: .medium), alignments: .center)
    private let addressLabel = BaseLabel(text: "jingluntech@gmail.com", color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: .systemFont(ofSize: 14, weight: .medium), alignments: .center)
    private let copyButton: UIButton = {
        let button = UIButton()
        button.setTitle("複製帳號", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapCopy), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "內部轉帳記錄"
        
        setupUI()
        binding()
    }
    
    // MARK: - Helpers
    func binding() {
        if userDefaults.bool(forKey: "isUserLogin") {
            LoadingView.shared.showLoader()
            viewModel.getInternalInOutList {
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
                            accountLabel,
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
            make.width.equalTo(topView.snp.width).multipliedBy(0.3)
            make.height.equalTo(topView.snp.height)
        }
        
        accountLabel.snp.makeConstraints { make in
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
        UIPasteboard.general.string = self.addressLabel.text
        setupToast()
    }
}

extension InternalTransferViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = viewModel.model[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: InternalTransferViewCell.identifier, for: indexPath) as! InternalTransferViewCell
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
        self.addressLabel.text = viewModel.model[indexPath.row].address
        if vm.type == 3 {
            self.getLabel.text = "來自"
        } else {
            self.getLabel.text = "轉帳至"
        }
    }
    
}
