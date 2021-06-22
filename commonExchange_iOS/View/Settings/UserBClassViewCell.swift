//
//  UserBClassViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/14.
//

import UIKit

class UserBClassViewCell: BaseTableViewCell {
    static let identifier = "UserBClassViewCell"
    
    let titleLabel = BaseLabel(text: "註冊E-Mail", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .left)
    let detailLabel = BaseLabel(text: "jingluntech@gmail.com", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .right)
    private let bottomView = BaseView(color: #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1))
    
    override func setupUI() {
        addSubViews(titleLabel,
                    detailLabel,
                    bottomView
                    )
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left).offset(15)
            make.width.equalTo(snp.width).multipliedBy(0.3)
            make.height.equalTo(snp.height)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(snp.right).offset(-15)
            make.width.equalTo(snp.width).multipliedBy(0.6)
            make.height.equalTo(snp.height)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
