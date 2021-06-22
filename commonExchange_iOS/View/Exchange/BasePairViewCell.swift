//
//  BasePairViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/21.
//

import UIKit

class BasePairViewCell: UITableViewCell {
    
    static let identifier = "BasePairViewCell"
    
    private var tradingPairLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        let attStr = NSMutableAttributedString(string: "USDT / TWD")
        attStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(red: 77/255, green: 77/255, blue: 77/255, alpha: 1), range: NSMakeRange(0, 4))
        attStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(red: 99/255, green: 121/255, blue: 130/255, alpha: 1), range: NSMakeRange(5, 5))
        attStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 24, weight: .heavy), range: NSMakeRange(0, 4));
        label.attributedText = attStr
        return label
    }()
    
    private var lastesPriceLabel = BaseLabel(text: "", color: .label, font: .systemFont(ofSize: 15, weight: .regular), alignments: .center)
    
    private let changePercentView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2776432037, green: 0.6590948701, blue: 0.4378901124, alpha: 1)
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let changePercentLabel: UILabel = {
        let label = UILabel()
        label.text = "+0.60 %"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let tradingCountLabel = BaseLabel(text: "成交量", color: UIColor.init(red: 99/255, green: 121/255, blue: 130/255, alpha: 1), font: .systemFont(ofSize: 12), alignments: .left)
    private let volumeLabel = BaseLabel(text: "138,370219", color: UIColor.init(red: 99/255, green: 121/255, blue: 130/255, alpha: 1), font: .systemFont(ofSize: 12), alignments: .left)
    private let twdLabel = BaseLabel(text: "NT= 1.022", color: UIColor.init(red: 99/255, green: 121/255, blue: 130/255, alpha: 1), font: .systemFont(ofSize: 12), alignments: .center)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupUI()
    }
    
    func configure(with vm: ExchangeDetail) {
        let baseStr = NSMutableAttributedString(string: vm.symbol.split(separator: "_")[0].uppercased(), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1)])
        let targetStr = NSAttributedString(string: " / "+vm.symbol.split(separator: "_")[1].uppercased(), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1)])
        baseStr.append(targetStr)
        self.tradingPairLabel.attributedText = baseStr
        self.lastesPriceLabel.text = vm.price.toString(maxF: 8)
        self.volumeLabel.text = vm.count.toString(maxF: 6)
        self.twdLabel.text = "TWD≈ "+vm.twd.toString(maxF: 2)
        let add = ("\(vm.change)" as NSString).doubleValue
        if add < 0 {
            self.changePercentView.backgroundColor = #colorLiteral(red: 0.9601823688, green: 0.2764334977, blue: 0.3656736016, alpha: 1)
        } else if add > 0 {
            self.changePercentView.backgroundColor = upColor
        } else {
            self.changePercentView.backgroundColor = .systemGray
        }
        self.changePercentLabel.text = strConvertDoublePercent(str: "\(vm.change)") + "%"
    }
    
    
    func setupUI() {
        addSubViews(tradingPairLabel,
                    changePercentView,
                    lastesPriceLabel,
                    tradingCountLabel,
                    volumeLabel,
                    twdLabel)
        
        changePercentView.addSubViews(changePercentLabel)
        
        tradingPairLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(15)
            make.left.equalTo(snp.left).offset(20)
            make.width.equalTo(snp.width).multipliedBy(0.3)
            make.height.equalTo(30)
        }
        
        lastesPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(tradingPairLabel.snp.top)
            make.left.equalTo(tradingPairLabel.snp.right)
            make.right.equalTo(changePercentView.snp.left).offset(-40)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }
        
        changePercentView.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(snp.right).offset(-20)
            make.width.equalTo(snp.width).multipliedBy(0.25)
            make.height.equalTo(snp.height).multipliedBy(0.6)
        }
        
        changePercentLabel.snp.makeConstraints { make in
            make.center.equalTo(changePercentView.snp.center)
            make.width.height.equalToSuperview()
        }
        
        tradingCountLabel.snp.makeConstraints { make in
            make.top.equalTo(tradingPairLabel.snp.bottom).offset(5)
            make.left.equalTo(tradingPairLabel.snp.left)
            make.width.equalTo(40)
            make.height.equalTo(snp.height).multipliedBy(0.2)
        }
        
        volumeLabel.snp.makeConstraints { make in
            make.top.equalTo(tradingPairLabel.snp.bottom).offset(-7)
            make.left.equalTo(tradingCountLabel.snp.right).offset(1)
            make.width.equalTo(snp.width).multipliedBy(0.3)
            make.height.equalTo(40)
        }
        
        twdLabel.snp.makeConstraints { make in
            make.top.equalTo(tradingPairLabel.snp.bottom).offset(-8)
            make.width.equalTo(snp.width).multipliedBy(0.4)
            make.right.equalTo(changePercentView.snp.left)
            make.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension UITableViewCell {
    func roundOffZero(str: String) -> String {
        let value = (str as NSString).doubleValue
        if value == 0 {
            return "0"
        } else {
            let newValue = String(format: "%g", value)
            return newValue
        }
    }
}
