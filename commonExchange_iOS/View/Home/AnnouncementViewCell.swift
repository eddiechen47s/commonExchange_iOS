//
//  AnnouncementViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/19.
//

import UIKit

class AnnouncementViewCell: UITableViewCell {
    static let identifier = "AnnouncementViewCell"
    
    let titleLabel = BaseLabel(text: "title", color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), font: .systemFont(ofSize: 12, weight: .bold), alignments: .left)
    let timeLabel = BaseLabel(text: "time", color: #colorLiteral(red: 0.7058823529, green: 0.7058823529, blue: 0.7058823529, alpha: 1), font: .systemFont(ofSize: 10, weight: .bold), alignments: .right)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .blue
        setupUI()
    }
    
    func configure(with vm: ListModel) {
        self.titleLabel.text = vm.title
        self.timeLabel.text = timeToTimeStamp(time: String(vm.addtime))
        self.titleLabel.numberOfLines = 2
    }
    
    func setupUI() {
        addSubViews(titleLabel,
                    timeLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left).offset(20)
            make.right.equalTo(timeLabel.snp.left)
            make.height.equalTo(snp.height)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(snp.right).offset(-10)
            make.width.equalTo(snp.width).multipliedBy(0.2)
            make.height.equalTo(snp.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
