//
//  SettingHeaderViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/26.
//

import UIKit

class SettingHeaderViewCell: UITableViewHeaderFooterView {
    static let identifier = "SettingHeaderViewCell"
    private lazy var titleLabel = BaseLabel(text: "", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), alignments: .left)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
    }
    
    private func setupUI() {
        addSubViews(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left).offset(20)
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
