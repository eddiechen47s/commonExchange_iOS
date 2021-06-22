//
//  ResetVerifiedViewController.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/4/24.
//

import UIKit
import RxSwift
import RxCocoa

class ResetVerifyViewController: UIViewController {
    // 修复侧滑丢失
    private var naDelegate: UIGestureRecognizerDelegate?
    
    private let titleLabel = BaseLabel(text: "取消或重置Google驗證", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 28, weight: .bold), alignments: .left)
    private let mailLabel = BaseLabel(text: "將發送驗證碼到您的信箱", color: #colorLiteral(red: 0.6070429087, green: 0.6070575714, blue: 0.6070497036, alpha: 1), font: .systemFont(ofSize: 14, weight: .heavy), alignments: .left)
    private let googleAuthLabel = BaseLabel(text: "Google驗證", color: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 14, weight: .heavy), alignments: .left)
    
    private let mailCodeView = BaseView(color: #colorLiteral(red: 0.9181004763, green: 0.92492944, blue: 0.9373696446, alpha: 1))
    private let authCodeView = BaseView(color: #colorLiteral(red: 0.9181004763, green: 0.92492944, blue: 0.9373696446, alpha: 1))
    private let mailTextField = BaseTextField(text: "", placeholder: "請輸入信箱驗證碼")
    private let authTextField = BaseTextField(text: "", placeholder: "請輸入六位數驗證碼")
    private let pasteImageView = BaseImageView(image: "past_icon", color: nil)
    
    private lazy var verifyMailButton = CustomButton(title: "發送驗證碼", titleColor: #colorLiteral(red: 0.9621143937, green: 0.6522040367, blue: 0.1365978718, alpha: 1), font: .systemFont(ofSize: 14, weight: .bold), backgroundColor: .clear, action: #selector(didTapVerifyMail), vc: self)
    private lazy var pasteVerifyButton = BaseImgButton(img: pasteImageView, action: #selector(didTapPaste), vc: self)
    private lazy var confirmButton = CustomButton(title: "送出", titleColor: #colorLiteral(red: 0.6070429087, green: 0.6070575714, blue: 0.6070497036, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), backgroundColor: #colorLiteral(red: 0.9181004763, green: 0.92492944, blue: 0.9373696446, alpha: 1), action: #selector(didTapConfirm), vc: self)
    
    var viewModel = ResetVerifyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        backToPriviousController()
        self.title = "安全驗證"
        
        setupUI()
        setupUIDetail()
        // call api
        viewModel.loadAPI()
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
                         mailLabel,
                         mailCodeView,
                         googleAuthLabel,
                         authCodeView,
                         confirmButton
        )
        mailCodeView.addSubViews(mailTextField,
                                 verifyMailButton)
        authCodeView.addSubViews(authTextField,
                                 pasteVerifyButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(40)
        }
        
        mailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(30)
        }
        
        mailCodeView.snp.makeConstraints { make in
            make.top.equalTo(mailLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        mailTextField.snp.makeConstraints { make in
            make.centerY.equalTo(mailCodeView.snp.centerY)
            make.left.equalTo(mailCodeView.snp.left).offset(15)
            make.right.equalTo(verifyMailButton.snp.left)
            make.height.equalTo(mailCodeView.snp.height)
        }
        
        verifyMailButton.snp.makeConstraints { make in
            make.centerY.equalTo(mailCodeView.snp.centerY)
            make.right.equalTo(mailCodeView.snp.right).offset(-5)
            make.width.equalTo(mailCodeView.snp.width).multipliedBy(0.3)
            make.height.equalTo(mailCodeView.snp.height)
        }
        
        googleAuthLabel.snp.makeConstraints { make in
            make.top.equalTo(verifyMailButton.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(30)
        }
        
        authCodeView.snp.makeConstraints { make in
            make.top.equalTo(googleAuthLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        authTextField.snp.makeConstraints { make in
            make.centerY.equalTo(authCodeView.snp.centerY)
            make.left.equalTo(authCodeView.snp.left).offset(15)
            make.right.equalTo(authCodeView.snp.right)
            make.height.equalTo(authCodeView.snp.height)
        }
        
        pasteVerifyButton.snp.makeConstraints { make in
            make.centerY.equalTo(authCodeView.snp.centerY)
            make.right.equalTo(authCodeView.snp.right).offset(-15)
            make.width.height.equalTo(20)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(authCodeView.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
    }
    
    func setupUIDetail() {
        confirmButton.setBackgroundColor(#colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1), forState: .highlighted)
        confirmButton.setTitleColor(.white, for: .highlighted)
        confirmButton.layer.cornerRadius = 5
        mailCodeView.layer.cornerRadius = 10
        authCodeView.layer.cornerRadius = 10
        mailTextField.keyboardType = .numberPad
        authTextField.keyboardType = .numberPad
    }
    
    //MARK: - Selector
    @objc private func didTapVerifyMail() {
        let type = "googleReset"
        guard let token = userDefaults.string(forKey: "UserToken") else {
            return
        }
        let apiURL = "common/safetySettingSendEMail?"
        let param = "type=\(type)&token=\(token)"

        viewModel.safetySettingSendEMail(apiURL: apiURL, param: param) { [weak self] result in
            print(result)
            DispatchQueue.main.async {
                if result == "SUCCESS" {
                    let alert = UIAlertController(title: "已發送", message: "發送成功", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "確認", style: .cancel, handler: nil)
                    alert.addAction(cancel)
                    self?.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "錯誤", message: "發送失敗", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "確認", style: .cancel, handler: nil)
                    alert.addAction(cancel)
                    self?.present(alert, animated: true, completion: nil)
                }
            }
  
        }
        
    }
    
    @objc private func didTapPaste() {
        print("didTapPaste")
        self.authTextField.text = UIPasteboard.general.string
    }
    
    @objc private func didTapConfirm() {
        guard let mailCode = self.mailTextField.text ,
              let googleAuthText = self.authTextField.text,
              let token = userDefaults.string(forKey: "UserToken") else {
            return
        }
        let param = "mailCode=\(mailCode)&googleValidate=\(googleAuthText)&token=\(token)"
        viewModel.resetGoogleKey(apiURL: "user/cancelGoogleKey", param: param) {[weak self] result in

            if result == "SUCCESS" {
                userDefaults.set(false, forKey: "UserBinding2FA")
            } else {
                userDefaults.set(true, forKey: "UserBinding2FA")
            }

            DispatchQueue.main.async {
                self?.navigationController?.popViewController(animated: false)
            }
        }
        
    }
}
