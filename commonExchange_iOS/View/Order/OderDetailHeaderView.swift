//
//  OderDetailHeaderView.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/12.
//

import UIKit

class OderDetailHeaderView: UICollectionReusableView {
    static let identifier = "OderDetailHeaderView"
    
    private let titleLabel = BaseLabel(text: "成交明細", color: .systemGray, font: .systemFont(ofSize: 14, weight: .regular), alignments: .left)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom).offset(-5)
            make.left.equalTo(snp.left).offset(20)
            make.right.equalTo(snp.right)
            make.height.equalTo(snp.height).multipliedBy(0.6)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    

}
