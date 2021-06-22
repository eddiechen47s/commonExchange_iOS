//
//  AllFinishRecordViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/28.
//

import UIKit

class AllFinishRecordViewCell: BaseTableViewCell {
    static let identifier = "AllFinishRecordViewCell"
    private let bottomView = BaseView(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
    
    private let baseLabel = BaseLabel(text: "ETH", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 18, weight: .bold), alignments: .left)
    private let targetLabel = BaseLabel(text: " / BTC", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 13, weight: .regular), alignments: .left)
    private let timeLabel = BaseLabel(text: "2021-04-21 22:10:15", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 11, weight: .regular), alignments: .left)
    
    private let averagePriceLabel = BaseLabel(text: "0.039688", color: #colorLiteral(red: 0.9601823688, green: 0.2764334977, blue: 0.3656736016, alpha: 1), font: .systemFont(ofSize: 15, weight: .bold), alignments: .right)
    private let feeLabel = BaseLabel(text: "0.039688", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 12, weight: .regular), alignments: .right)
    private let amountLabel = BaseLabel(text: "10", color: #colorLiteral(red: 0.9601823688, green: 0.2764334977, blue: 0.3656736016, alpha: 1), font: .systemFont(ofSize: 15, weight: .bold), alignments: .right)
    private let totalLabel = BaseLabel(text: "10", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 12, weight: .regular), alignments: .right)
    
    func configure(with vm: AllFinishRecord) {
        self.baseLabel.text = vm.market.split(separator: "_")[0].uppercased()
        self.targetLabel.text = "/ " + vm.market.split(separator: "_")[1].uppercased()
        let time = timeToSecondStamp(time: String(vm.addtime))
        self.timeLabel.text = time.replacingOccurrences(of: "/", with: "-")
        self.amountLabel.text = (vm.deal as NSString).doubleValue.toString(maxF: 5)
        self.averagePriceLabel.text = roundOffZero(str: vm.price)
        self.feeLabel.text = (vm.fee as NSString).doubleValue.toString(maxF: 8)
        let total = (vm.num as NSString).doubleValue*(vm.price as NSString).doubleValue
        self.totalLabel.text = total.toString(maxF:5)

        // 買入
        if vm.type == 1 {
            self.amountLabel.textColor = #colorLiteral(red: 0.2333128452, green: 0.7429219484, blue: 0.5215145946, alpha: 1)
            self.averagePriceLabel.textColor = #colorLiteral(red: 0.2333128452, green: 0.7429219484, blue: 0.5215145946, alpha: 1)
        } else {
            self.amountLabel.textColor = #colorLiteral(red: 0.9601823688, green: 0.2764334977, blue: 0.3656736016, alpha: 1)
            self.averagePriceLabel.textColor = #colorLiteral(red: 0.9601823688, green: 0.2764334977, blue: 0.3656736016, alpha: 1)
        }
    }
    
    override func setupUI() {
        addSubViews(baseLabel,
                    bottomView,
                    targetLabel,
                    amountLabel,
                    averagePriceLabel,
                    timeLabel,
                    feeLabel,
                    totalLabel
                    )
        
        baseLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(10)
            make.left.equalTo(snp.left).offset(15)
            make.width.equalTo(40)
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
        
        averagePriceLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(10)
            make.right.equalTo(amountLabel.snp.left)
            make.width.equalTo(snp.width).multipliedBy(0.3)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(baseLabel.snp.bottom)
            make.left.equalTo(snp.left).offset(15)
            make.width.equalTo(snp.width).multipliedBy(0.4)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }
        
        feeLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.top)
            make.right.equalTo(amountLabel.snp.left)
            make.width.equalTo(snp.width).multipliedBy(0.4)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.top)
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

