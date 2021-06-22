//
//  RecordViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/13.
//

import UIKit

class RecordViewCell: UITableViewCell {
    static let identifier = "RecordViewCell"
    
    private let iconImageView: UIImageView = {
        let img = UIImageView()
        img.tintColor = #colorLiteral(red: 0.3610518873, green: 0.4157832265, blue: 0.4461032152, alpha: 1)
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let accessoryImageView = BaseImageView(image: "Accessory", color: nil)
    
    private let titleLabel = BaseLabel(text: "訂單編號", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3254901961, alpha: 1), font: .systemFont(ofSize: 18, weight: .regular), alignments: .left)
    private let bottomViwe = BaseView(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func configure(with vm: RecordOption) {
        self.iconImageView.image = UIImage(named: vm.recordImage)
        self.titleLabel.text = vm.title
    }
    
    private func setupUI() {
        addSubViews(iconImageView, titleLabel, bottomViwe, accessoryImageView)
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left).offset(15)
            make.width.height.equalTo(25)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(iconImageView.snp.right).offset(20)
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height)
        }
        
        accessoryImageView.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(snp.right).offset(-20)
            make.width.equalTo(21.4)
            make.height.equalTo(16)
        }
        
        bottomViwe.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
