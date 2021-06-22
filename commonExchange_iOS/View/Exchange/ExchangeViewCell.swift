//
//  ExchangeViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/2.
//

import UIKit

class ExchangeViewCell: UICollectionViewCell {
    
    static let identifier = "ExchangeViewCell"
    
    private let titleLabel = BaseLabel(text: "", color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), alignments: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func configure(vm: String) {
        self.titleLabel.text = vm
    }
    
    func setupUI() {
        addSubViews(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(snp.center)
            make.width.height.equalToSuperview()
        }
        

    }
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected{
                titleLabel.textColor = #colorLiteral(red: 0.1772809327, green: 0.2758469284, blue: 0.5724449158, alpha: 1)
            }else{
                titleLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
