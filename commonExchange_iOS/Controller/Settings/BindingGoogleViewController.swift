//
//  BindingGoogleViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/23.
//

import UIKit

protocol BindingVerifiedStatusDelegate: AnyObject {
    func backToVerified(isSuccess: Bool)
}

class BindingGoogleViewController: UIViewController {
    // 修复侧滑丢失
    private var naDelegate: UIGestureRecognizerDelegate?
    var delegate: BindingVerifiedStatusDelegate?
    var viewModel = BindingGoogleViewModel()
    private let addressContentView = BaseView(color: .white)
    private let addressBottomView = BaseView(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
    private let qrCodeContentViwe = BaseView(color: #colorLiteral(red: 0.9968166947, green: 1, blue: 0.9963441491, alpha: 1))

    private let titleLabel = BaseLabel(text: "綁定Google驗證器", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 28, weight: .bold), alignments: .left)
    private let tipLabel = BaseLabel(text: "請妥善備份密鑰以防遺失", color: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 22, weight: .heavy), alignments: .left)
    private let addressLabel = BaseLabel(text: "", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3254901961, alpha: 1), font: .systemFont(ofSize: 13, weight: .heavy), alignments: .left)
    
    private let qrCodeImageView = BaseImageView(image: "", color: nil)
    
    private let ruleTextView: UITextView = {
       let tv = UITextView()
        tv.backgroundColor = .clear
        tv.textColor = #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1)
        tv.isEditable = false
        tv.textAlignment = .left
        tv.textContainerInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tv.font = .systemFont(ofSize: 16, weight: .bold)
        tv.text = """
                *請把密鑰保存在紙上，密鑰可在你丟失手機時，幫助你恢復Google驗證。
                *請注意，保存Qrcode到手機或複製到剪貼簿可能會有安全風險。
                """
        return tv
    }()
    
    private let copyButton: UIButton = {
        let button = UIButton()
        button.setTitle("複製", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = #colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.9358595014, alpha: 1)
        button.addTarget(self, action: #selector(didTapCopy), for: .touchUpInside)
        return button
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("下一步", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.9358595014, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingGA()
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
    func bindingGA() {
        LoadingView.shared.showLoader()
        guard let token = userDefaults.string(forKey: "UserToken") else {
            return
        }
        let param = "token=\(token)"
        print(param)
        viewModel.getGoogleKey(apiURL: "user/getGoogleKey?", param: param) { [weak self] auth in
            DispatchQueue.main.async {
                self?.addressLabel.text = auth.key
                self?.qrCodeImageView.image = self?.generateQRCode(from: auth.qrcode)
                LoadingView.shared.hideLoader()
            }
        }

    }
    
    func setupUIDetail() {
        let image = generateQRCode(from: self.addressLabel.text!)
        qrCodeImageView.image = image
        
        confirmButton.setBackgroundColor(#colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1), forState: .highlighted)
        confirmButton.setTitleColor(.white, for: .highlighted)
        confirmButton.layer.cornerRadius = 5
    }
    
    private func setupUI() {
        view.addSubViews(titleLabel,
                         addressContentView,
                         qrCodeContentViwe,
                         ruleTextView,
                         confirmButton
                        )
        addressContentView.addSubViews(tipLabel,
                                       addressLabel,
                                       addressBottomView,
                                       copyButton)
        qrCodeContentViwe.addSubview(qrCodeImageView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.snp.left).offset(15)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(40)
        }
        
        addressContentView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.snp.width).multipliedBy(0.6)
            make.height.equalTo(120)
        }
        
        tipLabel.snp.makeConstraints { make in
            make.top.equalTo(addressContentView.snp.top).offset(10)
            make.centerX.equalTo(addressContentView.snp.centerX)
            make.width.equalTo(addressContentView.snp.width).multipliedBy(1.2)
            make.height.equalTo(30)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(tipLabel.snp.bottom).offset(15)
            make.left.equalTo(tipLabel.snp.left)
            make.width.equalTo(addressContentView.snp.width).multipliedBy(0.7)
            make.height.equalTo(50)
        }

        addressBottomView.snp.makeConstraints { make in
            make.bottom.equalTo(addressLabel.snp.bottom)
            make.left.equalTo(addressLabel.snp.left)
            make.right.equalTo(addressLabel.snp.right)
            make.height.equalTo(1)
        }
        
        copyButton.snp.makeConstraints { make in
            make.bottom.equalTo(addressBottomView.snp.bottom)
            make.left.equalTo(addressLabel.snp.right).offset(10)
            make.right.equalTo(addressContentView.snp.right)
            make.height.equalTo(addressLabel.snp.height)
        }
        
        qrCodeContentViwe.snp.makeConstraints { make in
            make.top.equalTo(addressContentView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.3)
        }
        
        qrCodeImageView.snp.makeConstraints { make in
            make.center.equalTo(qrCodeContentViwe.snp.center)
            make.width.equalTo(qrCodeContentViwe.snp.width).multipliedBy(0.4)
            make.height.equalTo(qrCodeContentViwe.snp.height).multipliedBy(0.7)
        }
        
        ruleTextView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(confirmButton.snp.top)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }

    }
    
    // MARK: - Selector
    @objc private func didTapCopy() {
        UIPasteboard.general.string = self.addressLabel.text
        setupToast()
    }
    
    @objc private func didTapConfirm() {
        let controller = GoogleVerifiedViewController()
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension BindingGoogleViewController: GoogleVerifiedStatusDelegate {
    func backToVerified(isSuccess: Bool) {
        self.delegate?.backToVerified(isSuccess: isSuccess)
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: false)
        }
    }
}
