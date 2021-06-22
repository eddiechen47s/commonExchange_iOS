//
//  DepositViewCell.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/4/23.
//

import UIKit

class DepositViewCell: UICollectionViewCell {
    static let identifier = "DepositViewCell"
    
    private let chainButton: UIButton = {
       let button = UIButton()
        button.setTitle("BTC", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2030145526, green: 0.2030202448, blue: 0.203017205, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8892684579, green: 0.8961650729, blue: 0.9087286592, alpha: 1)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.isUserInteractionEnabled = false //關閉交互，不然button不能點
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    func configure(with vm: ChainDetail) {
        self.chainButton.setTitle(vm.chain, for: .normal)
    }
    
    private func setupUI() {
        addSubViews(chainButton)
        
        chainButton.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left)
            make.width.height.equalToSuperview()
        }
    }
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected{
                chainButton.setTitleColor(#colorLiteral(red: 1, green: 0.7450980392, blue: 0, alpha: 1), for: .normal)
                chainButton.backgroundColor = #colorLiteral(red: 0.9972590804, green: 0.9760511518, blue: 0.8955391049, alpha: 1)
                chainButton.layer.borderWidth = 1
                chainButton.layer.borderColor = #colorLiteral(red: 1, green: 0.7450980392, blue: 0, alpha: 1)
                chainButton.clipsToBounds = true
            }else{
                chainButton.setTitleColor(#colorLiteral(red: 0.2079606652, green: 0.2079664469, blue: 0.2079633176, alpha: 1), for: .normal)
                chainButton.backgroundColor = #colorLiteral(red: 0.9181004763, green: 0.92492944, blue: 0.9373696446, alpha: 1)
                chainButton.layer.borderWidth = 0
                chainButton.clipsToBounds = false
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
