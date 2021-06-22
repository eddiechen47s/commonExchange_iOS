//
//  MainTradingPairViewCell.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/2/28.
//

import UIKit

class MainTradingPairViewCell: UICollectionViewCell {
    
    static let identifier = "MainTradingPairViewCell"
    
    let pairTitleLabel: UILabel = {
        let lable = UILabel()
        lable.text = "BTC / USTD"
        lable.textAlignment = .center
        lable.textColor = .systemGray
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        return lable
    }()
    
    private let pairValueLabel: UILabel = {
        let lable = UILabel()
        lable.text = "0.196"
        lable.textAlignment = .center
        lable.textColor = #colorLiteral(red: 0.1764238477, green: 0.2723790109, blue: 0.5711853504, alpha: 1)
        lable.font = .systemFont(ofSize: 24, weight: .thin)
        return lable
    }()
    
    private let pairPercentLabel: UILabel = {
        let lable = UILabel()
        lable.text = "-0.778 %"
        lable.textAlignment = .center
        lable.textColor = #colorLiteral(red: 0.9273493886, green: 0.3536090851, blue: 0.3558602929, alpha: 1)
        lable.font = UIFont.boldSystemFont(ofSize: 18)
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupUI()
    }
    
    func configure(with vm: MainTradingPairCoin) {
        self.pairTitleLabel.text = vm.base.uppercased()+" / "+vm.target.uppercased()
        self.pairValueLabel.text = vm.usd.toString()
        self.pairPercentLabel.text = vm.usd_24h_change.toString(maxF: 2)+" %"
        if vm.usd_24h_change > 0 {
            self.pairPercentLabel.text = "+"+vm.usd_24h_change.toString(maxF: 2)+" %"
        } else if vm.usd_24h_change < 0 {
            self.pairPercentLabel.text = vm.usd_24h_change.toString(maxF: 2)+" %"
        } else {
            self.pairPercentLabel.text = "0 %"
        }
    }
    
    func setupUI() {
        addSubViews(pairTitleLabel,
                    pairValueLabel,
                    pairPercentLabel)
        
        pairTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(5)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height).multipliedBy(0.15)
        }
        
        pairValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height).multipliedBy(0.65)
        }
        
        pairPercentLabel.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height).multipliedBy(0.2)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
