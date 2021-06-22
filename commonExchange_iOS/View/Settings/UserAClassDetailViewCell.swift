//
//  UserAClassDetailViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/20.
//

import UIKit

struct UserAClassDetail {
    let title: String
    let detail: String
}

class UserAClassDetailViewCell: UICollectionViewCell {
    static let identifier = "UserAClassDetailViewCell"
    
    private let titleLabel = BaseLabel(text: "title", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .left)
    let detailLabel = BaseLabel(text: "detail", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), alignments: .right)
    private let bottomView = BaseView(color: #colorLiteral(red: 0.9762050509, green: 0.976318419, blue: 0.9761529565, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    func configure(with vm: UserAClassDetail) {
        self.titleLabel.text = vm.title
        self.detailLabel.text = vm.detail
    }
    
    private func setupUI() {
        addSubViews(titleLabel, detailLabel, bottomView)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left).offset(15)
            make.width.equalTo(snp.width).multipliedBy(0.3)
            make.height.equalTo(snp.height)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(snp.right).offset(-15)
            make.width.equalTo(snp.width).multipliedBy(0.7)
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
