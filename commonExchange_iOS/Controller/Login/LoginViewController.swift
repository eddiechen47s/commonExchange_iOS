//
//  LoginViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/9.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    var tag = 2
    var viewModel = LoginViewModel()

    private let loginTitleLabel = BaseLabel(text: "Ktrade", color: #colorLiteral(red: 0.1328194737, green: 0.2377011478, blue: 0.3250451386, alpha: 1), font: .systemFont(ofSize: 32, weight: .bold), alignments: .center)
    private let emailTextField = RegisterTextField(text: "", placeholder: "電子信箱")
    private let pwdTextField = RegisterTextField(text: "", placeholder: "密碼")
    private lazy var forgetPwdButton = CustomButton(title: "忘記密碼", titleColor: #colorLiteral(red: 0.3165471554, green: 0.3746598363, blue: 0.4687963128, alpha: 1), font: .systemFont(ofSize: 16), backgroundColor: .clear, action: #selector(didTapForgetPassword), vc: self)
    private lazy var registerButton = CustomButton(title: "註冊", titleColor: #colorLiteral(red: 0.3165471554, green: 0.3746598363, blue: 0.4687963128, alpha: 1), font: .systemFont(ofSize: 16), backgroundColor: .clear, action: #selector(didTapRegisterutton), vc: self)
    private lazy var loginButton = CustomButton(title: "登入", titleColor: .white, font: .systemFont(ofSize: 16), backgroundColor: #colorLiteral(red: 0.4392156863, green: 0.662745098, blue: 0.6862745098, alpha: 1), action: #selector(didTapLoginButton), vc: self)
    private let dividerView = BaseView(color: #colorLiteral(red: 0.1328194737, green: 0.2377011478, blue: 0.3250451386, alpha: 1))
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        emailTextField.delegate = self
        pwdTextField.delegate = self
        hiddenKeyboardWithTapView()
        setupNavBar()
        
        
        emailTextField.textColor = #colorLiteral(red: 0.1328512728, green: 0.2378041148, blue: 0.3210147619, alpha: 1)
        pwdTextField.textColor = #colorLiteral(red: 0.1328512728, green: 0.2378041148, blue: 0.3210147619, alpha: 1)
        pwdTextField.isSecureTextEntry = true
        loginButton.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Helpers
    private func setupNavBar() {
        let backImage = UIImage(named: "Close")?.withRenderingMode(.alwaysTemplate).withTintColor(.white)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(tapClose))
    }
    
    private func setupUI() {
        view.addSubViews(loginTitleLabel,
                         emailTextField,
                         pwdTextField,
                         forgetPwdButton,
                         registerButton,
                         loginButton,
                         dividerView
        )

        loginTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(view.snp.width)
            $0.height.equalTo(50)
        }

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(loginTitleLabel.snp.bottom).offset(30)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(40)
        }
        
        pwdTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(40)
        }

        forgetPwdButton.snp.makeConstraints {
            $0.top.equalTo(pwdTextField.snp.bottom).offset(30)
            $0.centerX.equalTo(view.snp.centerX).multipliedBy(0.5)
            $0.width.equalTo(view.snp.width).multipliedBy(0.25)
            $0.height.equalTo(50)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(forgetPwdButton.snp.top)
            $0.centerX.equalTo(view.snp.centerX).multipliedBy(1.5)
            $0.width.equalTo(view.snp.width).multipliedBy(0.25)
            $0.height.equalTo(50)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(forgetPwdButton.snp.top)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(1)
            $0.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(forgetPwdButton.snp.bottom).offset(50)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }

        
    }
    
    // MARK: - Selector
    @objc private func tapClose() {
        print("tapClose")
        let tab = CustomTabBarController()
        tab.selectedIndex = 0
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapchangeVerification() {
        print("didTapchangeVerification")
    }
    
    @objc private func didTapForgetPassword() {
        let controller = ForgetPwdViewController()
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func didTapLoginButton() {
        guard let email = self.emailTextField.text,
              let password = self.pwdTextField.text else {
            return
        }
        viewModel.login(email: email, password: password) { (loginResult) in
            DispatchQueue.main.async {
                if loginResult {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "請重新輸入", message: "帳號或密碼輸入錯誤", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "確認", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc private func didTapRegisterutton() {
        print("didTapregisterutton")
        let controller = createNavController(vc: RegisterViewController(), title: "註冊帳號", image: nil, selectedImage: nil, tag: 6)
//        let nav = UINavigationController(rootViewController: controller)
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            textField.resignFirstResponder()
            pwdTextField.becomeFirstResponder()
        default:
            pwdTextField.resignFirstResponder()
        }
        return true
    }
}
