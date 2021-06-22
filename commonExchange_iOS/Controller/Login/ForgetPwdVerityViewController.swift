//
//  ForgetPwdVerityViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/7.
//

import UIKit
import RxSwift
import RxCocoa

class ForgetPwdVerityViewController: UIViewController {
    private let loginTitleLabel = BaseLabel(text: "Ktrade", color: #colorLiteral(red: 0.1328194737, green: 0.2377011478, blue: 0.3250451386, alpha: 1), font: .systemFont(ofSize: 32, weight: .bold), alignments: .center)
    private let emailVerityCodeLabel = BaseLabel(text: "請輸入信箱驗證碼", color: #colorLiteral(red: 0.1328194737, green: 0.2377011478, blue: 0.3250451386, alpha: 1), font: .systemFont(ofSize: 15, weight: .regular), alignments: .left)
    
    private let verityTextField = RegisterTextField(text: "", placeholder: "驗證碼")
    private lazy var nextButton = CustomButton(title: "下一步", titleColor: .white, font: .systemFont(ofSize: 16), backgroundColor: #colorLiteral(red: 0.4392156863, green: 0.662745098, blue: 0.6862745098, alpha: 1), action: #selector(tapEmailVerify), vc: self)
    
    var resetPwdVM = ResetPwdViewModel()
    let disposeBag = DisposeBag()
    var email: String = ""
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()

        verityTextField.textColor = #colorLiteral(red: 0.1328194737, green: 0.2377011478, blue: 0.3250451386, alpha: 1)
        verityTextField.keyboardType = .numberPad
    }
    
    deinit {
        print("ForgetPwdVerityViewController deinit")
    }
    
    // MARK: - Helpers
    private func setupUI() {
        view.addSubViews(loginTitleLabel,
                         emailVerityCodeLabel,
                         verityTextField,
                         nextButton
                        )
        
        loginTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(view.snp.width)
            $0.height.equalTo(50)
        }
        
        emailVerityCodeLabel.snp.makeConstraints {
            $0.top.equalTo(loginTitleLabel.snp.bottom).offset(30)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(40)
        }

        verityTextField.snp.makeConstraints {
            $0.top.equalTo(emailVerityCodeLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }

        nextButton.snp.makeConstraints {
            $0.top.equalTo(verityTextField.snp.bottom).offset(50)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
    }

    private func bindingText() {

    }
    
    // MARK: - Selector
    @objc private func tapEmailVerify() {
        guard let verityTF = self.verityTextField.text,
              verityTF != "" else {
            return
        }
        bindingText()
        
        let controller = ResetPwdViewController()
        print(self.email)
        controller.email = self.email
        controller.verifyCode = verityTF
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
