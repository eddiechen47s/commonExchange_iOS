//
//  OderDetaiViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/12.
//

import UIKit

class OderDetaiViewCell: UICollectionViewCell {
    static let identifier = "OderDetaiViewCell"
    
    private let topView = BaseView(color: #colorLiteral(red: 0.9968166947, green: 1, blue: 0.9963441491, alpha: 1))
    private let toplineView = BaseView(color: #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1))
    
    private let topTimeLabel = BaseLabel(text: "時間", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 14, weight: .regular), alignments: .left)
    private let topPriceLabel = BaseLabel(text: "價格 / 手續費", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 14, weight: .regular), alignments: .right)
    private let topAmountLabel = BaseLabel(text: "數量 / 總額", color: #colorLiteral(red: 0.5031602383, green: 0.5032215714, blue: 0.5031319857, alpha: 1), font: .systemFont(ofSize: 14, weight: .regular), alignments: .right)
    
    private let dateLabel = BaseLabel(text: "22:35:17", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 14, weight: .regular), alignments: .left)
    private let timeLabel = BaseLabel(text: "2021-01-09", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 14, weight: .regular), alignments: .left)
    private let priceLabel = BaseLabel(text: "3.29", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 14, weight: .regular), alignments: .right)
    private let feeLabel = BaseLabel(text: "0.113985 MAX", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 14, weight: .regular), alignments: .right)
    private let amountLabel = BaseLabel(text: "0", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 14, weight: .regular), alignments: .right)
    private let totalLabel = BaseLabel(text: "0", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 14, weight: .regular), alignments: .right)
    
    private lazy var timeStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [dateLabel, timeLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    private lazy var priceStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [priceLabel, feeLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    private lazy var amoumtStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [amountLabel, totalLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = #colorLiteral(red: 0.9968166947, green: 1, blue: 0.9963441491, alpha: 1)
    }
    
    func configure(with vm: OderDetail) {
        print(vm)
        self.dateLabel.text = String(unixToDateString(time: String(vm.addtime)).split(separator: " ")[0])
        self.timeLabel.text = String(unixToDateString(time: String(vm.addtime)).split(separator: " ")[1])
        self.priceLabel.text = vm.price
        self.amountLabel.text = vm.num
        let price = (vm.price as NSString).doubleValue
        let amount = (vm.num as NSString).doubleValue
        self.totalLabel.text = (price*amount).toString(maxF: 9)
        print(vm.feeBuy)
        print(vm.feeSell)
        if vm.feeSell != "0" {
            self.feeLabel.text = (vm.feeSell as NSString).doubleValue.toString(maxF: 9)
        } else {
            self.feeLabel.text = (vm.feeBuy as NSString).doubleValue.toString(maxF: 9)
        }
    }
    
    private func setupUI() {
        addSubViews(topView,
                    timeStack,
                    priceStack,
                    amoumtStack
                    )
        
        topView.addSubViews(topTimeLabel, topPriceLabel, topAmountLabel, toplineView)
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(35)
        }
        
        topTimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(topView.snp.centerY)
            make.left.equalTo(topView.snp.left).offset(20)
            make.width.equalTo(30)
            make.height.equalTo(topView.snp.height)
        }
        
        topPriceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(topView.snp.centerY)
            make.right.equalTo(topAmountLabel.snp.left).offset(0)
            make.width.equalTo(topView.snp.width).multipliedBy(0.33)
            make.height.equalTo(topView.snp.height)
        }
        
        topAmountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(topView.snp.centerY)
            make.right.equalTo(topView.snp.right).offset(-20)
            make.width.equalTo(topView.snp.width).multipliedBy(0.3)
            make.height.equalTo(topView.snp.height)
        }
        
        toplineView.snp.makeConstraints { make in
            make.bottom.equalTo(topView.snp.bottom)
            make.left.right.equalTo(topView)
            make.height.equalTo(1)
        }
        
        timeStack.snp.makeConstraints { make in
            make.top.equalTo(toplineView.snp.bottom).offset(1)
            make.bottom.equalTo(snp.bottom)
            make.left.equalTo(topTimeLabel.snp.left)
            make.width.equalTo(100)
        }
        
        priceStack.snp.makeConstraints { make in
            make.top.equalTo(toplineView.snp.bottom).offset(1)
            make.bottom.equalTo(snp.bottom)
            make.right.equalTo(topPriceLabel.snp.right)
            make.width.equalTo(topView.snp.width).multipliedBy(0.33)
        }
        
        amoumtStack.snp.makeConstraints { make in
            make.top.equalTo(toplineView.snp.bottom).offset(1)
            make.bottom.equalTo(snp.bottom)
            make.right.equalTo(topAmountLabel.snp.right)
            make.width.equalTo(topView.snp.width).multipliedBy(0.3)
        }
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension UIColor {
    func setColor(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
