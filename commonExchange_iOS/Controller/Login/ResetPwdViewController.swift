//
//  ResetPwdViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/7.
//

import UIKit
import RxSwift
import RxCocoa

class ResetPwdViewController: UIViewController {
    private let loginTitleLabel = BaseLabel(text: "Ktrade", color: #colorLiteral(red: 0.1328194737, green: 0.2377011478, blue: 0.3250451386, alpha: 1), font: .systemFont(ofSize: 32, weight: .bold), alignments: .center)
    private let resetPwdLabel = BaseLabel(text: "請輸入新密碼", color: #colorLiteral(red: 0.1328194737, green: 0.2377011478, blue: 0.3250451386, alpha: 1), font: .systemFont(ofSize: 15, weight: .regular), alignments: .left)
    private let toastSTitleLabel = BaseLabel(text: "成功", color: .white, font: .systemFont(ofSize: 22, weight: .regular), alignments: .center)
    private let toastFailLabel = BaseLabel(text: "失敗", color: .white, font: .systemFont(ofSize: 22, weight: .regular), alignments: .center)


    private let pwdTextField = RegisterTextField(text: "", placeholder: "新密碼")
    private let confirmPwdTextField = RegisterTextField(text: "", placeholder: "確認新密碼")
    
    private lazy var nextButton = CustomButton(title: "完成", titleColor: .white, font: .systemFont(ofSize: 16), backgroundColor: #colorLiteral(red: 0.4392156863, green: 0.662745098, blue: 0.6862745098, alpha: 1), action: #selector(tapFinish), vc: self)
    
    private lazy var verifySuccessView = GoogleVerifiedToastView(img: toastSuccessImg, titleLabel: toastSTitleLabel)
    private lazy var verifyFailView = GoogleVerifiedToastView(img: toastFailImg, titleLabel: toastFailLabel)

    private let toastSuccessImg = BaseImageView(image: "Yes", color: nil)
    private let toastFailImg = BaseImageView(image: "No", color: nil)

    var forgetPwdVM = ForgetPwdViewModel()
    let disposeBag = DisposeBag()
    var viewModel = ResetPwdViewModel()
    var email: String = ""
    var verifyCode: String = ""
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        bindingReset()
        setupDetail()
    }
    
    deinit {
        print("ResetPwdViewController deinit")
    }
    
    // MARK: - Helpers
    private func setupDetail() {
        self.pwdTextField.textColor = #colorLiteral(red: 0.1328194737, green: 0.2377011478, blue: 0.3250451386, alpha: 1)
        self.confirmPwdTextField.textColor = #colorLiteral(red: 0.1328194737, green: 0.2377011478, blue: 0.3250451386, alpha: 1)
        self.pwdTextField.isSecureTextEntry = true
        self.confirmPwdTextField.isSecureTextEntry = true
        self.verifySuccessView.isHidden = true
        self.verifyFailView.isHidden = true
    }
    
    private func setupUI() {
        view.addSubViews(loginTitleLabel,
                         resetPwdLabel,
                         pwdTextField,
                         confirmPwdTextField,
                         nextButton,
                         verifySuccessView,
                         verifyFailView
                        )
        
        loginTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(view.snp.width)
            $0.height.equalTo(50)
        }
        
        resetPwdLabel.snp.makeConstraints {
            $0.top.equalTo(loginTitleLabel.snp.bottom).offset(30)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(40)
        }
        
        pwdTextField.snp.makeConstraints {
            $0.top.equalTo(resetPwdLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
        
        confirmPwdTextField.snp.makeConstraints {
            $0.top.equalTo(pwdTextField.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(confirmPwdTextField.snp.bottom).offset(50)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
        
        verifySuccessView.snp.makeConstraints {
            $0.center.equalTo(view.snp.center)
            $0.width.equalTo(120)
            $0.height.equalTo(120)
        }
        
        verifyFailView.snp.makeConstraints {
            $0.center.equalTo(view.snp.center)
            $0.width.equalTo(120)
            $0.height.equalTo(120)
        }
    }
    
    private func bindingReset() {
        viewModel.resetResult
            .subscribe(onNext: { result in
                print(result)
                if result {
                    self.verifySuccessView.isHidden = false
                    self.verifySuccessView.alpha = 1
                    UIView.animate(withDuration: 2.5) {
                        self.verifySuccessView.alpha = 0
                    } completion: { (_) in
                    }
                } else {
                    self.verifyFailView.isHidden = false
                    self.verifyFailView.alpha = 1
                    UIView.animate(withDuration: 2.5) {
                        self.verifyFailView.alpha = 0
                    } completion: { (_) in
                    }
                }
            }).disposed(by: disposeBag)
        

    }
    
    @objc private func tapFinish() {
        guard let pwdTF = self.pwdTextField.text,
              let confirmTF = self.confirmPwdTextField.text,
              pwdTF != "",
              confirmTF != "",
              pwdTF == confirmTF else {
            self.verifyFailView.isHidden = false
            self.verifyFailView.alpha = 1
            UIView.animate(withDuration: 2.5) {
                self.verifyFailView.alpha = 0
            } completion: { (_) in
            }
            return
        }
        
        viewModel.updateForgetPwd(email: self.email, password: pwdTF, confirmPwd: confirmTF, validate: verifyCode)
    }
}
