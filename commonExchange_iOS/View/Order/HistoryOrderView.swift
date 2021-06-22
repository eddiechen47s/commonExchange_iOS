//
//  HistoryOrderView.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/8.
//

import UIKit

class HistoryOrderView: UITableViewCell {
    static let identifier = "HistoryOrderView"
    
    private let exchangePairLabel = BaseLabel(text: "MAX / TWD", color: .black, font: .systemFont(ofSize: 15, weight: .medium), alignments: .left)
    private let exchangeTimeLabel = BaseLabel(text: "2021-04-21 22:10:15", color: .systemGray, font: .systemFont(ofSize: 15, weight: .medium), alignments: .left)
    private let averagePriceLabel = BaseLabel(text: "29.2", color: .systemGreen, font: .systemFont(ofSize: 20, weight: .medium), alignments: .right)
    private let priceLabel = BaseLabel(text: "29.2", color: .black, font: .systemFont(ofSize: 15, weight: .medium), alignments: .right)
    private let amountLabel = BaseLabel(text: "75.2", color: .systemGreen, font: .systemFont(ofSize: 20, weight: .medium), alignments: .right)
    private let dealLabel = BaseLabel(text: "75.2", color: .black, font: .systemFont(ofSize: 15, weight: .medium), alignments: .right)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        addSubViews(exchangePairLabel,
                    exchangeTimeLabel,
                    averagePriceLabel,
                    amountLabel,
                    priceLabel,
                    dealLabel)
        
        exchangePairLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY).multipliedBy(0.6)
            make.left.equalTo(snp.left).offset(15)
            make.width.equalTo(snp.width).multipliedBy(0.3)
            make.height.equalTo(20)
        }
        
        exchangeTimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY).multipliedBy(1.4)
            make.left.equalTo(snp.left).offset(15)
            make.width.equalTo(snp.width).multipliedBy(0.4)
            make.height.equalTo(20)
        }
        
        averagePriceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY).multipliedBy(0.6)
            make.right.equalTo(amountLabel.snp.left)
            make.width.equalTo(snp.width).multipliedBy(0.2)
            make.height.equalTo(20)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY).multipliedBy(1.4)
            make.right.equalTo(amountLabel.snp.left)
            make.width.equalTo(snp.width).multipliedBy(0.3)
            make.height.equalTo(20)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY).multipliedBy(0.6)
            make.right.equalTo(snp.right).offset(-15)
            make.width.equalTo(snp.width).multipliedBy(0.28)
            make.height.equalTo(20)
        }
        
        dealLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY).multipliedBy(1.4)
            make.right.equalTo(snp.right).offset(-15)
            make.width.equalTo(snp.width).multipliedBy(0.28)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
