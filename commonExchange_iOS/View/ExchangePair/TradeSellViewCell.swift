//
//  TradeSellViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/11.
//

import UIKit

class TransactionViewCell: UITableViewCell {
    static let identifier = "TransactionViewCell"
    
    private let amountLabel = BaseLabel(text: "", color: .black, font: .systemFont(ofSize: 11, weight: .regular), alignments: .left)
    let priceLabel = BaseLabel(text: "", color: .systemRed, font: .systemFont(ofSize: 11, weight: .regular), alignments: .right)
    
    var adjustView = BaseView(color: #colorLiteral(red: 0.9709672332, green: 0.8029562235, blue: 0.8039739132, alpha: 1))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    func configure(with vm: TradeSell) {
        self.amountLabel.text = (vm.amount as NSString).doubleValue.toString(maxF: 8)
        self.priceLabel.text = (vm.price as NSString).doubleValue.toString(maxF: 8)
    }
    
    func configureAdjustView(with width: Double) {
        adjustView.snp.remakeConstraints { make in
            make.top.left.height.equalToSuperview()
            make.width.equalTo(snp.width).multipliedBy(width)
        }
    }
    
    private func setupUI() {
        addSubViews(adjustView)
        addSubViews(amountLabel, priceLabel)
        
        adjustView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        amountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left)
            make.width.equalTo(snp.width).multipliedBy(0.65)
            make.height.equalTo(snp.height)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(snp.right)
            make.width.equalTo(snp.width).multipliedBy(0.4)
            make.height.equalTo(snp.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
