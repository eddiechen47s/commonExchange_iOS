//
//  HistoryOrderHeaderView.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/8.
//

import UIKit

class HistoryOrderHeaderView: UITableViewHeaderFooterView {
    static let identifier = "HistoryOrderHeaderView"
    
    private let dateLabel = BaseLabel(text: "2020/4/8", color: .black, font: .systemFont(ofSize: 14, weight: .light), alignments: .left)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left).offset(20)
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height)
        }
    }
    
    func configure(with vm: String) {
        self.dateLabel.text = vm
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
