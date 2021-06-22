//
//  SettingHeaderViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/8.
//

import UIKit

class SettingProfileViewCell: UITableViewCell {
    static let identifier = "SettingProfileViewCell"
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    let iconImageView: UIImageView = {
        let img = UIImageView()
        img.tintColor = #colorLiteral(red: 0.3610518873, green: 0.4157832265, blue: 0.4461032152, alpha: 1)
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let titlelabel: UILabel = BaseLabel(text: "", color: #colorLiteral(red: 0.1333333333, green: 0.2352941176, blue: 0.3254901961, alpha: 1), font: .systemFont(ofSize: 19, weight: .bold), alignments: .left)
    
    let levellabel: UILabel = BaseLabel(text: "A Class", color: #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1), font: .systemFont(ofSize: 15, weight: .bold), alignments: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func configure(with model: SettingOption) {
        self.titlelabel.text = model.title
        self.iconImageView.image = model.icon
        self.iconContainer.backgroundColor = .clear
    }
    
    func setupUI() {
        contentView.addSubViews(titlelabel,
                                levellabel,
                                iconContainer
                                )
        iconContainer.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
        
        iconContainer.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY).offset(5)
            make.left.equalTo(snp.left)
            make.width.equalTo(70)
            make.height.equalTo(snp.height)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.center.equalTo(iconContainer.snp.center)
            make.width.height.equalTo(50)
        }
        
        titlelabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY).offset(-10)
            make.left.equalTo(iconImageView.snp.right).offset(20)
            make.right.equalTo(snp.right)
            make.height.equalTo(30)
        }
        
        levellabel.snp.makeConstraints { make in
            make.top.equalTo(titlelabel.snp.bottom)
            make.left.equalTo(iconImageView.snp.right).offset(20)
            make.width.equalTo(snp.width).multipliedBy(0.5)
            make.height.equalTo(30)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
