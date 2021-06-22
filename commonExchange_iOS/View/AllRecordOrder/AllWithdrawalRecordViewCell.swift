//
//  AllWithdrawalRecordViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/20.
//

import UIKit

class AllWithdrawalRecordViewCell: BaseTableViewCell {
    static let identifier = "AllWithdrawalRecordViewCell"
    private let bottomView = BaseView(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
    
    private let coinNameLabel = BaseLabel(text: "ETH", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), alignments: .left)
    private let timeLabel = BaseLabel(text: "2021-04-21 22:10:15", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 13, weight: .regular), alignments: .left)
    
    let addressLabel = BaseLabel(text: "1NjiRs3uoVssz…0.001", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .right)
    private let feeLabel = BaseLabel(text: "0.039688", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 12, weight: .regular), alignments: .right)
    private let amountLabel = BaseLabel(text: "20", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 22, weight: .regular), alignments: .right)
    private let statusLabel = BaseLabel(text: "提領成功", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 12, weight: .regular), alignments: .right)
    
    func configure(with vm: WithdrawalRecordList) {
        self.coinNameLabel.text = vm.coinname.uppercased()
        self.timeLabel.text = timeToMinStamp(time: String(vm.addtime))
        self.addressLabel.text = vm.address
        self.amountLabel.text = vm.num
        self.feeLabel.text = vm.fee
        if vm.status == 1 {
            self.statusLabel.text = "處理中"
        } else {
            self.statusLabel.text = "提領成功"
        }
    }
    
    override func setupUI() {
        addSubViews(coinNameLabel,
                    bottomView,
                    addressLabel,
                    amountLabel,
                    timeLabel,
                    feeLabel,
                    statusLabel
                    )
        
        coinNameLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(10)
            make.left.equalTo(snp.left).offset(15)
            make.width.equalTo(50)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }

        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(coinNameLabel.snp.top)
            make.right.equalTo(snp.right).offset(-16)
            make.width.equalTo(snp.width).multipliedBy(0.28)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }
        addressLabel.snp.makeConstraints { make in
            make.right.equalTo(amountLabel.snp.left)
            make.top.equalTo(snp.top).offset(10)
            make.width.equalTo(snp.width).multipliedBy(0.28)
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

        feeLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.top)
            make.right.equalTo(addressLabel.snp.right)
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
