//
//  WalletDetailViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/12.
//

import UIKit
import RxSwift
import RxCocoa

protocol WalletDetailDelegate: AnyObject {
    func walletDetail()
}

class WalletDetailViewController: UIViewController, UINavigationControllerDelegate {
    var model: WalletAssets?
    lazy var titles: String = ""
    var delegate: WalletDetailDelegate?
    private let assetsView = BaseView(color: #colorLiteral(red: 0.9960784314, green: 1, blue: 0.9960784314, alpha: 1))
    private lazy var titleLabel = BaseLabel(text: titles+" 總資產", color: #colorLiteral(red: 0.9618712068, green: 0.6518303752, blue: 0.1338117421, alpha: 1), font: .boldSystemFont(ofSize: 18), alignments: .left)
    private let totalLabel = BaseLabel(text: "0.00", color: .black, font: .boldSystemFont(ofSize: 36), alignments: .left)
    private let useAssetLabel = BaseLabel(text: "可用資產", color: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .boldSystemFont(ofSize: 14), alignments: .left)
    private let useAssetValueLabel = BaseLabel(text: "0.00", color: #colorLiteral(red: 0.1759438217, green: 0.2006054223, blue: 0.2346534729, alpha: 1), font: .boldSystemFont(ofSize: 18), alignments: .left)
    private let unuseAssetLabel = BaseLabel(text: "下單凍結", color: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .boldSystemFont(ofSize: 14), alignments: .left)
    private let unuseAssetValueLabel = BaseLabel(text: "0.00", color: #colorLiteral(red: 0.1759438217, green: 0.2006054223, blue: 0.2346534729, alpha: 1), font: .boldSystemFont(ofSize: 18), alignments: .left)
    private let listTitleLabel = BaseLabel(text: "交易市場", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .boldSystemFont(ofSize: 14), alignments: .left)
    private let listPriceLabel = BaseLabel(text: "最新價", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .boldSystemFont(ofSize: 14), alignments: .left)
    private let listPersentLabel = BaseLabel(text: "24h 漲幅", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .boldSystemFont(ofSize: 14), alignments: .left)
    
    let layerTopView = BaseView(color: #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1))
    let layerCenterView = BaseView(color: #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1))
    let layerBottomView = BaseView(color: #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1))
    let buttonContainerView = BaseView(color: #colorLiteral(red: 0.9762050509, green: 0.976318419, blue: 0.9761529565, alpha: 1))
    let walletListDetailView = BaseView(color: .white)
    let walletListTopView = BaseView(color: #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1))
    let walletListBottomView = BaseView(color: #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1))
    
    private let depositButton: UIButton = {
        let button = UIButton()
        button.setTitle("存入", for: .normal)
        button.setTitleColor( #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = #colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.9358595014, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapDeposit), for: .touchUpInside)
        return button
    }()
    
    private let withdrawalButton: UIButton = {
        let button = UIButton()
        button.setTitle("提領", for: .normal)
        button.setTitleColor( #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = #colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.9358595014, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapWithdrawal), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tab = UITableView()
        tab.register(WalletDetailViewCell.self, forCellReuseIdentifier: WalletDetailViewCell.identifier)
        tab.dataSource = self
        tab.delegate = self
        tab.separatorColor = .clear
        tab.tableFooterView = UIView()
        tab.rowHeight = 70
        return tab
    }()
    
    private lazy var gaTipView = WithdrawalToastView(img: toastImg, titleLabel: toastTitleLabel, detailLabel: toastDetailLabel, buttonTitle: "我已瞭解", action: #selector(tapToBindingGA), vc: self)
    private let toastImg = BaseImageView(image: "No", color: nil)
    private let toastTitleLabel = BaseLabel(text: "您尚未綁定 2FA", color: .white, font: .systemFont(ofSize: 22, weight: .regular), alignments: .center)
    private let toastDetailLabel = BaseLabel(text: "請至 帳戶 > 安全驗證 > 綁定谷歌驗證器", color: .white, font: .systemFont(ofSize: 13, weight: .regular), alignments: .center)
    
    private var userInfoVM = UserInfoViewModel()
    var viewModel = WalletDetailViewModel()
    var depositVM = DepositViewModel()
    var depositAddressModel = [ChainDetail]()
    private let disposeBag = DisposeBag()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        self.title = titles
        backToPriviousController()
        binding()
        bindingDepositVM()
        setupUI()
        setupLabelDetail()
        bindingGA()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Helpers
    func binding() {
        LoadingView.shared.showLoader()
        viewModel.getChangeAndPriceList(coinname: titles) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            LoadingView.shared.hideLoader()
        }
    }
    
    private func bindingGA() {
        
        if let token = userDefaults.string(forKey: "UserToken")  {
            let param = "token=\(token)"
            userInfoVM.getUserInfo(param: param) { _ in }
            
            userInfoVM.userGAStatus
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] gaStatus in
                    if !gaStatus {
                        self?.gaTipView.isHidden = false
                    }
                }).disposed(by: disposeBag)
            
        }
    }
    
    func bindingDepositVM() {
        LoadingView.shared.showLoader()
        guard let token = userDefaults.string(forKey: "UserToken")  else { return }
        let param = "coinname=\(titles.lowercased())&token=\(token)"
        depositVM.getMyAddrByCoinNameNew(apiURL: APIPath.getMyAddrByCoinNameNew.value, param: param) { [weak self] result in
            self?.depositAddressModel = result
            LoadingView.shared.hideLoader()
        }
    }
    
    func setupLabelDetail() {
//        guard let total = (model!.amount as NSString).doubleValue else { return }
        self.totalLabel.text = (model!.amount as NSString).doubleValue.toString(maxF: 8)
        self.useAssetValueLabel.text = (model!.num as NSString).doubleValue.toString(maxF: 8)
        self.unuseAssetValueLabel.text = (model!.numd as NSString).doubleValue.toString(maxF: 8)
        self.gaTipView.isHidden = true
    }
    
    private func setupUI() {
        view.addSubViews(assetsView, walletListDetailView, tableView, gaTipView)
        assetsView.addSubViews(titleLabel,
                               totalLabel,
                               layerTopView,
                               layerCenterView,
                               layerBottomView,
                               useAssetLabel,
                               useAssetValueLabel,
                               unuseAssetLabel,
                               unuseAssetValueLabel,
                               buttonContainerView
        )
        
        buttonContainerView.addSubViews(depositButton, withdrawalButton)
        walletListDetailView.addSubViews(listTitleLabel,
                                         walletListTopView,
                                         walletListBottomView,
                                         listPriceLabel,
                                         listPersentLabel)
        
        assetsView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(assetsView.snp.top).offset(30)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        
        layerTopView.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        layerCenterView.snp.makeConstraints { make in
            make.top.equalTo(layerTopView.snp.bottom)
            make.centerX.equalTo(assetsView.snp.centerX)
            make.width.equalTo(1)
            make.height.equalTo(80)
        }
        
        layerBottomView.snp.makeConstraints { make in
            make.top.equalTo(layerCenterView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        useAssetLabel.snp.makeConstraints { make in
            make.top.equalTo(layerTopView.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(15)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        useAssetValueLabel.snp.makeConstraints { make in
            make.top.equalTo(useAssetLabel.snp.bottom)
            make.left.equalTo(view.snp.left).offset(15)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalTo(30)
        }
        
        unuseAssetLabel.snp.makeConstraints { make in
            make.top.equalTo(layerTopView.snp.bottom).offset(10)
            make.left.equalTo(layerCenterView.snp.left).offset(15)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalTo(30)
        }
        
        unuseAssetValueLabel.snp.makeConstraints { make in
            make.top.equalTo(unuseAssetLabel.snp.bottom)
            make.left.equalTo(layerCenterView.snp.left).offset(15)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalTo(30)
        }
        
        buttonContainerView.snp.makeConstraints { make in
            make.top.equalTo(layerBottomView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(assetsView.snp.bottom)
        }
        
        depositButton.snp.makeConstraints { make in
            make.centerY.equalTo(buttonContainerView.snp.centerY)
            make.left.equalTo(useAssetLabel.snp.left)
            make.right.equalTo(layerCenterView.snp.left).offset(-15)
            make.height.equalTo(buttonContainerView.snp.height).multipliedBy(0.55)
        }
        
        withdrawalButton.snp.makeConstraints { make in
            make.centerY.equalTo(buttonContainerView.snp.centerY)
            make.left.equalTo(layerCenterView.snp.right).offset(15)
            make.right.equalTo(view.snp.right).offset(-15)
            make.height.equalTo(buttonContainerView.snp.height).multipliedBy(0.55)
        }
        
        walletListDetailView.snp.makeConstraints { make in
            make.top.equalTo(assetsView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        listTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(walletListDetailView.snp.centerY)
            make.left.equalTo(walletListDetailView.snp.left).offset(15)
            make.width.equalTo(walletListDetailView.snp.width).multipliedBy(0.33)
            make.height.equalTo(walletListDetailView.snp.height)
        }
        
        walletListTopView.snp.makeConstraints { make in
            make.top.equalTo(walletListDetailView.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        walletListBottomView.snp.makeConstraints { make in
            make.bottom.equalTo(walletListDetailView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        listPriceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(walletListDetailView.snp.centerY)
            make.left.equalTo(listTitleLabel.snp.right)
            make.width.equalTo(walletListDetailView.snp.width).multipliedBy(0.33)
            make.height.equalTo(walletListDetailView.snp.height)
        }
        
        listPersentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(walletListDetailView.snp.centerY)
            make.left.equalTo(listPriceLabel.snp.right)
            make.width.equalTo(walletListDetailView.snp.width).multipliedBy(0.33)
            make.height.equalTo(walletListDetailView.snp.height)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(walletListDetailView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
        
        gaTipView.snp.makeConstraints {
            $0.center.equalTo(view.snp.center)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(view.snp.height).multipliedBy(0.33)
        }
        
        depositButton.setBackgroundColor(#colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1), forState: .highlighted)
        depositButton.setTitleColor(.white, for: .highlighted)
        withdrawalButton.setBackgroundColor(#colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1), forState: .highlighted)
        withdrawalButton.setTitleColor(.white, for: .highlighted)
    }
    
    // MARK: - Selector
    @objc private func didTapDeposit() {
        let controller = DepositViewController()
        controller.coinType = titles
        LoadingView.shared.showLoader()
        controller.depositAddressModel = self.depositAddressModel
        LoadingView.shared.hideLoader()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func didTapWithdrawal() {
        let controller = WithdrawalViewController()
        controller.delegate = self
        controller.coinType = self.titles
        controller.useAmoumt = self.useAssetValueLabel.text
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func tapToBindingGA() {
        print("tapToBindingGA")
        self.gaTipView.isHidden = true
    }
}


extension WalletDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = viewModel.model[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: WalletDetailViewCell.identifier, for: indexPath) as! WalletDetailViewCell
        cell.configure(with: vm)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let vm = viewModel.model[indexPath.row]
        userDidSelectedPair = vm.symbol
        let controller = createNavController(vc: ExchangePairViewController(), title: vm.symbol.uppercased(), image: nil, selectedImage: nil, tag: 1)
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
    
    
    
}

extension WalletDetailViewController: WithdrawalDelegate {
    func withdrawalResult() {
        self.navigationController?.popViewController(animated: false)
        self.delegate?.walletDetail()
    }
    
    
}
