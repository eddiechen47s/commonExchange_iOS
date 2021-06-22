//
//  TransactionViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/9.
//

import UIKit
import RxSwift
import RxCocoa

class TransactionViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var selectedStyle = 0
    var balanceVM = AccountBalanceViewModel() //餘額
    var transactionRecentOrderVM = TransactionRecentOrderViewModel() //當前訂單
    var latestPriceViewModel = LatestPirceViewModel() //最新價格
    var buySellViewModel = BuySellViewModel()
    var tradeStyleIndex: Int = 0 // 買入/賣出 status
    var accountBalance: Double = 0 // 餘額
    
    private let scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.backgroundColor = .clear
        scrollview.showsVerticalScrollIndicator = false
        return scrollview
    }()
    
    private let contentView = BaseView(color: .white)
    
    private let tradeDetailView = BaseView(color: .clear)
    var lastesUsdPrice: String = "1,830.455"
    var amountToUsd: String = "1,700.388"
    
    private let amountLabel = BaseLabel(text: "數量", color: #colorLiteral(red: 0.5882352941, green: 0.5882352941, blue: 0.5882352941, alpha: 1), font: .systemFont(ofSize: 15, weight: .bold), alignments: .center)
    private let priceLabel = BaseLabel(text: "價格", color: #colorLiteral(red: 0.5882352941, green: 0.5882352941, blue: 0.5882352941, alpha: 1), font: .systemFont(ofSize: 15, weight: .bold), alignments: .center)
    private let cycptoAmountLabel = BaseLabel(text: "cycptoAmount", color: #colorLiteral(red: 0.5882352941, green: 0.5882352941, blue: 0.5882352941, alpha: 1), font: .systemFont(ofSize: 14, weight: .medium), alignments: .left)
    private let cycptoPriceLabel = BaseLabel(text: "cycptoPrice", color: #colorLiteral(red: 0.5882352941, green: 0.5882352941, blue: 0.5882352941, alpha: 1), font: .systemFont(ofSize: 14, weight: .medium), alignments: .right)
    private let latestPriceLabel = BaseLabel(text: "", color: .black, font: .systemFont(ofSize: 20, weight: .bold), alignments: .center)
    private let accountBalanceLabel = BaseLabel(text: "", color: .systemGray, font: .systemFont(ofSize: 14, weight: .regular), alignments: .right)
    private let recentOrderLabel = BaseLabel(text: "當前訂單", color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), font: .systemFont(ofSize: 20, weight: .regular), alignments: .left)
    
    private let tradeSellViewController = TradeSellViewController()
    private let tradeBuyViewController = TradeBuyViewController()
    private let tradeStyleViewController = TradeStyleViewController()
    private lazy var pricePercentViewController = PricePercentViewController(type: self.selectedStyle)
    
    private let priceTextField = UITextField()
    private let amountTextField = UITextField()
    private let totalCoinTextField = UITextField()
    
    private lazy var priceTextFieldView = BaseTextFieldView(textField: priceTextField, placeholder: "價格 (USTD)")
    private lazy var amountTextFieldView = BaseTextFieldView(textField: amountTextField, placeholder: "數量 (ETH)")
    private lazy var totalCoinTextFieldView = BaseTextFieldView(textField: totalCoinTextField, placeholder: "總額 (TWD)")
    
    private let confirmButton = BaseButton(title: "買入", titleColor: .white, font: .systemFont(ofSize: 20, weight: .bold), backgroundColor: #colorLiteral(red: 0.2776432037, green: 0.6590948701, blue: 0.4378901124, alpha: 1))
    
    private let recentView = BaseView(color: .white)
    private let recentBottomView = BaseView(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
    private let pairsLabel = BaseLabel(text: "交易對 / 價格", color: #colorLiteral(red: 0.3921568627, green: 0.3921568627, blue: 0.3921568627, alpha: 1), font: .systemFont(ofSize: 15, weight: .regular), alignments: .left)
    private let typeLabel = BaseLabel(text: "數量 / 總額", color: #colorLiteral(red: 0.3921568627, green: 0.3921568627, blue: 0.3921568627, alpha: 1), font: .systemFont(ofSize: 14, weight: .regular), alignments: .right)
    
    private lazy var kycToastView = KYCStatusToastView(img: toastWarningImg, titleLabel: toastTitleLabel, detailLabel: toastDetailLabel, leftBtnTitle: "我已瞭解，稍後綁定", rightBtnTitle: "前往綁定", lefeBtnAction: #selector(didTapWait), rightBtnAction: #selector(didTapTobindingKYC), vc: self)
    private let toastWarningImg = BaseImageView(image: "ic_warning", color: nil)
    private let toastTitleLabel = BaseLabel(text: "請注意", color: .white, font: .systemFont(ofSize: 22, weight: .regular), alignments: .center)
    private let toastDetailLabel = BaseLabel(text: "未完成A Class（KYC）驗證，不可進行交易", color: .white, font: .systemFont(ofSize: 13, weight: .regular), alignments: .center)
    
    private lazy var tableView: UITableView = {
        let tab = UITableView(frame: .zero, style: .plain)
        tab.backgroundColor = .clear
        tab.register(TransactionRecentOrderViewCell.self, forCellReuseIdentifier: TransactionRecentOrderViewCell.identifier)
        tab.delegate = self
        tab.dataSource = self
        tab.tableFooterView = UIView()
        tab.rowHeight = 60
        tab.isScrollEnabled = false
        tab.showsVerticalScrollIndicator = false
        return tab
    }()
    private var userInfoVM = UserInfoViewModel()

    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bindingLatestPirce()
        setupUI()
       
        setupUserSelectedPair()
        bindingRecentOrder()
        bindingSell()
        bindingBuy()
        setupDetail()
        bindingTradeStyle()
        bindingTFText()
        setupKVCView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindingTextField()
    }
    
    deinit {
        print("TransactionViewController deinit")
    }
    
    // MARK: - Helpers
    private func setupKVCView() {
        if let token = userDefaults.string(forKey: "UserToken")  {
            let param = "token=\(token)"
            userInfoVM.getUserInfo(param: param) { [weak self] (result) in
                print(result)
                if result.count > 0 {
                    DispatchQueue.main.async {
                        DispatchQueue.main.async {
                            if result[2] == "A" && result[3] == "3" {
                                self?.kycToastView.isHidden = true
                            } else {
                                self?.kycToastView.isHidden = false
                            }
                        }
                    }
                }
            }
        }

    }
    
    private func bindingTFText() {
        pricePercentViewController.selectedIndex
            .subscribe(onNext: { [weak self] index in
                let indexPercent = Int(index)
                guard let priceTF = self?.priceTextField.text else { return }
                let price = (priceTF as NSString).doubleValue
                switch indexPercent {
                case 0:
                    let total = (self!.accountBalance*0.25)
                    self?.totalCoinTextField.text = total.toString(maxF:2)
                    if self?.priceTextField.text != "" {
                        self?.amountTextField.text = (total/price).toString(maxF:2)
                    }
                case 1:
                    let total = (self!.accountBalance*0.5)
                    self?.totalCoinTextField.text = total.toString(maxF:2)
                    if self?.priceTextField.text != "" {
                        self?.amountTextField.text = (total/price).toString(maxF:2)
                    }
                case 2:
                    let total = (self!.accountBalance*0.75)
                    self?.totalCoinTextField.text = total.toString(maxF:2)
                    if self?.priceTextField.text != "" {
                        self?.amountTextField.text = (total/price).toString(maxF:2)
                    }
                case 3:
                    let total = (self!.accountBalance*1)
                    self?.totalCoinTextField.text = total.toString(maxF:2)
                    if self?.priceTextField.text != "" {
                        self?.amountTextField.text = (total/price).toString(maxF:2)
                    }
                default:
                    break
                }
            }).disposed(by: disposeBag)
    }
    
    private func bindingTradeStyle() {
        tradeStyleViewController.tradeStyleIndex
            .subscribe(onNext: { [weak self] index in
                self?.tradeStyleIndex = index
                if index == 0 {
                    self?.confirmButton.setTitle("買入", for: .normal)
                    self?.confirmButton.backgroundColor = #colorLiteral(red: 0.2776432037, green: 0.6590948701, blue: 0.4378901124, alpha: 1)
                } else {
                    self?.confirmButton.setTitle("賣出", for: .normal)
                    self?.confirmButton.backgroundColor = #colorLiteral(red: 0.9601823688, green: 0.2764334977, blue: 0.3656736016, alpha: 1)
                }
            }).disposed(by: disposeBag)
    }
    
    private func setupDetail() {
        priceTextField.delegate = self
        amountTextField.delegate = self
        totalCoinTextField.delegate = self
        
        self.priceTextField.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                      for: .editingChanged)
        self.amountTextField.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                       for: .editingChanged)
        self.confirmButton.addTarget(self, action: #selector(didTapBuy), for: .touchUpInside)
        let userTapPair = userDidSelectedPair.replacingOccurrences(of: " / ", with: "_")
        let pairPrefix = String(userTapPair.uppercased().split(separator: "_")[0])
        let pairSuffix = String(userTapPair.uppercased().split(separator: "_")[1])
        self.cycptoAmountLabel.text = "(\(pairPrefix))"
        self.cycptoPriceLabel.text = "(\(pairSuffix))"
        self.priceTextField.placeholder = "價格 (\(pairSuffix))"
        self.amountTextField.placeholder = "數量 (\(pairPrefix))"
        self.totalCoinTextField.placeholder = "總額 (\(pairSuffix))"
        self.kycToastView.isHidden = true
    }
    
    func bindingRecentOrder() {
        let market = userDidSelectedPair
        transactionRecentOrderVM.getRecentOrder(market: market) {
            print(self.transactionRecentOrderVM.model.count)
            let dataCount: CGFloat = CGFloat(self.transactionRecentOrderVM.model.count*60)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                if (self.scrollView.frame.height-self.tableView.frame.height)+(dataCount)+100 < 1000 {
                    self.scrollView.contentSize = CGSize(width: self.view.bounds.width, height: 1000)
                } else {
                    self.scrollView.contentSize = CGSize(width: self.view.bounds.width, height: (self.scrollView.frame.height-self.tableView.frame.height)+(dataCount)+100)
                }
           
            }
        }
    }
    
    func bindingSell() {
        tradeSellViewController.userDidSelectedPrice
            .subscribe(onNext: { [weak self] price in
                self?.priceTextField.text = price
                
                guard let amount = self?.amountTextField.text,
                      let price = self?.priceTextField.text,
                      price != "" else {
                    return
                }
                let amounts = (amount as NSString).doubleValue
                let pricess = (price as NSString).doubleValue
                let total = amounts*pricess
                self?.totalCoinTextField.text = total.toString(maxF: 4)
            }).disposed(by: disposeBag)
    }
    
    func bindingBuy() {
        tradeBuyViewController.userDidSelectedPrice
            .subscribe(onNext: { [weak self] price in
                self?.priceTextField.text = price
                
                guard let amount = self?.amountTextField.text,
                      let price = self?.priceTextField.text,
                      price != "" else {
                    return
                }
                let amounts = (amount as NSString).doubleValue
                let pricess = (price as NSString).doubleValue
                let total = amounts*pricess
                self?.totalCoinTextField.text = total.toString(maxF: 4)
            }).disposed(by: disposeBag)
    }
    
    func bindingBalance(symbol: String) {
        guard let token = userDefaults.string(forKey: "UserToken") else {
            return
        }
        let param = "coinName=\(symbol)&token=\(token)"
        LoadingView.shared.showLoader()
        
        balanceVM.accountBalance(apiURL: APIPath.getUserCoinNum.value, param: param) { [weak self] price in
            DispatchQueue.main.async {
                self?.accountBalance = price
                let userTapPair = userDidSelectedPair.replacingOccurrences(of: " / ", with: "_")

                let pairSuffix = String(userTapPair.uppercased().split(separator: "_")[1])

                self?.accountBalanceLabel.text = String(price.toString(maxF:2))+" \(pairSuffix)"+" 餘額"
                self?.bindingLatestPirce()
            }
            
            LoadingView.shared.hideLoader()
        }
    }
    
    func setupUserSelectedPair() {
        print(userDidSelectedPair)
        let replacePair = userDidSelectedPair.replacingOccurrences(of: " / ", with: "_")
        let pair = replacePair.split(separator: "_")[1]
        bindingBalance(symbol: String(pair))
    }
    
    func bindingLatestPirce() {
        let param = "symbol="+userDidSelectedPair
        LoadingView.shared.showLoader()
        latestPriceViewModel.latestPrice(apiURL: APIPath.getMarketNewestPrice.value, param: param) { price in
            DispatchQueue.main.async {
                self.latestPriceLabel.text = price
                self.priceTextField.text = price
            }
            LoadingView.shared.hideLoader()
        }
    }
    
    func bindingTextField() {
        tradeStyleViewController.didSelectedIndex
            .subscribe(onNext: { [weak self] index in
                self?.teadeStyleSelected(index: index)
                self?.selectedStyle = index
                
                DispatchQueue.main.async {
                    print(index)
                    if index == 1 {
                        if self?.amountTextField.text == "" &&
                            self?.amountTextField.text == "" &&
                            self?.amountTextField.text == "" {
                            self?.priceTextField.textColor = .systemRed
                            self?.amountTextField.textColor = .systemRed
                        } else {
                            self?.confirmButton.backgroundColor = .systemRed
                        }
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func teadeStyleSelected(index: Int) {
        self.amountTextField.text = ""
        self.priceTextField.text = ""
        self.totalCoinTextField.text = ""
        self.priceTextField.font = .systemFont(ofSize: 15, weight: .regular)
        self.amountTextField.font = .systemFont(ofSize: 15, weight: .regular)
        
        if index == 0 {
            self.amountTextField.textColor = #colorLiteral(red: 0.2776432037, green: 0.6590948701, blue: 0.4378901124, alpha: 1)
            self.priceTextField.textColor = #colorLiteral(red: 0.2776432037, green: 0.6590948701, blue: 0.4378901124, alpha: 1)
            self.totalCoinTextField.textColor = #colorLiteral(red: 0.2776432037, green: 0.6590948701, blue: 0.4378901124, alpha: 1)
            self.accountBalanceLabel.textColor = #colorLiteral(red: 0.2776432037, green: 0.6590948701, blue: 0.4378901124, alpha: 1)
            self.confirmButton.backgroundColor = #colorLiteral(red: 0.2776432037, green: 0.6590948701, blue: 0.4378901124, alpha: 1)
        } else {
            self.amountTextField.textColor = #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1)
            self.priceTextField.textColor = #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1)
            self.totalCoinTextField.textColor = .systemRed
            self.accountBalanceLabel.textColor = .systemRed
        }
        self.pricePercentViewController.type = index
        DispatchQueue.main.async {
            self.pricePercentViewController.collectionView.reloadData()
        }
    }
    
    private func setupUI() {
        view.addSubViews(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubViews(tradeDetailView, // 買入/賣出 topVioew
                                tradeSellViewController.view, // 賣出畫面->tableView
                                latestPriceLabel, // 最新價格
                                tradeBuyViewController.view, // 買入畫面->tableView
                                tradeStyleViewController.view, // 買入/賣出 畫面
                                priceTextFieldView, // 價格 textField
                                amountTextFieldView, // 數量 textField
                                pricePercentViewController.view, // 百分比
                                accountBalanceLabel, // 餘額 Label
                                totalCoinTextFieldView, //總額 textField
                                confirmButton, // 買入/賣出 Button
                                recentOrderLabel, // 當前訂單 Label,
                                recentView, // 當前訂單 標題列
                                tableView, // 當前訂單
                                kycToastView // 登入時 AClass 未通過驗證
        )
        
        addChild(tradeSellViewController)
        tradeSellViewController.didMove(toParent: self)
        
        addChild(tradeBuyViewController)
        tradeBuyViewController.didMove(toParent: self)
        
        addChild(tradeStyleViewController)
        tradeStyleViewController.didMove(toParent: self)
        
        addChild(pricePercentViewController)
        pricePercentViewController.didMove(toParent: self)
        
        tradeDetailView.addSubViews(cycptoAmountLabel,
                                    cycptoPriceLabel,
                                    amountLabel,
                                    priceLabel
        )
        recentView.addSubViews(pairsLabel,
                               typeLabel,
                               recentBottomView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.snp.width)
            make.height.equalTo(1000)
        }
        
        tradeDetailView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(view.snp.left).offset(10)
            make.width.equalTo(view.snp.width).multipliedBy(0.45)
            make.height.equalTo(60)
        }
        
        cycptoAmountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(tradeDetailView.snp.bottom)
            make.left.equalTo(tradeDetailView.snp.left).offset(10)
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
        
        cycptoPriceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(tradeDetailView.snp.bottom)
            make.right.equalTo(tradeDetailView.snp.right).offset(-10)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.left.equalTo(tradeDetailView.snp.left).offset(1)
            make.bottom.equalTo(cycptoAmountLabel.snp.top)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.right.equalTo(tradeDetailView.snp.right).offset(-1)
            make.bottom.equalTo(cycptoPriceLabel.snp.top)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        tradeSellViewController.view.snp.makeConstraints { make in
            make.top.equalTo(tradeDetailView.snp.bottom).offset(1)
            make.left.right.equalTo(tradeDetailView).inset(5)
            make.height.equalTo(150)
        }
        
        latestPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(tradeSellViewController.view.snp.bottom).offset(5)
            make.centerX.equalTo(tradeSellViewController.view.snp.centerX)
            make.width.equalTo(tradeDetailView.snp.width)
            make.height.equalTo(40)
        }
        
        tradeBuyViewController.view.snp.makeConstraints { make in
            make.top.equalTo(latestPriceLabel.snp.bottom).offset(1)
            make.left.right.equalTo(tradeDetailView).inset(5)
            make.height.equalTo(150)
        }
        
        tradeStyleViewController.view.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.top)
            make.right.equalTo(view.snp.right).offset(-10)
            make.width.equalTo(view.snp.width).multipliedBy(0.47)
            make.height.equalTo(35)
        }
        
        priceTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(tradeStyleViewController.view.snp.bottom).offset(30)
            make.left.right.equalTo(tradeStyleViewController.view)
            make.height.equalTo(40)
        }
        
        amountTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(priceTextFieldView.snp.bottom).offset(15)
            make.left.right.equalTo(tradeStyleViewController.view)
            make.height.equalTo(40)
        }
        
        pricePercentViewController.view.snp.makeConstraints { make in
            make.top.equalTo(amountTextFieldView.snp.bottom).offset(30)
            make.left.right.equalTo(amountTextFieldView)
            make.height.equalTo(30)
        }
        
        accountBalanceLabel.snp.makeConstraints { make in
            make.top.equalTo(pricePercentViewController.view.snp.bottom).offset(10)
            make.right.equalTo(amountTextFieldView.snp.right)
            make.width.height.equalTo(pricePercentViewController.view)
        }
        
        totalCoinTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(accountBalanceLabel.snp.bottom).offset(10)
            make.left.right.equalTo(amountTextFieldView)
            make.height.equalTo(40)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(totalCoinTextFieldView.snp.bottom).offset(20)
            make.left.right.equalTo(amountTextFieldView)
            make.height.equalTo(45)
        }
        
        recentOrderLabel.snp.makeConstraints { make in
            make.top.equalTo(tradeBuyViewController.view.snp.bottom).offset(20)
            make.left.equalTo(amountLabel.snp.left)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        
        recentView.snp.makeConstraints { make in
            make.top.equalTo(recentOrderLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        pairsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(recentView.snp.centerY)
            make.left.equalTo(recentView.snp.left).offset(20)
            make.width.equalTo(recentView.snp.width).multipliedBy(0.5)
            make.height.equalToSuperview()
        }
        
        typeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(recentView.snp.centerY)
            make.right.equalTo(recentView.snp.right).offset(-20)
            make.width.equalTo(recentView.snp.width).multipliedBy(0.4)
            make.height.equalToSuperview()
        }
        
        recentBottomView.snp.makeConstraints { make in
            make.bottom.equalTo(recentView.snp.bottom)
            make.left.right.equalTo(recentView)
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(recentView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        kycToastView.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY).offset(-50)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(view.snp.height).multipliedBy(0.37)
        }
    }
    
    func bindingBuySell(status: Int) {
        let pair = userDidSelectedPair
        guard let token = userDefaults.string(forKey: "UserToken"),
              let price = self.priceTextField.text,
              let amount = self.amountTextField.text else {
            return
        }
        
        let param = "name=\(pair)&price=\(price)&num=\(amount)&type=\(status)&token=\(token)"
        buySellViewModel.tradeTobuyOrSell(param: param) { [weak self] result in
            print(result)
            if result {
                DispatchQueue.main.async {
                    self?.priceTextField.text = ""
                    self?.amountTextField.text = ""
                    self?.totalCoinTextField.text = ""
                    self?.bindingRecentOrder()
                }
            } else {
                
            }
        }
    }
    
    // MARK: - Selector
    @objc func textFieldDidChange(_ textField: UITextField) {
        let priceText = self.priceTextField.text
        let amountText = self.amountTextField.text
        let price = (priceText! as NSString).doubleValue
        let amount = (amountText! as NSString).doubleValue
        let total = (price*amount).toString()
        
        switch textField {
        case self.priceTextField:
            self.totalCoinTextField.text = total
        case self.amountTextField:
            self.totalCoinTextField.text = total
        default:
            break
        }
    }
    
    @objc private func didTapBuy() {
        print("提交")
        guard let total = self.totalCoinTextField.text,
              let price = self.priceTextField.text,
              let amount = self.amountTextField.text,
              total != "",
              price != "",
              amount != ""
        else {
            return
        }
        DispatchQueue.main.async {
            if self.tradeStyleIndex == 0 {
                self.bindingBuySell(status: 1)
            } else {
                self.bindingBuySell(status: 2)
            }
        }
    }
    
    @objc private func didTapWait() {
        self.kycToastView.isHidden = true
    }
    
    @objc private func didTapTobindingKYC() {
        print("didTapTobindingKYC")
        let controller = UserIdentifyViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
extension TransactionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionRecentOrderVM.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionRecentOrderViewCell.identifier, for: indexPath) as? TransactionRecentOrderViewCell else {
            fatalError("TransactionViewCell nil")
        }
        let vm = transactionRecentOrderVM.model[indexPath.row]
        cell.configure(with: vm)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}

extension TransactionViewController: UITextFieldDelegate {
    
    
}

