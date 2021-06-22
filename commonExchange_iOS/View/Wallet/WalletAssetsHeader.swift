//
//  WalletAssetsHeader.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/3/6.
//

import UIKit

class WalletAssetsHeader: UIView {
    
    private let coinTypeLabel = BaseLabel(text: "貨幣", color: .systemGray, font: .systemFont(ofSize: 12, weight: .regular), alignments: .left)
    private let totalAssetsLabel = BaseLabel(text: "總資產", color: .systemGray, font: .systemFont(ofSize: 12, weight: .regular), alignments: .right)
    private let bottomView = BaseView(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.backgroundColor = .white
    }
    
    func setupUI() {
        addSubViews(coinTypeLabel,
                    totalAssetsLabel,
                    bottomView)
        
        coinTypeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left).offset(20)
            make.width.equalTo(snp.width).multipliedBy(0.3)
            make.height.equalTo(snp.height)
        }
        
        totalAssetsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(snp.right).offset(-50)
            make.width.equalTo(snp.width).multipliedBy(0.3)
            make.height.equalTo(snp.height)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
