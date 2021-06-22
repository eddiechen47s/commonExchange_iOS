//
//  KLineTimeCollectionViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/10.
//

import UIKit

class KLineTimeViewCell: UICollectionViewCell {
    static let identifier = "KLineTimeViewCell"
    
    private let timeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let timeLabel = BaseLabel(text: "1m",
                                      color: #colorLiteral(red: 0.1803921569, green: 0.2758463919, blue: 0.5724321008, alpha: 1),
                                      font: .systemFont(ofSize: 14, weight: .bold),
                                      alignments: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupUI()
    }
    
    func configure(with model: KLineTimeType) {
        self.timeLabel.text = model.rawValue
    }
    
    private func setupUI() {
        addSubview(timeView)
        timeView.addSubview(timeLabel)
        
        timeView.snp.makeConstraints { make in
            make.center.equalTo(snp.center)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(snp.height)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.center.equalTo(timeView.snp.center)
            make.width.height.equalToSuperview()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                timeLabel.textColor = .white
                timeView.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.2758463919, blue: 0.5724321008, alpha: 1)
            } else {
                timeLabel.textColor = #colorLiteral(red: 0.1803921569, green: 0.2758463919, blue: 0.5724321008, alpha: 1)
                timeView.backgroundColor = .white
            }

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
