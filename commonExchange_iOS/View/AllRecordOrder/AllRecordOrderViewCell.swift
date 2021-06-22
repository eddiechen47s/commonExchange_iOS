//
//  AllRecordOrderViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/20.
//

import UIKit

class AllRecordOrderViewCell: BaseTableViewCell {
    static let identifier = "AllRecordOrderViewCell"
    private let bottomView = BaseView(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
    
    private let baseLabel = BaseLabel(text: "ETH", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 15, weight: .bold), alignments: .left)
    private let targetLabel = BaseLabel(text: "", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 12, weight: .regular), alignments: .left)
    private let priceLabel = BaseLabel(text: "2021-04-21 22:10:15", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 13, weight: .regular), alignments: .left)
    private let amountLabel = BaseLabel(text: "10", color: #colorLiteral(red: 0.9601823688, green: 0.2764334977, blue: 0.3656736016, alpha: 1), font: .systemFont(ofSize: 15, weight: .bold), alignments: .right)
    private let totalLabel = BaseLabel(text: "10", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 12, weight: .regular), alignments: .right)
    
    func configure(with vm: AllOrderRecord) {
        print(vm)
        let num = (vm.num as NSString).doubleValue
        let price = (vm.price as NSString).doubleValue
        let total = (num*price)
        
        self.baseLabel.text = vm.market.split(separator: "_")[0].uppercased()
        self.targetLabel.text = "/ " + vm.market.split(separator: "_")[1].uppercased()
        self.priceLabel.text = (vm.price as NSString).doubleValue.toString(maxF: 9)+" "+vm.market.split(separator: "_")[1].uppercased()
        self.amountLabel.text = num.toString(maxF: 9)
        self.totalLabel.text = total.toString(maxF: 9)
        
        // 買入
        if vm.type == 1 {
            self.amountLabel.textColor = #colorLiteral(red: 0.2333128452, green: 0.7429219484, blue: 0.5215145946, alpha: 1)
        } else {
            self.amountLabel.textColor = #colorLiteral(red: 0.9601823688, green: 0.2764334977, blue: 0.3656736016, alpha: 1)
        }
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
            make.left.equalTo(snp.left).offset(15)
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
            make.right.equalTo(snp.right).offset(-15)
            make.width.equalTo(snp.width).multipliedBy(0.28)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(baseLabel.snp.bottom)
            make.left.equalTo(snp.left).offset(15)
            make.width.equalTo(snp.width).multipliedBy(0.4)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.top)
            make.right.equalTo(snp.right).offset(-16)
            make.width.equalTo(snp.width).multipliedBy(0.28)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
