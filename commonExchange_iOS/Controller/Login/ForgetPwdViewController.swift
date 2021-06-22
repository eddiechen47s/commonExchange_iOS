//
//  ForgetPwdViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/7.
//

import UIKit
import RxSwift
import RxCocoa

class ForgetPwdViewController: UIViewController {
    private let loginTitleLabel = BaseLabel(text: "Ktrade", color: #colorLiteral(red: 0.1328194737, green: 0.2377011478, blue: 0.3250451386, alpha: 1), font: .systemFont(ofSize: 32, weight: .bold), alignments: .center)
    private let registerLabel = BaseLabel(text: "請輸入您的註冊帳號（電子信箱）", color: #colorLiteral(red: 0.1328194737, green: 0.2377011478, blue: 0.3250451386, alpha: 1), font: .systemFont(ofSize: 15, weight: .regular), alignments: .left)
    
    private let emailTextField = RegisterTextField(text: "", placeholder: "電子信箱")
    private lazy var emailVerifyButton = CustomButton(title: "發送驗證碼", titleColor: .white, font: .systemFont(ofSize: 16), backgroundColor: #colorLiteral(red: 0.4392156863, green: 0.662745098, blue: 0.6862745098, alpha: 1), action: #selector(tapEmailVerify), vc: self)
    private lazy var toastFailedView = GoogleVerifiedToastView(img: toastFailImg, titleLabel: toastFailLabel)
    private let toastFailImg = BaseImageView(image: "No", color: nil)
    private let toastFailLabel = BaseLabel(text: "失敗", color: .white, font: .systemFont(ofSize: 22, weight: .regular), alignments: .center)

    var viewModel = ForgetPwdViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupDetail()
        bindingMailVerify()
    }
    
    deinit {
        print("ForgetPwdViewController deinit")
    }
    
    // MARK: - Helpers
    private func bindingMailVerify() {
        viewModel.verifyResult
            .subscribe(onNext: { [weak self] result in
                if result {
                    guard let email = self?.emailTextField.text else { return }
                    let controller = ForgetPwdVerityViewController()
                    controller.modalPresentationStyle = .fullScreen
                    controller.email = email
                    self?.navigationController?.pushViewController(controller, animated: true)
                } else {
                    self?.toastFailedView.alpha = 1
                    self?.toastFailedView.isHidden = false
                    
                    UIView.animate(withDuration: 2.5) {
                        self?.toastFailedView.alpha = 0
                    } completion: { (_) in }
                }
            }).disposed(by: disposeBag)
    }
    
    private func setupDetail() {
        self.toastFailedView.isHidden = true
        self.emailTextField.textColor = #colorLiteral(red: 0.1328194737, green: 0.2377011478, blue: 0.3250451386, alpha: 1)
    }
    
    private func setupUI() {
        view.addSubViews(loginTitleLabel,
                         registerLabel,
                         emailTextField,
                         emailVerifyButton,
                         toastFailedView)
        
        loginTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(view.snp.width)
            $0.height.equalTo(50)
        }
        
        registerLabel.snp.makeConstraints {
            $0.top.equalTo(loginTitleLabel.snp.bottom).offset(30)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(40)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(registerLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
        
        emailVerifyButton.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(50)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
        
        toastFailedView.snp.makeConstraints {
            $0.center.equalTo(view.snp.center)
            $0.width.equalTo(120)
            $0.height.equalTo(120)
        }
    }
    
    @objc private func tapEmailVerify() {
        guard let emailTF = self.emailTextField.text,
              emailTF != "" else {
            return
        }
        viewModel.sendBindEMailGoogle(email: emailTF)
    }
}
