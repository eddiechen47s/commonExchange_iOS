//
//  SettingTableViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/8.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    static let identifier = "SettingTableViewCell"
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let img = UIImageView()
        img.tintColor = #colorLiteral(red: 0.3610518873, green: 0.4157832265, blue: 0.4461032152, alpha: 1)
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let titlelabel: UILabel = BaseLabel(text: "", color: #colorLiteral(red: 0.1322087646, green: 0.234444797, blue: 0.3238072693, alpha: 1), font: .systemFont(ofSize: 18, weight: .regular), alignments: .left)
    
    let detailLabel = BaseLabel(text: "", color: #colorLiteral(red: 0.1266332269, green: 0.2296750546, blue: 0.3194316328, alpha: 1), font: .systemFont(ofSize: 16, weight: .medium), alignments: .right)
    private let bottomView = BaseView(color: UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1))
    let accessoryImg = BaseImageView(image: "Accessory", color: nil)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    func configure(with model: SettingOption) {
        self.titlelabel.text = model.title
        self.iconImageView.image = model.icon
        self.iconContainer.backgroundColor = .clear
    }
    
    func configureLanguage() {
        self.detailLabel.text = Languages.zh_tw.rawValue
        self.accessoryImg.isHidden = true
    }
    
    func configureRate() {
        self.detailLabel.text = Rates.usd.rawValue
        self.accessoryImg.isHidden = true
    }
    
    func configureRecommend(text: String) {
        self.detailLabel.text = text
        self.accessoryImg.isHidden = true
    }
    
    func hiddenaccessoryImg() {
        self.accessoryImg.isHidden = true
    }
    
    var copyy: String = ""
    func configureCopy() {
        copyy = RecommendCode.code.rawValue
    }
    
    func setupUI() {
        contentView.addSubViews(titlelabel,
                                iconContainer,
                                detailLabel,
                                bottomView,
                                accessoryImg
                                )
        iconContainer.addSubview(iconImageView)
        contentView.clipsToBounds = true
        
        
        iconContainer.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left)
            make.width.equalTo(70)
            make.height.equalTo(snp.height)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.center.equalTo(iconContainer.snp.center)
            make.width.height.equalTo(25)
        }
        
        titlelabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(iconImageView.snp.right).offset(18)
            make.width.equalTo(snp.width).multipliedBy(0.5)
            make.height.equalTo(snp.height)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(snp.right).offset(-20)
            make.width.equalTo(snp.width).multipliedBy(0.3)
            make.height.equalTo(snp.height)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        accessoryImg.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(snp.right).offset(-15)
            make.width.equalTo(20)
            make.height.equalTo(15)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        iconContainer.backgroundColor = nil
        titlelabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
