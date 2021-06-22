//
//  VerifiedViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/23.
//

import UIKit
import RxSwift
import RxCocoa

class VerifiedViewController: UIViewController {
    let disposeBag = DisposeBag()
    var resetViewModel = ResetVerifyViewModel()
    
    
    var is2FA = true
    private let verifiedView = BaseView(color: .white)
    private lazy var verifiedSuccessView = GoogleVerifiedToastView(img: toastSuccessImg, titleLabel: toastSTitleLabel)
    private lazy var verifiedFailedView = GoogleVerifiedToastView(img: toastFailedImg, titleLabel: toastFTitleLabel)
    
    private let toastSuccessImg = BaseImageView(image: "Yes", color: nil)
    private let toastFailedImg = BaseImageView(image: "No", color: nil)
    
    private let verifiedLabel = BaseLabel(text: "Google驗證", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), alignments: .left)
    private let verifiedTipLabel = BaseLabel(text: "Google驗證器APP將保障您的帳戶和提領功能。", color: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 14, weight: .bold), alignments: .left)
    private let toastSTitleLabel = BaseLabel(text: "成功", color: .white, font: .systemFont(ofSize: 22, weight: .regular), alignments: .center)
    private let toastFTitleLabel = BaseLabel(text: "失敗", color: .white, font: .systemFont(ofSize: 22, weight: .regular), alignments: .center)
    
    private lazy var verifiedSwitch: UISwitch = {
       let control = UISwitch()
        control.isOn = is2FA
        control.addTarget(self, action: #selector(didTapSwitch(_:)), for: .valueChanged)
        return control
    }()
    
    private var userInfoVM = UserInfoViewModel()
    private let bisposeBag = DisposeBag()
//    private var isUserLogin: Bool = false
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        self.title = "安全驗證"
        self.tabBarController?.tabBar.isHidden = true

        setupUI()
        setupUIDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindingResetAnimate()
        bindingUserGA()
    }
    
    deinit {
        print("VerifiedViewController deinit")
    }
    
    // MARK: - Helpers
    
    private func bindingUserGA() {
        LoadingView.shared.showLoader()

        if userDefaults.bool(forKey: "isUserLogin") {
            if let token = userDefaults.string(forKey: "UserToken")  {
                print(token)
                let param = "token=\(token)"
                userInfoVM.getUserInfo(param: param) { (_) in }
                userInfoVM.userGAStatus
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { [weak self] gaStatus in
                        self?.verifiedSwitch.isOn = gaStatus
                    }).disposed(by: bisposeBag)
            } else {
            }
            
        } else {
            self.verifiedSwitch.isOn = false
        }
        LoadingView.shared.hideLoader()
    }

    
    private func bindingResetAnimate() {
        resetViewModel.isResetStatus
            .subscribe(onNext: {[weak self] status in
                if status {
                    self?.verifiedSuccessView.alpha = 1
                    UIView.animate(withDuration: 2.5) {
                        self?.verifiedSuccessView.alpha = 0
                    } completion: { (_) in
                    }
                } else {
                    self?.verifiedFailedView.alpha = 1
                    UIView.animate(withDuration: 2.5) {
                        self?.verifiedFailedView.alpha = 0
                    } completion: { (_) in
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        view.addSubViews(verifiedView,
                         verifiedTipLabel,
                         verifiedSuccessView,
                         verifiedFailedView
                        )
        verifiedView.addSubViews(verifiedLabel, verifiedSwitch)
        
        verifiedView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.left.right.equalToSuperview()
            make.height.equalTo(70)
        }
        
        verifiedLabel.snp.makeConstraints { make in
            make.centerY.equalTo(verifiedView.snp.centerY)
            make.left.equalTo(verifiedView.snp.left).offset(15)
            make.width.equalTo(verifiedView.snp.width).multipliedBy(0.5)
            make.height.equalTo(verifiedView.snp.height)
        }
        
        verifiedSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(verifiedView.snp.centerY)
            make.right.equalTo(verifiedView.snp.right).offset(-15)
            make.width.equalTo(50)
            make.height.equalTo(verifiedView.snp.height).multipliedBy(0.5)
        }
        
        verifiedTipLabel.snp.makeConstraints { make in
            make.top.equalTo(verifiedView.snp.bottom)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(70)
        }
        
        verifiedSuccessView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
        
        verifiedFailedView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
    }
    
    private func setupUIDetail() {
        verifiedSuccessView.alpha = 0
        verifiedFailedView.alpha = 0
    }
    
    @objc private func didTapSwitch(_ sender: UISwitch!) {
        
        if sender.isOn {
            if userDefaults.bool(forKey: "isUserLogin") {
                let controller = BindingGoogleViewController()
                controller.delegate = self
                self.navigationController?.pushViewController(controller, animated: true)
            } else {
                self.verifiedSwitch.isOn = false
            }
          
        } else {
            let controller = ResetVerifyViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

}

extension VerifiedViewController: BindingVerifiedStatusDelegate {
    func backToVerified(isSuccess: Bool) {
        DispatchQueue.main.async {
            self.verifiedSwitch.isOn = isSuccess
            self.navigationController?.popViewController(animated: false)
            if isSuccess {
                self.verifiedSuccessView.alpha = 1
                UIView.animate(withDuration: 2.5) {
                    self.verifiedSuccessView.alpha = 0
                } completion: { (_) in
                }

            } else {
                self.verifiedFailedView.alpha = 1
                UIView.animate(withDuration: 2.5) {
                    self.verifiedFailedView.alpha = 0
                } completion: { (_) in
                }
            }
        }

  
    }
}
