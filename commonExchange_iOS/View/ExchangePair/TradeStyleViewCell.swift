//
//  TradeStyleViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/11.
//

import UIKit

class TradeStyleViewCell: UICollectionViewCell {
    static let identifier = "TradeStyleViewCell"
    
    let styleLabel = BaseLabel(text: "買入", color: #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), alignments: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()

    }
    
    private func setupUI() {
        addSubViews(styleLabel)
        styleLabel.snp.makeConstraints { make in
            make.center.equalTo(snp.center)
            make.width.height.equalToSuperview()
        }
    }
    
    func configure(with model: TradeStyleType) {
        self.styleLabel.text = model.rawValue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
