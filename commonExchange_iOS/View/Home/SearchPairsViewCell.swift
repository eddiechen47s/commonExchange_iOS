//
//  SearchPairsViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/9.
//

import UIKit

class SearchPairsViewCell: UITableViewCell {
    static let identifier = "SearchPairsViewCell"
    
    private let titleLabel = BaseLabel(text: "", color: .white, font: .systemFont(ofSize: 18, weight: .medium), alignments: .left)
    private let bottomView = BaseView(color: .white)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 0.1772809327, green: 0.2758469284, blue: 0.5724449158, alpha: 1)
        setupUI()
    }
    
    private func setupUI() {
        addSubViews(titleLabel,
                    bottomView)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left).offset(20)
            make.width.height.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
    }
    
    func configure(with vm: SearchListData) {
        self.titleLabel.text = vm.symbol.replacingOccurrences(of: "_", with: " / ").uppercased()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
