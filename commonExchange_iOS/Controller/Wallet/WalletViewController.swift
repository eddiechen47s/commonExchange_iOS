//
//  WalletViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/2/25.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class WalletViewController: UIViewController {
    
    private let walletView = BaseView(color: UIColor(red: 34/255, green: 60/255, blue: 83/255, alpha: 1))
    
    var assert: String = "190.00"
    var viewModel = WalletAssetsViewModel()
    let disposeBag = DisposeBag()
    
    private let titleLabel = BaseLabel(text: "總資產(TWD)", color: .white, font: .systemFont(ofSize: 14, weight: .black), alignments: .left)
    private lazy var assetsLabel = BaseLabel(text: "≈  " + assert + " 萬", color: #colorLiteral(red: 0.9953656793, green: 0.7524673343, blue: 0.1741798222, alpha: 1), font: .systemFont(ofSize: 30, weight: .medium), alignments: .left)
    private lazy var assetsTypeLabel = BaseLabel(text: "", color: .white, font: .systemFont(ofSize: 16, weight: .regular), alignments: .center)
    
    private let detailAssetsView = WalletAssetsHeader()
    
    private lazy var tableView: UITableView = {
        let tab = UITableView(frame: .zero, style: .plain)
        tab.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        tab.register(WalletAssetsViewCell.self, forCellReuseIdentifier: WalletAssetsViewCell.identifier)
        tab.delegate = self
        tab.dataSource = self
        tab.tableFooterView = UIView()
        tab.separatorColor = .clear
        tab.rowHeight = 60
        tab.showsVerticalScrollIndicator = false
        return tab
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        setupNavBar()
        bindingAssetsTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        binding()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Helpers
    func bindingAssetsTitle() {
        viewModel.twdSum
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] twdSum in
                let t = (twdSum as NSString).doubleValue.toString(maxF:6)
                let number = NSNumber(value: (t as NSString).doubleValue)
                let decimal = NumberFormatter.localizedString(from: number, number: .decimal)
                self?.assetsLabel.text = "≈  "+decimal
            }).disposed(by: disposeBag)
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "紀錄", style: .done, target: self, action: #selector(didTapRecord))
    }
        
    private func binding() {
        let apiURL = "userCoin/getMyUserCoinList?"
        guard let token = userDefaults.string(forKey: "UserToken")  else { return }
        let param = "token=\(token)"
        LoadingView.shared.showLoader()
        viewModel.getMyUserCoinList(apiURL: apiURL, param: param) { result in
            if result == "tokenChange" {
                let alert = UIAlertController(title: "錯誤", message: "帳號從其他設備登入過，請重新登入。", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "確定", style: .cancel) { (alert) in
                    self.tabBarController?.selectedIndex = 0
                }
                alert.addAction(cancel)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            LoadingView.shared.hideLoader()
        }
    }

    private func setupUI() {
        view.addSubViews(walletView,
                         detailAssetsView,
                         tableView
        )
        
        walletView.addSubViews(titleLabel,
                               assetsLabel,
                               assetsTypeLabel)
        
        walletView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(walletView.snp.centerY).multipliedBy(0.7)
            make.left.equalTo(walletView.snp.left).offset(20)
            make.width.equalTo(walletView.snp.width)
            make.height.equalTo(30)
        }
        
        assetsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(walletView.snp.left).offset(20)
            make.width.equalTo(walletView.snp.width)
            make.height.equalTo(60)
        }
        
        assetsTypeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(walletView.snp.centerX)
            make.top.equalTo(assetsLabel.snp.bottom).offset(10)
            make.width.equalTo(walletView.snp.width)
            make.height.equalTo(40)
        }
        
        detailAssetsView.snp.makeConstraints { make in
            make.top.equalTo(walletView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(detailAssetsView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    //MARK: - Selector
    @objc func didTapRecord() {
        let controller = RecordViewController()
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension WalletViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = viewModel.model[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: WalletAssetsViewCell.identifier, for: indexPath) as! WalletAssetsViewCell
        cell.configure(with: vm)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let controller = WalletDetailViewController()
        controller.delegate = self
        controller.model = viewModel.model[indexPath.row]
        controller.modalPresentationStyle = .fullScreen
        controller.titles = viewModel.model[indexPath.row].coinname.uppercased()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
}

extension WalletViewController: WalletDetailDelegate {
    func walletDetail() {
        self.navigationController?.popViewController(animated: false)
        self.dismiss(animated: false, completion: nil)
    }
    
    
}
