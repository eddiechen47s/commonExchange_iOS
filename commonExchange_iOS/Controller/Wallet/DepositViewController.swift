//
//  DepositViewController.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/4/22.
//

import UIKit

class DepositViewController: UIViewController {
    var coinType: String!
    var viewModel = DepositViewModel()
    var depositAddressModel = [ChainDetail]()
    
    private lazy var titleLabel = BaseLabel(text: "存入\(coinType!.uppercased())", color: #colorLiteral(red: 0.1333333333, green: 0.2352941176, blue: 0.3254901961, alpha: 1), font: .systemFont(ofSize: 30, weight: .bold), alignments: .left)
    private let selectNetLabel = BaseLabel(text: "選擇主網", color: #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .left)
    private lazy var coinAdderssLabel = BaseLabel(text: "\(coinType!.uppercased())存入地址", color: #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), font: .systemFont(ofSize: 18, weight: .bold), alignments: .left)
    let addressLabel = BaseLabel(text: "19FDpQLUUVoWuQxKmptr1nbg9YaVDGrxAc", color: #colorLiteral(red: 0.1333333333, green: 0.2352941176, blue: 0.3254901961, alpha: 1), font: .systemFont(ofSize: 12, weight: .regular), alignments: .left)
    private let noticeLabel = BaseLabel(text: "注意", color: #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), alignments: .left)
    private lazy var xmrPaymentIDLabel = BaseLabel(text: "\(coinType!.uppercased()) PaymentID", color: #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), font: .systemFont(ofSize: 18, weight: .bold), alignments: .left)
    let paymentIDLabel = BaseLabel(text: "19FDpQLUUVoWuQxKmptr1nbg9YaVDGrxAc", color: #colorLiteral(red: 0.1333333333, green: 0.2352941176, blue: 0.3254901961, alpha: 1), font: .systemFont(ofSize: 12, weight: .regular), alignments: .left)
    
    private let qrCodeImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private var addressBottomView = BaseView(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
    private let tipView = BaseView(color: #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1))
    private let qrCodeContentViw = BaseView(color: .lightText)
    private let paymentIDView = BaseView(color: .white)
    private let paymentIDBottomView = BaseView(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
    
    private lazy var toastXMRView = WithdrawalToastView(img: warningImg, titleLabel: toastTitleLabel, detailLabel: toastDetailLabel, buttonTitle: "我已瞭解，確認使用", action: #selector(didTapToast), vc: self)
    private let warningImg = BaseImageView(image: "ic_warning", color: nil)
    private let toastTitleLabel = BaseLabel(text: "注意", color: .white, font: .systemFont(ofSize: 22, weight: .regular), alignments: .center)
    private let toastDetailLabel = BaseLabel(text: "將 XMR 存入您的KTrade帳戶時，請務必一起輸入 PaymentID 以及地址資訊。", color: .white, font: .systemFont(ofSize: 14, weight: .regular), alignments: .left)
    
    private let copyAddressButton: UIButton = {
        let button = UIButton()
        button.setTitle("複製地址", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor = #colorLiteral(red: 0.9098039216, green: 0.9254901961, blue: 0.937254902, alpha: 1)
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapCopy), for: .touchUpInside)
        return button
    }()
    
    private let copyPaymentIDButton: UIButton = {
        let button = UIButton()
        button.setTitle("複製地址", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor = #colorLiteral(red: 0.9098039216, green: 0.9254901961, blue: 0.937254902, alpha: 1)
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapCopy), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.register(DepositViewCell.self, forCellWithReuseIdentifier: DepositViewCell.identifier)
        return cv
    }()
    
    private lazy var ruleTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.textColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
        tv.isEditable = false
        return tv
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "存入"
        setupUI()
        customRuleText()
        setupLabelDetail()

        self.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .bottom)
        paymentIDView.isHidden = true
        if coinType == "XMR" {
            print("XMR")
            paymentIDView.isHidden = false
            qrCodeContentViw.snp.remakeConstraints { make in
                make.top.equalTo(paymentIDLabel.snp.bottom).offset(0)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(tipView.snp.top)
            }
            
            qrCodeImageView.snp.remakeConstraints {
                $0.center.equalTo(qrCodeContentViw.snp.center)
                $0.width.equalTo(qrCodeContentViw.snp.width).multipliedBy(0.4)
                $0.height.equalTo(qrCodeContentViw.snp.height).multipliedBy(0.8)
            }
        } else {
            print("Else")
            paymentIDView.isHidden = true
            
            qrCodeContentViw.snp.remakeConstraints { make in
                make.top.equalTo(addressBottomView.snp.bottom)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(tipView.snp.top)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Helpers
    private func setupLabelDetail() {
        self.addressLabel.numberOfLines = 3
        self.paymentIDLabel.numberOfLines = 3
        if depositAddressModel.count > 0 {
            self.addressLabel.text = depositAddressModel[0].address
            self.qrCodeImageView.image = generateQRCode(from: self.addressLabel.text!)
            self.paymentIDLabel.text = depositAddressModel[0].payment_id
        }
     
    }
    
    private func customRuleText() {
        guard let coinType = self.coinType else { return }
        toastXMRView.isHidden = true
        switch coinType {
        case "BTC":
            self.ruleTextView.attributedText = changeTextParaph(str: DepositRuleText.BTC.text)
        case "ETH":
            self.ruleTextView.attributedText = changeTextParaph(str: DepositRuleText.ETH.text)
        case "KT":
            self.ruleTextView.attributedText = changeTextParaph(str: DepositRuleText.KT.text)
        case "KCOIN":
            self.ruleTextView.attributedText = changeTextParaph(str: DepositRuleText.KCOIN.text)
        case "NULS":
            self.ruleTextView.attributedText = changeTextParaph(str: DepositRuleText.NULS.text)
        case "USDT":
            let attStr = self.changeAttributed(str: DepositRuleText.USDT.text, location: 53, length: 76)
            self.ruleTextView.attributedText = attStr
        case "DASH":
            self.ruleTextView.attributedText = changeTextParaph(str: DepositRuleText.DASH.text)
        case "XMR":
            toastXMRView.isHidden = false
            toastDetailLabel.numberOfLines = 2
            let attStr = self.changeAttributed(str: DepositRuleText.XMR.text, location: 53, length: 57)
            self.ruleTextView.attributedText = attStr
        case "XRP":
            let attStr = self.changeAttributed(str: DepositRuleText.XRP.text, location: 53, length: 50)
            self.ruleTextView.attributedText = attStr
        case "SBT":
            self.ruleTextView.attributedText = changeTextParaph(str: DepositRuleText.SBT.text)
        case "SOSR":
            self.ruleTextView.attributedText = changeTextParaph(str: DepositRuleText.SOSR.text)
        case "HLC":
            self.ruleTextView.attributedText = changeTextParaph(str: DepositRuleText.HLC.text)
        case "FTO":
            self.ruleTextView.attributedText = changeTextParaph(str: DepositRuleText.FTO.text)
        default:
            break
        }
    }
    
    private func setupUI() {
        view.addSubViews(titleLabel,
                         selectNetLabel,
                         collectionView,
                         coinAdderssLabel,
                         copyAddressButton,
                         addressLabel,
                         addressBottomView,
                         tipView,
                         paymentIDView,
                         qrCodeContentViw,
                         toastXMRView
        )
        
        paymentIDView.addSubViews(xmrPaymentIDLabel, copyPaymentIDButton, paymentIDLabel, paymentIDBottomView)
        qrCodeContentViw.addSubview(qrCodeImageView)
        
        tipView.addSubViews(noticeLabel, ruleTextView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.snp.left).offset(15)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalTo(40)
        }
        
        selectNetLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(15)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(selectNetLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(40)
        }
        
        coinAdderssLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(25)
            make.left.equalTo(view.snp.left).offset(15)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalTo(20)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(coinAdderssLabel.snp.bottom).offset(0)
            make.left.equalTo(view.snp.left).offset(15)
            make.right.equalTo(copyAddressButton.snp.left).offset(-10)
            make.height.equalTo(50)
        }
        
        copyAddressButton.snp.makeConstraints { make in
            make.top.equalTo(coinAdderssLabel.snp.top).offset(10)
            make.right.equalTo(view.snp.right).offset(-15)
            make.width.equalTo(view.snp.width).multipliedBy(0.2)
            make.bottom.equalTo(addressLabel.snp.bottom).offset(-15)
        }
        
        addressBottomView.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(1)
            make.left.equalTo(coinAdderssLabel.snp.left)
            make.right.equalTo(copyAddressButton.snp.right)
            make.height.equalTo(1)
        }
        
        tipView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.25)
        }
        
        noticeLabel.snp.makeConstraints { make in
            make.top.equalTo(tipView.snp.top).offset(15)
            make.left.equalTo(tipView.snp.left).offset(15)
            make.width.equalTo(tipView.snp.width)
            make.height.equalTo(20)
        }
        
        ruleTextView.snp.makeConstraints { make in
            make.top.equalTo(noticeLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalTo(tipView.snp.bottom)
        }
        
        paymentIDView.snp.makeConstraints { make in
            make.top.equalTo(addressBottomView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(60)
        }
        
        xmrPaymentIDLabel.snp.makeConstraints { make in
            make.top.equalTo(paymentIDView.snp.top)
            make.left.equalTo(paymentIDView.snp.left).offset(15)
            make.width.equalTo(paymentIDView.snp.width).multipliedBy(0.5)
            make.height.equalTo(30)
        }
        
        paymentIDLabel.snp.makeConstraints { make in
            make.top.equalTo(xmrPaymentIDLabel.snp.bottom)
            make.left.equalTo(view.snp.left).offset(15)
            make.right.equalTo(copyPaymentIDButton.snp.left).offset(-10)
            make.height.equalTo(50)
        }
        
        copyPaymentIDButton.snp.makeConstraints { make in
            make.top.equalTo(xmrPaymentIDLabel.snp.top).offset(10)
            make.right.equalTo(view.snp.right).offset(-15)
            make.width.equalTo(view.snp.width).multipliedBy(0.2)
            make.height.equalTo(40)
        }
        
        paymentIDBottomView.snp.makeConstraints { make in
            make.bottom.equalTo(paymentIDLabel.snp.bottom)
            make.left.equalTo(view.snp.left).offset(15)
            make.right.equalTo(view.snp.right).offset(-15)
            make.height.equalTo(1.5)
        }
        
        qrCodeContentViw.snp.makeConstraints { make in
            make.top.equalTo(addressBottomView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(tipView.snp.top)
        }
        
        qrCodeImageView.snp.makeConstraints { make in
            make.center.equalTo(qrCodeContentViw.snp.center)
            make.width.equalTo(qrCodeContentViw.snp.width).multipliedBy(0.45)
            make.height.equalTo(qrCodeContentViw.snp.height).multipliedBy(0.6)
        }
        
        toastXMRView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(view.snp.height).multipliedBy(0.38)
        }
        
        copyAddressButton.setBackgroundColor(#colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1), forState: .highlighted)
        copyAddressButton.setTitleColor(.white, for: .highlighted)
    }
    
    
    func changeAttributed(str: String, location: Int, length: Int) -> NSMutableAttributedString {
        let attributedQuote = NSMutableAttributedString(string: str)
        attributedQuote.addAttribute(.foregroundColor, value: UIColor(red: 245/255, green: 70/255, blue: 93/255, alpha: 1), range: NSRange(location: location, length: length))
        attributedQuote.addAttribute(.font, value: UIFont.systemFont(ofSize: 13, weight: .bold), range: NSRange(location: location, length: length))
        return attributedQuote
    }
    
    func changeTextParaph(str: String) -> NSAttributedString {
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = 4
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1),
                          NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13, weight: .bold),
                          NSAttributedString.Key.paragraphStyle: paraph]
        let newString = NSAttributedString(string: str, attributes: attributes)
        return newString
    }
    
    // MARK: - Selector
    @objc private func didTapCopy() {
        guard let address = self.addressLabel.text else { return }
        UIPasteboard.general.string = address
        setupToast()
    }
    @objc private func didTapCopyPayment() {
        guard let address = self.addressLabel.text else { return }
        UIPasteboard.general.string = address
        setupToast()
    }
    @objc private func didTapToast() {
        toastXMRView.isHidden = true
    }
    
}

extension DepositViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return depositAddressModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let vm = depositAddressModel[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DepositViewCell.identifier, for: indexPath) as? DepositViewCell else {
            fatalError("DepositViewCell nil")
        }
        cell.configure(with: vm)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.size.width/4)-5, height: self.collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.addressLabel.text = depositAddressModel[indexPath.row].address
        self.qrCodeImageView.image = generateQRCode(from: self.addressLabel.text!)
        self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
    }

}




