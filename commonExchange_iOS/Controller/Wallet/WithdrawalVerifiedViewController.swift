//
//  WithdrawalVerifiedViewController.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/4/24.
//

import UIKit

protocol WithdrawalResultDelegate: AnyObject {
    func withdrawalResult()
}

class WithdrawalVerifiedViewController: UIViewController {
    // 修复侧滑丢失
    var delegate: WithdrawalResultDelegate?
    private var naDelegate: UIGestureRecognizerDelegate?
    private let titleLabel = BaseLabel(text: "安全驗證", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 28, weight: .bold), alignments: .left)
    private let authLabel = BaseLabel(text: "Google Authenticator", color: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 14, weight: .heavy), alignments: .left)
    private let authCodeTipLabel = BaseLabel(text: "驗證碼每30秒便會刷新，請及時輸入。", color: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 14, weight: .heavy), alignments: .left)
    private let noticeLabel = BaseLabel(text: "注意", color: #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1), font: .systemFont(ofSize: 16, weight: .heavy), alignments: .left)
    
    private let authTextField = BaseTextField(text: "", placeholder: "請輸入六位數驗證碼")
    
    private let authCodeView = BaseView(color: .white)
    private let authTipView = BaseView(color: #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1))
    
    //MARK: - Taost
    private lazy var toastSuccessView = WithdrawalToastView(img: toastSuccessImg, titleLabel: toastSTitleLabel, detailLabel: toastSDetailLabel, buttonTitle: "返回錢包", action: #selector(didTapBackSuccess), vc: self)
    private lazy var toastFailedView = WithdrawalToastView(img: toastFailedImg, titleLabel: toastFTitleLabel, detailLabel: toastFDetailLabel, buttonTitle: "返回錢包", action: #selector(didTapBack), vc: self)
    
    private let toastSuccessImg = BaseImageView(image: "Yes", color: nil)
    private let toastFailedImg = BaseImageView(image: "No", color: nil)

    private let toastSTitleLabel = BaseLabel(text: "您已完成提交", color: .white, font: .systemFont(ofSize: 22, weight: .regular), alignments: .center)
    private let toastFTitleLabel = BaseLabel(text: "未完成提交", color: .white, font: .systemFont(ofSize: 22, weight: .regular), alignments: .center)
    private let toastSDetailLabel = BaseLabel(text: "此筆交易可至\n帳戶 > 所有歷史紀錄 > 提領紀錄查詢", color: .white, font: .systemFont(ofSize: 13, weight: .regular), alignments: .center)
    private let toastFDetailLabel = BaseLabel(text: "提領提交失敗，請重試", color: .white, font: .systemFont(ofSize: 13, weight: .regular), alignments: .center)
    
    
    private let ruleTextView: UITextView = {
       let tv = UITextView()
        tv.backgroundColor = .clear
        tv.textColor = #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)
        tv.isEditable = false
        tv.font = .systemFont(ofSize: 12, weight: .bold)
        tv.text = """
                * 會員等級數位資產單筆限額：
                   B Class：等值 490,000 TWD以下（約 15,000 USD）
                   A Class：等值 500,000 TWD（約 16,600 USD）
                * 數位資產24小時提領限額：等值 5,000,000 TWD以下（約 150,000 USD）
                * 若您提領數位資產的現值超過 500,000 TWD或是綜合評估風險過高，需進行人工審核，可能需耗時 1 個工作天。
                """
        return tv
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("提交", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.9358595014, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        return button
    }()
    var viewModel = WithdrawalInSideViewModel()
    var outSideVM = WithdrawalOutSideViewModel()
    var coinname: String = ""
    var withdrawalAddr: String = ""
    var num: Double = 0
    var isOutSideWithdrawal: Bool = false
    var addr = ""

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "提領"
        backToPriviousController()

        setupUI()
        setupUIDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 修复侧滑丢失
        naDelegate = navigationController?.interactivePopGestureRecognizer?.delegate
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 修复侧滑丢失
        navigationController?.interactivePopGestureRecognizer?.delegate = naDelegate
    }
    
    // MARK: - Helpers
    
    private func binding() {
        guard let token = userDefaults.string(forKey: "UserToken"),
              let authText = self.authTextField.text else {
            return
        }
        if self.isOutSideWithdrawal {
            let param = "type=\(coinname)&addr=\(withdrawalAddr)&num=\(num)&otp=\(authText)&token=\(token)"
            outSideVM.turnOut(param: param) { [weak self] result in
                DispatchQueue.main.async {
                    if result {
                        self?.toastSuccessView.isHidden = false
                    } else {
                        self?.toastFailedView.isHidden = false
                    }
                }
            }
        } else {
            let param = "coinname=\(coinname)&usermail=\(withdrawalAddr)&num=\(num)&otp=\(authText)&token=\(token)"
            viewModel.transfer(apiURL: APIPath.transfer.value, param: param) { [weak self] result in
                DispatchQueue.main.async {
                    if result {
                        self?.toastSuccessView.isHidden = false
                    } else {
                        self?.toastFailedView.isHidden = false
                    }
                }
            }
        }
    }
    
    private func setupUI() {
        view.addSubViews(titleLabel,
                         authLabel,
                         authCodeView,
                         authCodeTipLabel,
                         confirmButton,
                         authTipView,
                         toastSuccessView,
                         toastFailedView
                            )
        authCodeView.addSubview(authTextField)
        authTipView.addSubViews(noticeLabel, ruleTextView)
        
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.snp.left).offset(15)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(40)
        }
        
        authLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(15)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(30)
        }
        
        authCodeView.snp.makeConstraints { make in
            make.top.equalTo(authLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(60)
        }
        
        authTextField.snp.makeConstraints { make in
            make.centerY.equalTo(authCodeView.snp.centerY)
            make.left.equalTo(authCodeView.snp.left).offset(15)
            make.width.equalTo(authCodeView.snp.width)
            make.height.equalTo(40)
        }
        
        authCodeTipLabel.snp.makeConstraints { make in
            make.top.equalTo(authTextField.snp.bottom).offset(15)
            make.left.equalTo(view.snp.left).offset(15)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(30)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-15)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        authTipView.snp.makeConstraints { make in
            make.top.equalTo(authCodeTipLabel.snp.bottom).offset(40)
            make.bottom.equalTo(confirmButton.snp.top).offset(-20)
            make.left.right.equalToSuperview()
        }
        
        noticeLabel.snp.makeConstraints { make in
            make.top.equalTo(authTipView.snp.top).offset(15)
            make.left.equalTo(authTipView.snp.left).offset(15)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(20)
        }
        
        ruleTextView.snp.makeConstraints { make in
            make.top.equalTo(noticeLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(authTipView.snp.height).multipliedBy(0.8)
        }
        
        toastSuccessView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(view.snp.height).multipliedBy(0.33)
        }
        
        toastFailedView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(view.snp.height).multipliedBy(0.33)
        }
    }

    private func setupUIDetail() {
        authCodeView.layer.cornerRadius = 10
        authCodeView.layer.borderWidth = 1
        authCodeView.layer.borderColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        authTextField.keyboardType = .numberPad
        authTextField.font = .systemFont(ofSize: 16, weight: .regular)
        confirmButton.layer.cornerRadius = 10
        toastSuccessView.isHidden = true
        toastFailedView.isHidden = true
        toastSDetailLabel.numberOfLines = 2
    }
    
    // MARK: - Selector
    @objc private func didTapConfirm() {
        print("didTapConfirm")
        guard authTextField.text != "" else {
            return
        }
        binding()
    }
    
    @objc func didTapBackSuccess() {
        print("didTapBack")
        self.navigationController?.popViewController(animated: false)
        self.delegate?.withdrawalResult()
    }
    
    @objc func didTapBack() {
        print("didTapBack")
        self.navigationController?.popViewController(animated: true)
    }
}

