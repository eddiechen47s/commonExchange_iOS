//
//  UserIdentifyViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/14.
//

import UIKit

class UserIdentifyViewCell: BaseTableViewCell {
    static let identifier = "UserIdentifyViewCell"
    
    let titleLabel = BaseLabel(text: "B Class", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 15, weight: .bold), alignments: .left)
    let statusLabel = BaseLabel(text: "已通過", color: #colorLiteral(red: 0.2333128452, green: 0.7429219484, blue: 0.5215145946, alpha: 1), font: .systemFont(ofSize: 15, weight: .bold), alignments: .right)
    let accessoryImageView = BaseImageView(image: "Accessory", color: nil)
    
//    func configure(with vm: UserIdentify) {
//        self.titleLabel.text = vm.title
//        self.statusLabel.text = vm.status
//        self.accessoryImageView.image = UIImage(named: vm.accessory)
//    }
    
    override func setupUI() {
        addSubViews(titleLabel,
                    accessoryImageView,
                    statusLabel
        )
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left).offset(20)
            make.width.equalTo(snp.width).multipliedBy(0.5)
            make.height.equalTo(snp.height)
        }
        
        accessoryImageView.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(snp.right).offset(-20)
            make.width.height.equalTo(20)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(accessoryImageView.snp.left).offset(-10)
            make.width.equalTo(snp.width).multipliedBy(0.2)
            make.height.equalTo(snp.height)
        }
    }
    
}

