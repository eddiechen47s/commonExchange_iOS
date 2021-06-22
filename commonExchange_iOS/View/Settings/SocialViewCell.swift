//
//  SocialViewCell.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/4/11.
//

import UIKit

class SocialViewCell: UITableViewCell {
    static let identifier = "SocialViewCell"
    
    private let logoImageView = BaseImageView(image: "Facebook_icon", color: nil)
    private let titleLabel = BaseLabel(text: "Facebook", color: .black, font: .systemFont(ofSize: 18, weight: .medium), alignments: .left)
    private let bottomView = BaseView(color: UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func configure(with vm: Social) {
        self.logoImageView.image = UIImage(named: vm.logoImage)
        self.titleLabel.text = vm.title
    }
    
    private func setupUI() {
        addSubViews(logoImageView,
                    titleLabel,
                    bottomView)
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left).offset(10)
            make.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(logoImageView.snp.right).offset(15)
            make.right.equalTo(snp.right)
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
