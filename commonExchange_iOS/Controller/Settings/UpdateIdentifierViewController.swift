//
//  UpdateIdentifierViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/15.
//

import UIKit
import RxSwift
import RxCocoa

class UpdateIdentifierViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    var isUploadStatus: PublishRelay<Bool> = PublishRelay<Bool>()
    
    private lazy var ruleTextView: UITextView = {
       let tv = UITextView()
        tv.backgroundColor = .clear
        tv.textColor = #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)
        tv.isEditable = false
        tv.font = .systemFont(ofSize: 16, weight: .bold)
        tv.attributedText = changeAttributeds(str: UploadIdentityText.Rule.text)
        return tv
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("繼續", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6063553095, green: 0.6064450741, blue: 0.60633564, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9188848138, green: 0.9250317216, blue: 0.9358595014, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        self.title = "上傳身分證"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        binding()
    }
    
    // MARK: - Helpers
    func binding() {
        AFManager.shared.isUploadStatus
            .subscribe(onNext: { [weak self] result in
                if result {
//                    self?.navigationController?.popToRootViewController(animated: false)
                }
                self?.isUploadStatus.accept(false)
            })
            .disposed(by: disposeBag)
            
    }
    
    private func setupUI() {
        view.addSubViews(ruleTextView, confirmButton)
        ruleTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(view.snp.height).multipliedBy(0.7)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        confirmButton.setBackgroundColor(#colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1), forState: .highlighted)
        confirmButton.setTitleColor(.white, for: .highlighted)
    }
    
    func changeAttributeds(str: String) -> NSMutableAttributedString {
        let attributedQuote = NSMutableAttributedString(string: str)
        attributedQuote.addAttribute(.font, value: UIFont.systemFont(ofSize: 18, weight: .bold), range: NSRange(location: 0, length: 4))
        attributedQuote.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .regular), range: NSRange(location: 5, length: 172))
        attributedQuote.addAttribute(.font, value: UIFont.systemFont(ofSize: 18, weight: .bold), range: NSRange(location: 173, length: 4))
        attributedQuote.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .regular), range: NSRange(location: 177, length: 77))
        attributedQuote.addAttribute(.foregroundColor, value: UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), range: NSRange(location: 0, length: 257))
        return attributedQuote
    }

    // MARK: - Selector
    @objc private func didTapConfirm() {
        let alertVC = AlertManager.shared.uploadPhotoMask()
        alertVC.delegate = self
        self.present(alertVC, animated: true, completion: nil)
    }

}

extension UpdateIdentifierViewController: UploadDelegate{
    func uploadStatus(isSuccess: Bool) {
        if isSuccess {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
}
