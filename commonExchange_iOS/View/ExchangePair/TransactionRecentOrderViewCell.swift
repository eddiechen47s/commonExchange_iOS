//
//  TransactionRecentOrderViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/3.
//

import UIKit

class TransactionRecentOrderViewCell: BaseTableViewCell {
    static let identifier = "TransactionRecentOrderViewCell"
    private let bottomView = BaseView(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
    
    private let baseLabel = BaseLabel(text: "ETH", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), alignments: .left)
    private let targetLabel = BaseLabel(text: " / BTC", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 12, weight: .regular), alignments: .left)
    private let priceLabel = BaseLabel(text: "0.0234 BTC", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 13, weight: .regular), alignments: .left)
    
    private let amountLabel = BaseLabel(text: "1", color: #colorLiteral(red: 0.9601823688, green: 0.2764334977, blue: 0.3656736016, alpha: 1), font: .systemFont(ofSize: 15, weight: .bold), alignments: .right)
    private let totalLabel = BaseLabel(text: "10", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 12, weight: .regular), alignments: .right)
    
    func configure(with vm: TransactionRecentOrder) {
        self.baseLabel.text = String(vm.market.uppercased().split(separator: "_")[0])
        self.targetLabel.text = String(" / "+vm.market.uppercased().split(separator: "_")[1])
        let price = (vm.price as NSString).doubleValue
        let num = (vm.num as NSString).doubleValue
        self.priceLabel.text = price.toString(maxF:5)
        self.amountLabel.text = vm.num
        self.totalLabel.text = (price*num).toString(maxF:6)
    }

    override func setupUI() {
        addSubViews(baseLabel,
                    bottomView,
                    targetLabel,
                    amountLabel,
                    priceLabel,
                    totalLabel
                    )
        
        baseLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(10)
            make.left.equalTo(snp.left).offset(20)
            make.width.equalTo(45)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }
        
        targetLabel.snp.makeConstraints { make in
            make.centerY.equalTo(baseLabel.snp.centerY).offset(1)
            make.left.equalTo(baseLabel.snp.right)
            make.width.equalTo(50)
            make.height.equalTo(baseLabel.snp.height).multipliedBy(0.8)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(baseLabel.snp.top)
            make.right.equalTo(snp.right).offset(-20)
            make.width.equalTo(snp.width).multipliedBy(0.28)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(baseLabel.snp.bottom)
            make.left.equalTo(snp.left).offset(20)
            make.width.equalTo(snp.width).multipliedBy(0.4)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.top)
            make.right.equalTo(snp.right).offset(-20)
            make.width.equalTo(snp.width).multipliedBy(0.28)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
}
