//
//  GoogleVerifiedViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/23.
//

import UIKit

protocol GoogleVerifiedStatusDelegate: AnyObject {
    func backToVerified(isSuccess: Bool)
}

class GoogleVerifiedViewController: UIViewController {
    // 修复侧滑丢失
    private var naDelegate: UIGestureRecognizerDelegate?
    var delegate: GoogleVerifiedStatusDelegate?
    var viewModel = GoogleVerifiedViewModel()
    private let titleLabel = BaseLabel(text: "輸入Google驗證碼", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 28, weight: .bold), alignments: .left)
    private let authLabel = BaseLabel(text: "Google Authenticator", color: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 14, weight: .heavy), alignments: .left)
    private let authCodeTipLabel = BaseLabel(text: "驗證碼每30秒便會刷新，請及時輸入。", color: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 14, weight: .heavy), alignments: .left)

    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("驗證", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.9358595014, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        return button
    }()
    
    private let authCodeView = BaseView(color: .white)
    private let authTextField = BaseTextField(text: "", placeholder: "請輸入六位數驗證碼")

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "安全驗證"
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
    private func setupUI() {
        view.addSubViews(titleLabel,
                         authLabel,
                         confirmButton,
                         authCodeView,
                         authCodeTipLabel
        )
        
        authCodeView.addSubViews(authTextField)
        
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
        
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
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
            make.top.equalTo(authTextField.snp.bottom).offset(25)
            make.left.equalTo(view.snp.left).offset(15)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(30)
        }
    }
    
    func setupUIDetail() {
        confirmButton.setBackgroundColor(#colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1), forState: .highlighted)
        confirmButton.setTitleColor(.white, for: .highlighted)
        confirmButton.layer.cornerRadius = 5
        authCodeView.layer.cornerRadius = 10
        authCodeView.layer.borderWidth = 1
        authCodeView.layer.borderColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        authTextField.keyboardType = .numberPad
    }
    
    // MARK: - Selector
    @objc private func didTapConfirm() {
//        LoadingView.shared.showLoader()
        guard let token = userDefaults.string(forKey: "UserToken"),
              let googleAuthText = self.authTextField.text else {
            return
        }
        let param = "token=\(token)&googleValidate=\(googleAuthText)"
        viewModel.saveGoogleKey(apiURL: "user/saveGoogleKey", param: param) { result in
            if result == "SUCCESS" {
                self.delegate?.backToVerified(isSuccess: true)
                userDefaults.set(true, forKey: "UserBinding2FA")
            } else {
                self.delegate?.backToVerified(isSuccess: false)
                userDefaults.set(false, forKey: "UserBinding2FA")
            }
//            LoadingView.shared.hideLoader()
            }
        }
        
    }


