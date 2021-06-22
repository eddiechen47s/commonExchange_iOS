//
//  LatestResultHeaderView.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/10.
//

import UIKit

class LatestResultHeaderView: UITableViewHeaderFooterView {
    static let identifier = "LatestResultHeaderView"
    
    var cycptoType: String = "ETH"

    private let lastestDetailView = BaseView(color: .white)
    private let timeLabel = BaseLabel(text: "成交時間", color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), font: .systemFont(ofSize: 13, weight: .heavy), alignments: .left)
    private let priceLabel = BaseLabel(text: "成交價 (TWD)", color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), font: .systemFont(ofSize: 13, weight: .heavy), alignments: .center)
    private lazy var amountLabel = BaseLabel(text: "成交量 ( "+cycptoType+" )", color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), font: .systemFont(ofSize: 13, weight: .heavy), alignments: .right)
    private let bottomView = BaseView(color: #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1))
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(lastestDetailView)
        
        lastestDetailView.addSubViews(timeLabel,
                                      priceLabel,
                                      amountLabel,
                                      bottomView)
        
        lastestDetailView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(lastestDetailView.snp.centerY)
            make.left.equalTo(lastestDetailView.snp.left).offset(20)
            make.width.equalTo(lastestDetailView.snp.width).multipliedBy(0.3)
            make.height.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.center.equalTo(lastestDetailView.snp.center)
            make.width.equalTo(lastestDetailView.snp.width).multipliedBy(0.3)
            make.height.equalToSuperview()
        }
        
        amountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(lastestDetailView.snp.centerY)
            make.right.equalTo(lastestDetailView.snp.right).offset(-10)
            make.width.equalTo(lastestDetailView.snp.width).multipliedBy(0.3)
            make.height.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(lastestDetailView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(0.3)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
