//
//  WalletViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/17.
//

import UIKit

class WalletAssetsViewCell: UITableViewCell {
    static let identifier = "WalletAssetsViewCell"
    private let bottomView = BaseView(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))

    private let coinNameLabel = BaseLabel(text: "", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 14, weight: .regular), alignments: .left)
    private let amountLabel =  BaseLabel(text: "", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 14, weight: .regular), alignments: .right)
    private lazy var twdLabel =  BaseLabel(text: "", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 13, weight: .regular), alignments: .right)
    let coinImageView = BaseImageView(image: "", color: .none)
    private let accessoryImg = BaseImageView(image: "Accessory", color: nil)
    
    private lazy var priceStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [amountLabel, twdLabel])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    func configure(with vm: WalletAssets) {
        self.coinNameLabel.text = vm.coinname.uppercased()
        self.amountLabel.text = (vm.amount as NSString).doubleValue.toString(maxF: 8)
        self.twdLabel.text = "TWD≈ "+(vm.twd as NSString).doubleValue.toString(maxF:2)

        let url = URL(string: apiUrlPrefix+"files/ico/\(vm.coinname).png")
        self.coinImageView.kf.setImage(with: url)
    }
    
    func countNumber(str: String) -> String {
        let value = (str as NSString).doubleValue
        if value > 0 {
            return value.cleanZero
        } else if value == 0 {
            return "0"
        }
        return ""
    }
    
    func setupUI() {
        addSubViews(coinImageView,
                    coinNameLabel,
                    priceStack,
                    bottomView,
                    accessoryImg
        )
        
        coinImageView.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left).offset(20)
            make.width.height.equalTo(30)
        }
        
        coinNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(coinImageView.snp.right).offset(20)
            make.width.equalTo(snp.width).multipliedBy(0.2)
            make.height.equalTo(snp.height)
        }
        
        priceStack.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(snp.right).offset(-50)
            make.width.equalTo(snp.width).multipliedBy(0.5)
            make.height.equalTo(snp.height).multipliedBy(0.6)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        accessoryImg.snp.makeConstraints {
            $0.centerY.equalTo(snp.centerY)
            $0.right.equalTo(snp.right)
            $0.left.equalTo(priceStack.snp.right)
            $0.height.equalTo(snp.height).multipliedBy(0.33)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
extension Double {

    /// 小數點後如果只是0，顯示整數，如果不是，顯示原來的值

    var cleanZero : String {

        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)

    }

}
