//
//  OderDetaiTypeViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/12.
//

import UIKit

class OderDetaiTypeViewCell: UICollectionViewCell {
    static let identifier = "OderDetaiTypeViewCell"
    
    let titleLabel = BaseLabel(text: "ETH / BTC", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 26, weight: .regular), alignments: .center)
    let statusLabel = BaseLabel(text: "成交 100%", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .center)
    private let SeparateView = BaseView(color: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1))
    private let mainLabel = BaseLabel(text: "訂單類型", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .left)
    private let priceLabel = BaseLabel(text: "價格", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .left)
//    private let averagelLabel = BaseLabel(text: "均價", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .left)
    private let amountlLabel = BaseLabel(text: "數量", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .left)
    private let totallLabel = BaseLabel(text: "總額", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .left)
    
    //訂單類型
    let coinStatusLabel = BaseLabel(text: "賣出", color: #colorLiteral(red: 0.9601823688, green: 0.2764334977, blue: 0.3656736016, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), alignments: .right)
    private let priceDetailLabel = BaseLabel(text: "TWD", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 13, weight: .regular), alignments: .right)
    private let amountlDetailLabel = BaseLabel(text: "MAX", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 13, weight: .regular), alignments: .right)
    private let totallDetailLabel = BaseLabel(text: "TWD", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 13, weight: .regular), alignments: .right)
    
    private let mainValueLabel = BaseLabel(text: "", color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .right)
    //價格
    let priceValueLabel = BaseLabel(text: "3.29", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), alignments: .right)
    let amountlValueLabel = BaseLabel(text: "75.99", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), alignments: .right)
    let totallValueLabel = BaseLabel(text: "250.01", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), alignments: .right)
    
    private lazy var titleStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [mainLabel, priceLabel, amountlLabel, totallLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var detailStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [coinStatusLabel, priceDetailLabel, amountlDetailLabel, totallDetailLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var valueStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [mainValueLabel, priceValueLabel, amountlValueLabel, totallValueLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.9960784314, blue: 0.9960784314, alpha: 1)
    }
    
    func configure(with vm: AllOrderRecord) {
        self.titleLabel.text = vm.market.uppercased().split(separator: "_")[0]+" / "+vm.market.uppercased().split(separator: "_")[1]
        self.priceValueLabel.text = (vm.price as NSString).doubleValue.toString(maxF: 9)
        self.amountlValueLabel.text = (vm.num as NSString).doubleValue.toString(maxF: 9)
        let total = ((vm.num as NSString).doubleValue * (vm.price as NSString).doubleValue).toString(maxF: 9)
        print(total)
        self.totallValueLabel.text = total
        self.priceDetailLabel.text = String(vm.market.uppercased().split(separator: "_")[1])
 
        self.amountlDetailLabel.text = String(vm.market.uppercased().split(separator: "_")[0])
        self.totallDetailLabel.text = String(vm.market.uppercased().split(separator: "_")[1])
        self.statusLabel.text = "0"+" / "+vm.num
        if vm.type == 1 {
            self.coinStatusLabel.text = "買入"
            self.coinStatusLabel.textColor = #colorLiteral(red: 0.2776432037, green: 0.6590948701, blue: 0.4378901124, alpha: 1)
        } else {
            self.coinStatusLabel.text = "賣出"
            self.coinStatusLabel.textColor = #colorLiteral(red: 0.9601823688, green: 0.2764334977, blue: 0.3656736016, alpha: 1)
        }
    }
    
    private func setupUI() {
        addSubViews(titleLabel,
                    statusLabel,
                    SeparateView,
                    titleStack,
                    detailStack,
                    valueStack
        )
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(15)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width)
            make.height.equalTo(20)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width)
            make.height.equalTo(20)
        }
        
        SeparateView.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(2)
        }
        
        titleStack.snp.makeConstraints { make in
            make.top.equalTo(SeparateView.snp.bottom).offset(15)
            make.left.equalTo(snp.left).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(180)
        }
        
        detailStack.snp.makeConstraints { make in
            make.top.equalTo(SeparateView.snp.bottom).offset(15)
            make.right.equalTo(SeparateView.snp.right)
            make.width.equalTo(40)
            make.height.equalTo(180)
        }
        
        valueStack.snp.makeConstraints { make in
            make.top.equalTo(SeparateView.snp.bottom).offset(15)
            make.right.equalTo(detailStack.snp.left).offset(-3)
            make.width.equalTo(100)
            make.height.equalTo(180)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class OrderContainerView: UIView {
    private let titleLabel = BaseLabel(text: "1", color: .black, font: .systemFont(ofSize: 14, weight: .medium), alignments: .left)
    private let detailLabel = BaseLabel(text: "2", color: .black, font: .systemFont(ofSize: 14, weight: .medium), alignments: .right)
    
    init(title: String, detail: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.detailLabel.text = detail
        
        addSubViews(titleLabel,
                    detailLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left)
            make.width.equalTo(snp.width).multipliedBy(0.5)
            make.height.equalTo(snp.height)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(snp.right)
            make.width.equalTo(snp.width).multipliedBy(0.5)
            make.height.equalTo(snp.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
