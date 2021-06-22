//
//  AllDepositViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/20.
//

import UIKit

class AllDepositViewCell: BaseTableViewCell {
    static let identifier = "AllDepositViewCell"
    
    private let coinNameLabel = BaseLabel(text: "ETH", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 22, weight: .bold), alignments: .left)
    private let timeLabel = BaseLabel(text: "2021-04-21 22:10:15", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 13, weight: .regular), alignments: .left)
    private let amountLabel = BaseLabel(text: "20", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 22, weight: .regular), alignments: .right)
    private let statusLabel = BaseLabel(text: "存入成功", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 12, weight: .regular), alignments: .right)
    private let bottomView = BaseView(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
    
    func configure(with vm: DepositRecordList) {
        self.coinNameLabel.text = vm.coinname.uppercased()
        self.timeLabel.text = timeToMinStamp(time: String(vm.addtime))
        self.amountLabel.text = vm.num
    }

    override func setupUI() {
        addSubViews(coinNameLabel,
                    bottomView,
                    amountLabel,
                    timeLabel,
                    statusLabel
                    )
        
        coinNameLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(10)
            make.left.equalTo(snp.left).offset(15)
            make.width.equalTo(80)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }

        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(coinNameLabel.snp.top)
            make.right.equalTo(snp.right).offset(-16)
            make.left.equalTo(coinNameLabel.snp.right)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }

        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom)
            make.right.equalTo(snp.right).offset(-16)
            make.width.equalTo(snp.width).multipliedBy(0.3)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(coinNameLabel.snp.bottom)
            make.left.equalTo(snp.left).offset(15)
            make.width.equalTo(snp.width).multipliedBy(0.4)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
