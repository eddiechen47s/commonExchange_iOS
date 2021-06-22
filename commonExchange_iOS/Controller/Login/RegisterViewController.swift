//
//  RegisterViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/3.
//

import UIKit
import DropDown
import SnapKit
import RxSwift
import RxCocoa
import Alamofire

class RegisterViewController: UIViewController {
    var smsViewModel = SMSSendPhoneViewModel()
    var registerEmailViewModel = RegiserEmailViewModel()
    var registerViewModel = RegisterViewModel()
    let disposeBag = DisposeBag()
    
    var isAgree: Bool = false
    let menu: DropDown = {
       let menu = DropDown()
        menu.dataSource = RegisterPhone.phone.text
        return menu
    }()
    
    private let menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let menuLabel: UILabel = {
        let label = UILabel()
        label.text = "+886"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    private let dropDownImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dropDown")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1)
        return imageView
    }()

    private lazy var smsSendButton = CustomButton(title: "發送", titleColor: .white, font: .systemFont(ofSize: 14), backgroundColor: #colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1), action: #selector(didTapSmsSend), vc: self)
    
    private lazy var emailSendButton = CustomButton(title: "發送", titleColor: .white, font: .systemFont(ofSize: 14), backgroundColor: #colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1), action: #selector(didTapEmailSend), vc: self)
    private lazy var agreeButton = BaseImgButton(img: aggreeImg, action: #selector(didTapagreeButton(_:)), vc: self)
    private lazy var termsButton = CustomButton(title: "查看條款", titleColor: .white, font: .systemFont(ofSize: 13), backgroundColor: #colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1), action: #selector(didTapTerms), vc: self)
    private lazy var registerButtons = CustomButton(title: "建立新帳號", titleColor: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), backgroundColor: #colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.9358595014, alpha: 1), action: #selector(didTapRegister), vc: self)
    
    private let aggreeImg = BaseImageView(image: "RigsterPath", color: nil)
    
    private let tipView = BaseView(color: #colorLiteral(red: 0.9639821649, green: 0.4317304194, blue: 0.4311518669, alpha: 1))
    private let numberBottomView = BottomView(backgroundColor: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1))
    
    private let numberTextField = BaseTextField(text: "", placeholder: "手機號碼")
    private let smsTextField = RegisterTextField(text: "", placeholder: "簡訊認證碼")
    private let emailTextField = RegisterTextField(text: "", placeholder: "電子信箱")
    private let emailConfirmTextField = RegisterTextField(text: "", placeholder: "信箱驗證碼")
    private let inviteCodeTextField = RegisterTextField(text: "", placeholder: "邀請碼（選填）")
    private let pwdTextField = RegisterTextField(text: "", placeholder: "密碼")
    private let confirmPwdTextField = RegisterTextField(text: "", placeholder: "確認密碼")
    
    private let tipLabel = BaseLabel(text: "如您所在管轄區域的法令或您所適用的法令,禁止發行或銷售虛擬貨幣,本交易所不接受註冊,請勿使用本交易所。", color: .white, font: .systemFont(ofSize: 12, weight: .regular), alignments: .center)
    private let titleLable = BaseLabel(text: "Ktrade", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 30, weight: .bold), alignments: .center)
    private let agreeLabel = BaseLabel(text: "我已滿20且非居住在日本、美國、歐洲經濟區內,也沒有日本、美國、歐洲經濟區國家公民身分,並同意遵守網站的使用條款和隱私權政策", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 12, weight: .regular), alignments: .left)
    
    private lazy var toastSuccessView = GoogleVerifiedToastView(img: toastSuccessImg, titleLabel: toastSuccessLabel)
    private lazy var toastFailedView = GoogleVerifiedToastView(img: toastFailImg, titleLabel: toastFailLabel)
    
    private let toastSuccessImg = BaseImageView(image: "Yes", color: nil)
    private let toastFailImg = BaseImageView(image: "No", color: nil)
    
    private let toastSuccessLabel = BaseLabel(text: "成功", color: .white, font: .systemFont(ofSize: 22, weight: .regular), alignments: .center)
    private let toastFailLabel = BaseLabel(text: "失敗", color: .white, font: .systemFont(ofSize: 22, weight: .regular), alignments: .center)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupDropDownMenu()
        view.backgroundColor = #colorLiteral(red: 0.9968166947, green: 1, blue: 0.9963441491, alpha: 1)
        hiddenKeyboardWithTapView()
        configureTextFiele()
        setupDetail()
        backToPriviousController()
        bindingSMS() //簡訊驗證綁定
        bindingEmail() //信箱綁定
        bindingRegister() //註冊 Button 綁定
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureTextFiele() {
        agreeLabel.numberOfLines = 4
        tipLabel.numberOfLines = 4
        tipView.layer.cornerRadius = 5
        registerButtons.layer.cornerRadius = 5
        registerButtons.setBackgroundColor(#colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1), forState: .highlighted)
        registerButtons.setTitleColor(.white, for: .highlighted)
        toastSuccessView.isHidden = true
        toastFailedView.isHidden = true
    }
    
    // MARK: - Helpers
    private func setupDetail() {
        self.numberTextField.keyboardType = .numberPad
        self.pwdTextField.isSecureTextEntry = true
        self.confirmPwdTextField.isSecureTextEntry = true
        self.dropDownImageView.tintColor = #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1)
    }
    
    private func setupLayout() {
        view.addSubViews(titleLable,
                         menuView,
                         menuLabel,
                         dropDownImageView,
                         numberTextField,
                         numberBottomView,
                         smsTextField,
                         smsSendButton,
                         emailTextField,
                         emailConfirmTextField,
                         emailSendButton,
                         inviteCodeTextField,
                         pwdTextField,
                         confirmPwdTextField,
                         agreeButton,
                         agreeLabel,
                         termsButton,
                         tipView,
                         registerButtons,
                         toastSuccessView,
                         toastFailedView
                         )
        tipView.addSubview(tipLabel)
        
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(50)
        }
        
        menuView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(20)
            make.width.equalTo(view.snp.width).multipliedBy(0.2)
            make.height.equalTo(40)
        }

        menuLabel.snp.makeConstraints { make in
            make.centerY.equalTo(menuView.snp.centerY)
            make.left.equalTo(menuView.snp.left)
            make.width.equalTo(menuView.snp.width).multipliedBy(0.6)
            make.height.equalTo(menuView.snp.height)
        }

        dropDownImageView.snp.makeConstraints { make in
            make.centerY.equalTo(menuView.snp.centerY)
            make.left.equalTo(menuLabel.snp.right)
            make.width.equalTo(menuView.snp.width).multipliedBy(0.2)
            make.height.equalTo(menuView.snp.height).multipliedBy(0.3)
        }
        
        numberTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(10)
            make.left.equalTo(menuView.snp.right).offset(10)
            make.right.equalTo(view.snp.right).offset(-20)
            make.height.equalTo(40)
        }
        
        numberBottomView.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom)
            make.left.equalTo(menuView.snp.left)
            make.right.equalTo(numberTextField.snp.right)
            make.height.equalTo(1)
        }
        
        smsTextField.snp.makeConstraints { make in
            make.top.equalTo(numberBottomView.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(20)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalTo(40)
        }
        
        smsSendButton.snp.makeConstraints { make in
            make.top.equalTo(numberBottomView.snp.bottom).offset(10)
            make.left.equalTo(smsTextField.snp.right).offset(10)
            make.right.equalTo(view.snp.right).offset(-20)
            make.bottom.equalTo(smsTextField.snp.bottom)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(smsSendButton.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        emailConfirmTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(20)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalTo(40)
        }
        
        emailSendButton.snp.makeConstraints {
            $0.top.equalTo(emailConfirmTextField.snp.top)
            $0.left.equalTo(emailConfirmTextField.snp.right).offset(10)
            $0.right.equalTo(view.snp.right).offset(-20)
            $0.height.equalTo(40)
        }
        
        inviteCodeTextField.snp.makeConstraints {
            $0.top.equalTo(emailSendButton.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        pwdTextField.snp.makeConstraints {
            $0.top.equalTo(inviteCodeTextField.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        confirmPwdTextField.snp.makeConstraints {
            $0.top.equalTo(pwdTextField.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        agreeButton.snp.makeConstraints {
            $0.top.equalTo(confirmPwdTextField.snp.bottom).offset(15)
            $0.left.equalToSuperview().offset(20)
            $0.width.height.equalTo(40)
        }
        agreeLabel.snp.makeConstraints {
            $0.top.equalTo(confirmPwdTextField.snp.bottom).offset(10)
            $0.left.equalTo(agreeButton.snp.right).offset(5)
            $0.right.equalTo(termsButton.snp.left).offset(-5)
            $0.width.height.equalTo(70)
        }
        
        termsButton.snp.makeConstraints {
            $0.top.equalTo(confirmPwdTextField.snp.bottom).offset(20)
            $0.right.equalTo(view.snp.right).offset(-20)
            $0.width.equalTo(view.snp.width).multipliedBy(0.2)
            $0.width.height.equalTo(40)
        }
        
        tipView.snp.makeConstraints {
            $0.top.equalTo(agreeLabel.snp.bottom).offset(15)
            $0.left.right.equalToSuperview().inset(20)
            $0.width.height.equalTo(50)
        }
        
        tipLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalTo(tipView).inset(10)
        }
        
        registerButtons.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.left.right.equalToSuperview().inset(20)
            $0.width.height.equalTo(50)
        }
        
        toastSuccessView.snp.makeConstraints {
            $0.center.equalTo(view.snp.center)
            $0.width.equalTo(120)
            $0.height.equalTo(120)
        }
        
        toastFailedView.snp.makeConstraints {
            $0.center.equalTo(view.snp.center)
            $0.width.equalTo(120)
            $0.height.equalTo(120)
        }
    }
    
    private func setupDropDownMenu() {
        dropDownImageView.tintColor = .white
        menu.anchorView = menuView
        menu.bottomOffset = CGPoint(x: 0, y: menuView.bounds.height+45)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapMenuView))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        menuView.addGestureRecognizer(gesture)
        
        // callback
        menu.selectionAction = { index, title in
            self.menuLabel.text = title
        }
    }
    
    private func bindingSMS() {
        smsViewModel.userSmsResult
            .subscribe(onNext: { result in
                if result {
                    print("Success")
                }
            }).disposed(by: disposeBag)
    }
    
    
    private func bindingEmail() {
        registerEmailViewModel.userEmailResult
            .subscribe(onNext: { result in
                print(result)
                if result {
                    print("Success")
                }
            }).disposed(by: disposeBag)
    }
    
    private func bindingRegister() {
        registerViewModel.userRegister
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                print(result)
                if result {
                    print("Success")
                    self?.toastSuccessView.alpha = 1
                    self?.toastSuccessView.isHidden = false

                    UIView.animate(withDuration: 2.5) {
                        self?.toastSuccessView.alpha = 0
                    } completion: { (_) in
                        self?.dismiss(animated: true, completion: nil)
                    }
                } else {
                    print("Fail")
                    self?.toastFailedView.alpha = 1
                    self?.toastFailedView.isHidden = false
                    UIView.animate(withDuration: 2.5) {
                        self?.toastFailedView.alpha = 0
                    } completion: { (_) in
                    }
                }
            }).disposed(by: disposeBag)
    }

    // MARK: - Selector
    @objc private func didTapMenuView() {
        menu.show()
    }
    
    @objc private func didTapSmsSend() {
        guard let phoneNumberText = self.numberTextField.text,
              let countryCode = self.menuLabel.text,
              phoneNumberText != "" else { return }
        let parameters = [
          "mobilePhone": "\(countryCode)\(phoneNumberText)"
        ]
        smsViewModel.sendSMS(parameters: parameters)
    }
    
    @objc private func didTapEmailSend() {
        guard let email = self.emailTextField.text,
              email != "" else { return }
        registerEmailViewModel.registSendEmail(email: email)
    }
    
    @objc private func didTapTerms() {
        print("didTapRuleBtn")
        let controller = TermsViewController()
        self.present(controller, animated: true, completion: nil)
    }

    @objc private func didTapagreeButton(_ sender: UIButton) {
        isAgree = !isAgree
        if isAgree {
            agreeButton.setImage(UIImage(named: "RigsterGroup")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            agreeButton.setImage(UIImage(named: "RigsterPath")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    @objc private func didTapRegister() {
        guard let phone = self.numberTextField.text,
              let countryCode = self.menuLabel.text,
              let sms = self.smsTextField.text,
              let email = self.emailTextField.text,
              let emailConfirm = self.emailConfirmTextField.text,
              let pwd = self.pwdTextField.text,
              let confirmPwd = self.confirmPwdTextField.text,
              phone != "",
              countryCode != "",
              sms != "",
              phone != "",
              email != "",
              emailConfirm != "",
              pwd != "",
              confirmPwd != ""
            else {
            print("Fail")
            self.toastFailedView.alpha = 1
            self.toastFailedView.isHidden = false
            UIView.animate(withDuration: 2.5) {
                self.toastFailedView.alpha = 0
            } completion: { (_) in
            }
            return
        }
        guard isAgree == true else { return }

        let countryCodePhone = countryCode+phone
        if self.inviteCodeTextField.text?.count ?? 0 > 0 {
            if let inviteCode = self.inviteCodeTextField.text {
                let parameters = [
                    "phone": "\(countryCodePhone)",
                    "smsCode": "\(sms)",
                    "email": "\(email)",
                    "emailcode": "\(emailConfirm)",
                    "password": "\(pwd)",
                    "confirmPwd": "\(confirmPwd)",
                    "isMobile": "true",
                    "invit": "\(inviteCode)"
                ]
                self.registerViewModel.register(parameters: parameters)
            }
        } else {
            let parameters = [
                "phone": "\(countryCodePhone)",
                "smsCode": "\(sms)",
                "email": "\(email)",
                "emailcode": "\(emailConfirm)",
                "password": "\(pwd)",
                "confirmPwd": "\(confirmPwd)",
                "isMobile": "true",
            ]
            self.registerViewModel.register(parameters: parameters)
        }
        
    }

    @objc private func gobackLogin() {
        self.dismiss(animated: true, completion: nil)
    }
}



extension RegisterViewController {
    func registSendEmailAPI(apiURL: String, param: String) {
        APIManager.shared.handleFetchAPI(apiURL: apiURL, param: param, completion: { data, response, error in
            if let err = error {
                //發生錯誤
                print("Failed to get data.", err)
            } else {
                if let data = data  {
                    do {
                        let json = try JSONDecoder().decode(RegistSendEmail.self, from: data)
                        print(json)
                    } catch {
                     print(error)
                    }
                }
            }
            
        })
    }
    
//    private func registerAPI(apiURL: String, param: String, completion: @escaping ((Result<Regist, Error>) -> Void)) {
//        APIManager.shared.handleFetchAPI(apiURL: apiURL, param: param, completion: { data, response, error in
//            if let err = error {
//                //發生錯誤
//                print("Failed to get data.", err)
//            } else {
//                if let data = data  {
//                    do {
//                        let json = try JSONDecoder().decode(Regist.self, from: data)
//                        print(json)
//                        completion(.success(json))
//                    } catch {
//                     print(error)
//                    }
//                }
//            }
//
//        })
//    }
}

class BottomView: UIView {
    
    init(backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
