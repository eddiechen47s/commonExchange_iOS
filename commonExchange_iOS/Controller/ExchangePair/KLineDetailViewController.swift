//
//  KLineValueViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/10.
//

import UIKit

class KLineDetailViewController: UIViewController {
    
    private let pricePercentView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2776432037, green: 0.6590948701, blue: 0.4378901124, alpha: 1)
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let lastesPriceLabel = BaseLabel(text: "", color: #colorLiteral(red: 0.3349374631, green: 0.3326274761, blue: 0.3325625666, alpha: 1), font: .systemFont(ofSize: 30, weight: .heavy), alignments: .left)
    private lazy var volumeLabel = BaseLabel(text: "成交量 ", color: #colorLiteral(red: 0.3349374631, green: 0.3326274761, blue: 0.3325625666, alpha: 1), font: .systemFont(ofSize: 14, weight: .light), alignments: .left)
    private let pricePercentLabel = BaseLabel(text: "", color: .white, font: .systemFont(ofSize: 20, weight: .regular), alignments: .center)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.pricePercentView.isHidden = true
        self.volumeLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(closePrice(notification:)), name: Notification.Name("closePrice"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(labelRise(notification:)), name: Notification.Name("labelRise"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(labelVol(notification:)), name: Notification.Name("labelVol"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    deinit {
        print("KLineDetailViewController deinit")
    }
    
    // MARK: - Helpers
    private func setupUI() {
        view.addSubViews(lastesPriceLabel,
                         volumeLabel,
                         pricePercentView)
        pricePercentView.addSubview(pricePercentLabel)
        
        lastesPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left).offset(15)
            make.right.equalTo(pricePercentView.snp.left).offset(-10)
            make.height.equalTo(view.snp.height).multipliedBy(0.8)
        }

        volumeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-10)
            make.left.equalTo(lastesPriceLabel.snp.left)
            make.width.equalTo(view.snp.width).multipliedBy(0.35)
            make.height.equalTo(view.snp.height).multipliedBy(0.3)
        }
        
        pricePercentView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY).offset(-10)
            make.right.equalTo(view.snp.right).offset(-15)
            make.width.equalTo(view.snp.width).multipliedBy(0.28)
            make.height.equalTo(view.snp.height).multipliedBy(0.45)
        }
        
        pricePercentLabel.snp.makeConstraints { make in
            make.center.equalTo(pricePercentView.snp.center)
            make.width.equalTo(pricePercentView.snp.width)
            make.height.equalTo(pricePercentView.snp.height)
        }
    }
    
    // MARK: - Selector
    @objc func closePrice(notification: Notification) {
        guard let info = notification.object as? String else { return }
        let price = (info as NSString).doubleValue.toString(maxF:8)
        self.lastesPriceLabel.text = price
    }
    
    @objc func labelRise(notification: Notification) {
        guard let info = notification.object as? String else { return }
        let rise = (info as NSString).doubleValue
        if rise > 0 {
            self.pricePercentLabel.backgroundColor = #colorLiteral(red: 0.2776432037, green: 0.6590948701, blue: 0.4378901124, alpha: 1)
            self.pricePercentLabel.text = "+"+info
        } else if rise < 0 {
            self.pricePercentLabel.backgroundColor = #colorLiteral(red: 0.9990773797, green: 0.2295021415, blue: 0.1888831556, alpha: 1)
            self.pricePercentLabel.text = info
        } else {
            self.pricePercentLabel.backgroundColor = #colorLiteral(red: 0.5882352941, green: 0.5882352941, blue: 0.5882352941, alpha: 1)
            self.pricePercentLabel.text = info
        }
    }
    
    @objc func labelVol(notification: Notification) {
        guard let info = notification.object as? String else { return }
        self.volumeLabel.text = "成交量 "+info
        if info != "" {
            self.pricePercentView.isHidden = false
            self.volumeLabel.isHidden = false
        }
    }
    

}
