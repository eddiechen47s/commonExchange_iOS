//
//  WithdrawalViewController.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/4/22.
//

import UIKit
import AVFoundation

protocol WithdrawalDelegate: AnyObject {
    func withdrawalResult()
}

class WithdrawalViewController: UIViewController {
    // 修复侧滑丢失
    var delegate: WithdrawalDelegate?

    private var naDelegate: UIGestureRecognizerDelegate?
    var coinType: String!
    var useAmoumt: String!
    private var isSelectedWithdrawal: Int = 0
    private var isConfirmAddress: Bool = false
    private let withdrawalAddressView = BaseView(color: #colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.9358595014, alpha: 1))
    private let withdrawalAmountView = BaseView(color: #colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.9358595014, alpha: 1))
    private let confirmView = BaseView(color: #colorLiteral(red: 0.9968166947, green: 1, blue: 0.9963441491, alpha: 1))
    private let confirmTopView = BaseView(color: #colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.9358595014, alpha: 1))

    private let withdrawalTextField = BaseTextField(text: "", placeholder: "請輸入地址/會員帳號(Email)")
    private let withdrawalLimitTextField = BaseTextField(text: "", placeholder: "最低 0.001")
    
    private lazy var titleLabel = BaseLabel(text: "提領 \(coinType!.uppercased())", color: #colorLiteral(red: 0.1333333333, green: 0.2352941176, blue: 0.3254901961, alpha: 1), font: .systemFont(ofSize: 30, weight: .bold), alignments: .left)
    private let selectNetLabel = BaseLabel(text: "提領類型", color: #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), font: .systemFont(ofSize: 13, weight: .regular), alignments: .left)
    private lazy var withdrawalButton = WithdrawalButton(title: "提領", textColor: #colorLiteral(red: 0.2099245489, green: 0.2099536657, blue: 0.2099111676, alpha: 1), backgroundColor: #colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.9358595014, alpha: 1), action: #selector(didTapWithdrawal), vc: self)
    private lazy var insideWithdrawalButton = WithdrawalButton(title: "內部提領", textColor: #colorLiteral(red: 0.2099245489, green: 0.2099536657, blue: 0.2099111676, alpha: 1), backgroundColor: #colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.9358595014, alpha: 1), action: #selector(didTapInside), vc: self)
    private let useLimitLabel = BaseLabel(text: "可用額度", color: #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), font: .systemFont(ofSize: 13, weight: .bold), alignments: .left)
    private let limitLabel = BaseLabel(text: "0.2898227739", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 25, weight: .regular), alignments: .left)
    private lazy var limitTitleLabel = BaseLabel(text: "\(coinType!.uppercased())", color: #colorLiteral(red: 0.1333333333, green: 0.2352941176, blue: 0.3254901961, alpha: 1), font: .systemFont(ofSize: 25, weight: .regular), alignments: .right)
    private let withdrawalAddressLabel = BaseLabel(text: "提領地址", color: #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), font: .systemFont(ofSize: 13, weight: .bold), alignments: .left)
    private let withdrawalAmountLabel = BaseLabel(text: "提領數量", color: #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), font: .systemFont(ofSize: 13, weight: .bold), alignments: .left)
    private lazy var withdrawalCoinLabel = BaseLabel(text: "\(coinType!.uppercased())", color: #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), alignments: .right)
    private let feeLabel = BaseLabel(text: "", color: #colorLiteral(red: 0.1333333333, green: 0.2352941176, blue: 0.3254901961, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), alignments: .left)
    private let confirmAddressLabel = BaseLabel(text: "我已確認發送的錢包地址正確。", color: #colorLiteral(red: 0.9618712068, green: 0.6518303752, blue: 0.1338117421, alpha: 1), font: .systemFont(ofSize: 13, weight: .bold), alignments: .left)
    private let withdrawalTitleLabel = BaseLabel(text: "實際到帳數量", color: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 13, weight: .bold), alignments: .left)
    private lazy var withdrawalValueLabel = BaseLabel(text: "0.00", color: #colorLiteral(red: 0.1333333333, green: 0.2352941176, blue: 0.3254901961, alpha: 1), font: .systemFont(ofSize: 18, weight: .bold), alignments: .left)
    private lazy var coinLabel = BaseLabel(text: "\(coinType!.uppercased())", color: #colorLiteral(red: 0.1333333333, green: 0.2352941176, blue: 0.3254901961, alpha: 1), font: .systemFont(ofSize: 14, weight: .bold), alignments: .left)
    
    private let pasteButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "past_icon"), for: .normal)
        button.addTarget(self, action: #selector(didTapPaste), for: .touchUpInside)
        return button
    }()
    
    private let qrcodeScanButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "qrcodeScan_icon"), for: .normal)
        button.addTarget(self, action: #selector(didTapScan), for: .touchUpInside)
        return button
    }()
    
    private let withdrawalMaxButton: UIButton = {
       let button = UIButton()
        button.setTitle("MAX", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9618712068, green: 0.6518303752, blue: 0.1338117421, alpha: 1), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(didTapMax), for: .touchUpInside)
        return button
    }()
    
    private let confirmAddressButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "Path"), for: .normal)
        button.addTarget(self, action: #selector(didTapConfirmAddress), for: .touchUpInside)
        return button
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("提交", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = #colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.9358595014, alpha: 1)
        button.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Toast.
    private let toastTitleLabel = BaseLabel(text: "注意", color: .white, font: .systemFont(ofSize: 24, weight: .bold), alignments: .center)
    private lazy var toastTextView = BaseTextView(text: WithdrawalToast.title.text, textColor: #colorLiteral(red: 0.9968089461, green: 0.9998582006, blue: 0.9968978763, alpha: 1) ,font: .systemFont(ofSize: 12, weight: .regular))
    private lazy var limtToastView = WithdrawalLimitToastView(titleLabel: toastTitleLabel, detailTextView: toastTextView, action: #selector(didTapCheck), vc: self)
    
    private lazy var toastOverLimitView = WithdrawalToastView(img: toastOverLimitImg, titleLabel: toastOverLimitLabel, detailLabel: toastOverLimitDetailLabel, buttonTitle: "返回錢包", action: #selector(didTapBack), vc: self)
    private let toastOverLimitImg = BaseImageView(image: "No", color: nil)

    private let toastOverLimitLabel = BaseLabel(text: "已超過提領限額", color: .white, font: .systemFont(ofSize: 22, weight: .regular), alignments: .center)
    private let toastOverLimitDetailLabel = BaseLabel(text: "您已超過會員等級單筆或24小時之限額", color: .white, font: .systemFont(ofSize: 14, weight: .regular), alignments: .center)
    
    private lazy var toastFailedView = WithdrawalToastView(img: toastFailedImg, titleLabel: toastFTitleLabel, detailLabel: toastFDetailLabel, buttonTitle: "返回錢包", action: #selector(didTapBack), vc: self)
    private let toastFailedImg = BaseImageView(image: "No", color: nil)
    private let toastFTitleLabel = BaseLabel(text: "未完成提交", color: .white, font: .systemFont(ofSize: 22, weight: .regular), alignments: .center)
    private let toastFDetailLabel = BaseLabel(text: "提領提交失敗，請重試", color: .white, font: .systemFont(ofSize: 13, weight: .regular), alignments: .center)

    var withdrawalLimitVM = WithdrawalLimitViewModel() //提領手續費＆最小數量 vm
    var WithdrawalConfirmVM = WithdrawalConfirmViewModel() //提交鍵 vm
    var withdrawalLimitAmount: Double?
    var zc_min: String = ""
    var zc_fee: String = ""
    var realFee: Double = 0
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        backToPriviousController()
        self.title = "提領"
        self.tabBarController?.tabBar.isHidden = true

        setupUI()
        setupUIDetail()
        binding(chain: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 修复侧滑丢失
        naDelegate = navigationController?.interactivePopGestureRecognizer?.delegate
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        if isSelectedWithdrawal == 0 {
            withdrawalButton.setBackgroundColor(#colorLiteral(red: 0.9966385961, green: 0.9765377641, blue: 0.8922813535, alpha: 1), forState: .normal)
            withdrawalButton.setTitleColor(#colorLiteral(red: 0.9766772389, green: 0.7539924979, blue: 0.01549641695, alpha: 1), for: .normal)
            withdrawalButton.layer.borderWidth = 1.5
            withdrawalButton.layer.borderColor = #colorLiteral(red: 0.9766772389, green: 0.7539924979, blue: 0.01549641695, alpha: 1)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 修复侧滑丢失
        navigationController?.interactivePopGestureRecognizer?.delegate = naDelegate
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Helpers
    private func binding(chain: String) {
        let param = "coinname=\(coinType!)" + "\(chain)"
        LoadingView.shared.showLoader()
        // Get min & fee API
        withdrawalLimitVM.getCoinByName(apiURL: APIPath.getCoinByName.value, param: param) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.feeLabel.text = "提領手續費為 " + result.zc_fee + " \(self.coinType!)"
                self.withdrawalLimitTextField.placeholder = "最低 " + result.zc_min
                self.zc_min = "最低 " + result.zc_min
                self.zc_fee = "提領手續費為 " + result.zc_fee + " \(self.coinType!)"
                self.realFee = (result.zc_fee as NSString).doubleValue
                self.withdrawalLimitAmount = Double(result.zc_min)
            }
            LoadingView.shared.hideLoader()
        }
    }
    private func setupUI() {
        view.addSubViews(titleLabel,
                         selectNetLabel,
                         withdrawalButton,
                         insideWithdrawalButton,
                         useLimitLabel,
                         limitLabel,
                         limitTitleLabel,
                         withdrawalAddressLabel,
                         withdrawalAddressView,
                         withdrawalAmountLabel,
                         withdrawalAmountView,
                         feeLabel,
                         confirmAddressButton,
                         confirmAddressLabel,
                         confirmView,
                         limtToastView,
                         toastOverLimitView,
                         toastFailedView
                        )
        withdrawalAddressView.addSubViews(withdrawalTextField, pasteButton, qrcodeScanButton)
        withdrawalAmountView.addSubViews(withdrawalLimitTextField,
                                         withdrawalCoinLabel,
                                         withdrawalMaxButton)
        confirmView.addSubViews(confirmTopView,
                                withdrawalTitleLabel,
                                withdrawalValueLabel,
                                coinLabel,
                                confirmButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.snp.left).offset(15)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalTo(30)
        }
        
        selectNetLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(15)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalTo(30)
        }
        
        withdrawalButton.snp.makeConstraints { make in
            make.top.equalTo(selectNetLabel.snp.bottom).offset(5)
            make.left.equalTo(view.snp.left).offset(15)
            make.right.equalTo(view.snp.centerX).offset(-5)
            make.height.equalTo(35)
        }
        
        insideWithdrawalButton.snp.makeConstraints { make in
            make.top.equalTo(selectNetLabel.snp.bottom).offset(5)
            make.left.equalTo(view.snp.centerX).offset(5)
            make.right.equalTo(view.snp.right).offset(-15)
            make.height.equalTo(35)
        }
        
        useLimitLabel.snp.makeConstraints { make in
            make.top.equalTo(withdrawalButton.snp.bottom).offset(15)
            make.left.equalTo(view.snp.left).offset(15)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalTo(20)
        }
        
        limitLabel.snp.makeConstraints { make in
            make.top.equalTo(useLimitLabel.snp.bottom).offset(5)
            make.left.equalTo(view.snp.left).offset(15)
            make.width.equalTo(view.snp.width).multipliedBy(0.75)
            make.height.equalTo(30)
        }
        
        limitTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(limitLabel.snp.top)
            make.right.equalTo(view.snp.right).offset(-15)
            make.width.equalTo(view.snp.width).multipliedBy(0.3)
            make.height.equalTo(30)
        }
        
        withdrawalAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(limitLabel.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(15)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalTo(20)
        }
        
        withdrawalAddressView.snp.makeConstraints { make in
            make.top.equalTo(withdrawalAddressLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        withdrawalTextField.snp.makeConstraints { make in
            make.centerY.equalTo(withdrawalAddressView.snp.centerY)
            make.left.equalTo(withdrawalAddressView.snp.left).offset(15)
            make.height.equalTo(withdrawalAddressView.snp.height)
            make.width.equalTo(withdrawalAddressView.snp.width).multipliedBy(0.75)
        }
        
        pasteButton.snp.makeConstraints { make in
            make.right.equalTo(qrcodeScanButton.snp.left).offset(0)
            make.centerY.equalTo(withdrawalAddressView.snp.centerY)
            make.width.height.equalTo(40)
        }
        
        qrcodeScanButton.snp.makeConstraints { make in
            make.right.equalTo(withdrawalAddressView.snp.right)
            make.centerY.equalTo(withdrawalAddressView.snp.centerY)
            make.width.equalTo(30)
            make.height.equalTo(withdrawalAddressView.snp.height).multipliedBy(0.7)
        }
        
        withdrawalAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(withdrawalAddressView.snp.bottom).offset(15)
            make.left.equalTo(view.snp.left).offset(15)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalTo(20)
        }
        
        withdrawalAmountView.snp.makeConstraints { make in
            make.top.equalTo(withdrawalAmountLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        withdrawalLimitTextField.snp.makeConstraints { make in
            make.centerY.equalTo(withdrawalAmountView.snp.centerY)
            make.left.equalTo(withdrawalAmountView.snp.left).offset(15)
            make.height.equalTo(withdrawalAmountView.snp.height)
            make.width.equalTo(withdrawalAmountView.snp.width).multipliedBy(0.65)
        }
        
        withdrawalCoinLabel.snp.makeConstraints { make in
            make.centerY.equalTo(withdrawalAmountView.snp.centerY)
            make.right.equalTo(withdrawalMaxButton.snp.left).offset(-5)
            make.height.equalTo(withdrawalAmountView.snp.height)
            make.width.equalTo(withdrawalAmountView.snp.width).multipliedBy(0.2)
        }
        
        withdrawalMaxButton.snp.makeConstraints { make in
            make.centerY.equalTo(withdrawalAmountView.snp.centerY)
            make.right.equalTo(withdrawalAmountView.snp.right).offset(-10)
            make.height.equalTo(withdrawalAmountView.snp.height)
            make.width.equalTo(withdrawalAmountView.snp.width).multipliedBy(0.13)
        }
        
        feeLabel.snp.makeConstraints { make in
            make.top.equalTo(withdrawalAmountView.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(20)
        }
        
        confirmAddressButton.snp.makeConstraints { make in
            make.top.equalTo(feeLabel.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(15)
            make.width.height.equalTo(30)
        }
        
        confirmAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(feeLabel.snp.bottom).offset(10)
            make.left.equalTo(confirmAddressButton.snp.right).offset(5)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(30)
        }
        
        confirmView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.14)
        }
        
        confirmTopView.snp.makeConstraints { make in
            make.top.equalTo(confirmView.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        withdrawalTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(confirmView.snp.top).offset(10)
            make.left.equalTo(confirmView.snp.left).offset(15)
            make.width.equalTo(confirmView.snp.width).multipliedBy(0.4)
            make.height.equalTo(25)
        }
        
        withdrawalValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(confirmView.snp.centerY)
            make.left.equalTo(confirmView.snp.left).offset(15)
            make.width.equalTo(confirmView.snp.width).multipliedBy(0.25)
            make.height.equalTo(30)
        }
        
        coinLabel.snp.makeConstraints { make in
            make.bottom.equalTo(withdrawalValueLabel.snp.bottom).offset(-2)
            make.left.equalTo(withdrawalValueLabel.snp.right)
            make.width.equalTo(confirmView.snp.width).multipliedBy(0.2)
            make.height.equalTo(25)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(withdrawalTitleLabel.snp.top).offset(10)
            make.right.equalTo(confirmView.snp.right).offset(-15)
            make.left.equalTo(confirmView.snp.centerX).offset(20)
            make.height.equalTo(confirmView.snp.height).multipliedBy(0.45)
        }
        
        limtToastView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(view.snp.height).multipliedBy(0.5)
        }
        
        toastOverLimitView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(view.snp.height).multipliedBy(0.33)
        }
        
        toastFailedView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(view.snp.height).multipliedBy(0.33)
        }
        
        confirmButton.setBackgroundColor(#colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1), forState: .highlighted)
        confirmButton.setTitleColor(.white, for: .highlighted)
    }
    
    private func setupUIDetail() {
        withdrawalButton.layer.cornerRadius = 10
        insideWithdrawalButton.layer.cornerRadius = 10
        toastOverLimitView.isHidden = true
        toastFailedView.isHidden = true
        
        insideWithdrawalButton.setBackgroundColor(#colorLiteral(red: 0.9966385961, green: 0.9765377641, blue: 0.8922813535, alpha: 1), forState: .highlighted)
        withdrawalButton.setBackgroundColor(#colorLiteral(red: 0.9966385961, green: 0.9765377641, blue: 0.8922813535, alpha: 1), forState: .highlighted)
        withdrawalAddressView.layer.cornerRadius = 10
        withdrawalAmountView.layer.cornerRadius = 10
        withdrawalLimitTextField.keyboardType = .default
        
        self.limitLabel.text = useAmoumt ?? ""
        self.withdrawalTextField.font = .systemFont(ofSize: 13, weight: .regular)
        self.withdrawalTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.withdrawalLimitTextField.addTarget(self, action: #selector(amountFieldDidChange(_:)), for: .editingChanged)
    }
    
    // MARK: - Selector
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text,
              let textFirst = text.first else { return }
        if textFirst == "0" {
            print("以太")
            self.binding(chain: "_ETH")
        } else if textField.text!.first == "1" || textField.text!.first == "3"{
            print("OMI")
        } else {
            print("鏈別錯誤")
        }
    }
    
    @objc func amountFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let userTpyeAmount = (text as NSString).doubleValue
        if isSelectedWithdrawal != 1 {
            if userTpyeAmount > realFee {
                let realAmount = userTpyeAmount-realFee
                self.withdrawalValueLabel.text = realAmount.toString()
            } else {
                self.withdrawalValueLabel.text = "0"
            }
        } else {
            self.withdrawalValueLabel.text = userTpyeAmount.toString()
        }
    }
    
    @objc private func didTapWithdrawal() {
        isSelectedWithdrawal = 0
        if withdrawalLimitTextField.text?.count ?? 0 > 0 {
            guard let withdrawalLimitTextField = self.withdrawalLimitTextField.text else { return }
            let withdrawalLimitTF = (withdrawalLimitTextField as NSString).doubleValue
            self.withdrawalValueLabel.text = (withdrawalLimitTF-realFee).toString()
        }
//        guard let withdrawalLimitTextField = self.withdrawalLimitTextField.text else { return }
//        let withdrawalLimitTF = (withdrawalLimitTextField as NSString).doubleValue
//        self.withdrawalValueLabel.text = (withdrawalLimitTF-realFee).toString()

        self.withdrawalLimitTextField.placeholder = self.zc_min
        self.feeLabel.text = self.zc_fee
        withdrawalButton.setBackgroundColor(#colorLiteral(red: 0.9966385961, green: 0.9765377641, blue: 0.8922813535, alpha: 1), forState: .normal)
        withdrawalButton.setTitleColor(#colorLiteral(red: 0.9766772389, green: 0.7539924979, blue: 0.01549641695, alpha: 1), for: .normal)
        withdrawalButton.layer.borderWidth = 1.5
        withdrawalButton.layer.borderColor = #colorLiteral(red: 0.9766772389, green: 0.7539924979, blue: 0.01549641695, alpha: 1)
        
        insideWithdrawalButton.setBackgroundColor(#colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.9358595014, alpha: 1), forState: .normal)
        insideWithdrawalButton.setTitleColor(#colorLiteral(red: 0.2099245489, green: 0.2099536657, blue: 0.2099111676, alpha: 1), for: .normal)
        insideWithdrawalButton.layer.borderWidth = 0
        insideWithdrawalButton.layer.borderColor = #colorLiteral(red: 0.9766772389, green: 0.7539924979, blue: 0.01549641695, alpha: 1)
        
        withdrawalButton.layer.cornerRadius = 10
        insideWithdrawalButton.layer.cornerRadius = 10

    }
    
    @objc private func didTapInside() {
        isSelectedWithdrawal = 1
        if withdrawalLimitTextField.text?.count ?? 0 > 0 {
            self.withdrawalValueLabel.text = self.withdrawalLimitTextField.text
        }
        withdrawalLimitTextField.placeholder = ""
        self.feeLabel.text = "提領手續費為 " + "0" + " \(self.coinType!)"
        insideWithdrawalButton.setBackgroundColor(#colorLiteral(red: 0.9966385961, green: 0.9765377641, blue: 0.8922813535, alpha: 1), forState: .normal)
        insideWithdrawalButton.setTitleColor(#colorLiteral(red: 0.9766772389, green: 0.7539924979, blue: 0.01549641695, alpha: 1), for: .normal)
        insideWithdrawalButton.layer.borderWidth = 1.5
        insideWithdrawalButton.layer.borderColor = #colorLiteral(red: 0.9766772389, green: 0.7539924979, blue: 0.01549641695, alpha: 1)
        
        withdrawalButton.setBackgroundColor(#colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.9358595014, alpha: 1), forState: .normal)
        withdrawalButton.setTitleColor(#colorLiteral(red: 0.2099245489, green: 0.2099536657, blue: 0.2099111676, alpha: 1), for: .normal)
        withdrawalButton.layer.borderWidth = 0
        withdrawalButton.layer.borderColor = #colorLiteral(red: 0.9766772389, green: 0.7539924979, blue: 0.01549641695, alpha: 1)
        
        withdrawalButton.layer.cornerRadius = 10
        insideWithdrawalButton.layer.cornerRadius = 10

    }
    
    // MARK: - Selector
    @objc private func didTapPaste() {
        guard let text = UIPasteboard.general.string,
              let textFirst = text.first else { return }
        if textFirst == "0" {
            print("以太")
            self.binding(chain: "_ETH")
        } else if textFirst == "1" || textFirst == "3"{
            print("OMI")
        } else {
            print("鏈別錯誤")
        }
        self.withdrawalTextField.text = UIPasteboard.general.string
    }
    
    @objc private func didTapScan() {
        print("didTapScan")
        let vc = ScannerViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func didTapMax() {
        self.withdrawalLimitTextField.text = useAmoumt
        let useAmoumt = (self.useAmoumt as NSString).doubleValue
        self.withdrawalValueLabel.text = (useAmoumt-realFee).toString(maxF: 8)

    }
    
    @objc private func didTapConfirmAddress() {
        print("didTapConfirmAddress")
        isConfirmAddress = !isConfirmAddress
        if !isConfirmAddress {
            self.confirmAddressButton.setImage(UIImage(named: "Path"), for: .normal)
        } else {
            self.confirmAddressButton.setImage(UIImage(named: "Group"), for: .normal)
        }
        
    }
    
    @objc private func didTapConfirm() {
        print("didTapConfirm")
        guard let withdrawalNumStr = self.withdrawalLimitTextField.text,
              let withdrawalAddress = self.withdrawalTextField.text,
              let token = userDefaults.string(forKey: "UserToken"),
              let withdrawalLimitAmount = self.withdrawalLimitAmount,
              withdrawalNumStr != "",
              withdrawalAddress != "" else {
            self.toastFailedView.isHidden = false
            return
        }
        
        let withdrawalNum = (withdrawalNumStr as NSString).doubleValue
        // 外部提領
        if isSelectedWithdrawal == 0 {
            if withdrawalNum > withdrawalLimitAmount && isConfirmAddress == true {
                print("success")
                let param = "coinName=\(self.coinType!)&num=\(withdrawalNum)&token=\(token)"
                LoadingView.shared.showLoader()
                WithdrawalConfirmVM.checkCanWithdraw(apiURL: APIPath.checkCanWithdraw.value, param: param) { result in
                    DispatchQueue.main.async {
                        if result {
                            let controller = WithdrawalVerifiedViewController()
                            controller.coinname = "\(self.coinType!)"
                            controller.withdrawalAddr = withdrawalAddress
                            controller.num = (withdrawalNumStr as NSString).doubleValue
                            controller.isOutSideWithdrawal = true
                            controller.addr = withdrawalAddress
                            controller.delegate = self
                            self.navigationController?.pushViewController(controller, animated: true)
                        }
                        //超過限額
                        else {
                            self.toastOverLimitView.isHidden = false
                        }
                        LoadingView.shared.hideLoader()
                    }
                }
            } else {
                print("failed")
                self.toastFailedView.isHidden = false
            }
        }
        // 內部提領
        else {
            if isConfirmAddress {
                let controller = WithdrawalVerifiedViewController()
                controller.coinname = "\(self.coinType!)"
                controller.withdrawalAddr = withdrawalAddress
                controller.num = (withdrawalNumStr as NSString).doubleValue
                controller.delegate = self
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
    @objc private func didTapCheck() {
        print("didTapCheck")
        self.limtToastView.isHidden = true
        self.toastFailedView.isHidden = true
    }
    
    @objc private func didTapBack() {
        print("didTapBack")
        self.navigationController?.popViewController(animated: true)
    }
}


extension WithdrawalViewController: ScanUrlStrDelegate{
    func sendUrlStr(str: String) {
        self.withdrawalTextField.text = str
        if str.first == "0" {
            print("以太")
            self.binding(chain: "_ETH")
        } else if str.first == "1" || str.first == "3"{
            print("OMI")
        } else {
            print("鏈別錯誤")
        }
    }
}

extension WithdrawalViewController: WithdrawalResultDelegate{
    func withdrawalResult() {
        self.navigationController?.popViewController(animated: false)
        self.delegate?.withdrawalResult()
    }
}
