//
//  PricePercentViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/12.
//

import UIKit

class PricePercentViewCell: UICollectionViewCell {
    static let identifier = "PricePercentViewCell"
    
    let percentLabel = BaseLabel(text: "25%", color: .systemGreen, font: .systemFont(ofSize: 15, weight: .bold), alignments: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func configure(with model: PricePercentType) {
        self.percentLabel.text = model.rawValue
    }
    
    private func setupUI() {
        addSubview(percentLabel)
        percentLabel.snp.makeConstraints { make in
            make.center.equalTo(snp.center)
            make.width.height.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
