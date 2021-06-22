//
//  RecordOrderDetailViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/12.
//

import UIKit

class RecordOrderDetailViewCell: UITableViewCell {
    static let identifier = "RecordOrderDetailViewCell"
    
    let titleLabel = BaseLabel(text: "title", color: #colorLiteral(red: 0.1328194737, green: 0.2377011478, blue: 0.3250451386, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .left)
    let detailLabel = BaseLabel(text: "detail", color: #colorLiteral(red: 0.1328194737, green: 0.2377011478, blue: 0.3250451386, alpha: 1), font: .systemFont(ofSize: 13, weight: .regular), alignments: .right)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
//    func configure(with vm: RecordOrderDetail) {
//        self.titleLabel.text = vm.title
//        self.detailLabel.text = vm.detail
//        self.detaiValuelLabel.text = vm.detailValue
//    }
    
    private func setupUI() {
        addSubViews(titleLabel,
                    detailLabel
                    
                    )
        
        detailLabel.sizeToFit()
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left)
            make.width.equalTo(snp.width).multipliedBy(0.3)
            make.height.equalTo(snp.height)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(snp.right)
            make.width.equalTo(snp.width).multipliedBy(0.5)
            make.height.equalTo(snp.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
