//
//  HistoryOrderViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/5.
//

import UIKit

// 訂單->歷史委託 cell
class HistoryOrderViewCell: BaseTableViewCell {
    static let identifier = "HistoryOrderViewCell"
    private let bottomView = BaseView(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
    
    let baseLabel = BaseLabel(text: "ETH", color: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 17, weight: .bold), alignments: .left)
    let targetLabel = BaseLabel(text: " / BTC", color: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 12, weight: .regular), alignments: .left)
    private let timeLabel = BaseLabel(text: "2021-04-21 22:10:15", color: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 11, weight: .regular), alignments: .left)
    let dealLabel = BaseLabel(text: "10", color: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 15, weight: .bold), alignments: .right)
    private let amountLabel = BaseLabel(text: "10", color: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 12, weight: .regular), alignments: .right)
    //價格
    let priceLabel = BaseLabel(text: "", color: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 15, weight: .bold), alignments: .right)
    
    func configure(with vm: AllOrderRecord) {
        let num = (vm.num as NSString).doubleValue
        let price = (vm.price as NSString).doubleValue
        let total = (num*price)
        self.baseLabel.text = vm.market.split(separator: "_")[0].uppercased()
        self.targetLabel.text = "/ " + vm.market.split(separator: "_")[1].uppercased()
        self.timeLabel.text = timeToSecondStamp(time: String(vm.addtime))
        self.amountLabel.text = total.toString(maxF: 9)
        self.dealLabel.text = num.toString(maxF: 9)
        self.priceLabel.text = price.toString(maxF: 8)
        
        self.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
    }
    
    override func setupUI() {
        addSubViews(baseLabel,
                    bottomView,
                    targetLabel,
                    dealLabel,
                    timeLabel,
                    amountLabel,
                    priceLabel
        )
        
        baseLabel.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(10)
            $0.left.equalTo(snp.left).offset(15)
            $0.width.equalTo(45)
            $0.height.equalTo(snp.height).multipliedBy(0.4)
        }
        
        targetLabel.snp.makeConstraints {
            $0.centerY.equalTo(baseLabel.snp.centerY).offset(1)
            $0.left.equalTo(baseLabel.snp.right)
            $0.width.equalTo(50)
            $0.height.equalTo(baseLabel.snp.height).multipliedBy(0.8)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(baseLabel.snp.top)
            $0.right.equalTo(dealLabel.snp.left)
            $0.width.equalTo(snp.width).multipliedBy(0.28)
            $0.height.equalTo(snp.height).multipliedBy(0.4)
        }
        
        dealLabel.snp.makeConstraints {
            $0.top.equalTo(baseLabel.snp.top)
            $0.right.equalTo(snp.right).offset(-15)
            $0.width.equalTo(snp.width).multipliedBy(0.28)
            $0.height.equalTo(snp.height).multipliedBy(0.4)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(baseLabel.snp.bottom)
            $0.left.equalTo(snp.left).offset(15)
            $0.width.equalTo(snp.width).multipliedBy(0.4)
            $0.height.equalTo(snp.height).multipliedBy(0.4)
        }
        
        amountLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.top)
            $0.right.equalTo(snp.right).offset(-16)
            $0.width.equalTo(snp.width).multipliedBy(0.28)
            $0.height.equalTo(snp.height).multipliedBy(0.4)
        }
        
        bottomView.snp.makeConstraints {
            $0.bottom.equalTo(snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}

