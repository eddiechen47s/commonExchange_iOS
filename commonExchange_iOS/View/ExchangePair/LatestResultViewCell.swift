//
//  LatestResultViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/10.
//

import UIKit

class LatestResultViewCell: UITableViewCell {
    static let identifier = "LatestResultViewCell"
    
    private let timeLabel = BaseLabel(text: "17:31:27", color: #colorLiteral(red: 0.3276588321, green: 0.3830980361, blue: 0.4224037528, alpha: 1), font: .systemFont(ofSize: 14, weight: .medium), alignments: .left)
    private let priceLabel = BaseLabel(text: "51.850", color: #colorLiteral(red: 0.1810023785, green: 0.603258431, blue: 0.3675486445, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .center)
    private let amountLabel = BaseLabel(text: "1.561571", color: #colorLiteral(red: 0.3276588321, green: 0.3830980361, blue: 0.4224037528, alpha: 1), font: .systemFont(ofSize: 14, weight: .medium), alignments: .right)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func configure(with vm: LatestDeal) {
        self.timeLabel.text = secondStamp(time: "\(vm.addtime)")
        self.priceLabel.text = (vm.price as NSString).doubleValue.toString(maxF: 8)
        self.amountLabel.text = (vm.num as NSString).doubleValue.toString(maxF: 8)
        if vm.type == 1 {
            self.priceLabel.textColor = #colorLiteral(red: 0.1810023785, green: 0.603258431, blue: 0.3675486445, alpha: 1)
        } else {
            self.priceLabel.textColor = #colorLiteral(red: 0.9601823688, green: 0.2764334977, blue: 0.3656736016, alpha: 1)
        }
    }
    
    private func setupUI() {
        addSubViews(timeLabel,
                    priceLabel,
                    amountLabel)
        
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left).offset(20)
            make.width.equalTo(snp.width).multipliedBy(0.3)
            make.height.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.center.equalTo(snp.center)
            make.width.equalTo(snp.width).multipliedBy(0.3)
            make.height.equalToSuperview()
        }
        
        amountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(snp.right).offset(-20)
            make.width.equalTo(snp.width).multipliedBy(0.3)
            make.height.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
