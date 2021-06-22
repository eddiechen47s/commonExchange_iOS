//
//  BaseMainTradingViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/2.
//

import UIKit

class BaseMainTradingView: UITableViewCell {
    
    static let identifier = "BaseMainTradingView"
    
    private var tradingPairLabel = UILabel()
    private var lastesPriceLabel = BaseLabel(text: "28.72", color: .label, font: .systemFont(ofSize: 16, weight: .regular), alignments: .left)
    
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
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let tradingCountLabel = BaseLabel(text: "成交量", color: UIColor.init(red: 99/255, green: 121/255, blue: 130/255, alpha: 1), font: .systemFont(ofSize: 13), alignments: .left)
    private let volumeLabel = BaseLabel(text: "138,370219", color: UIColor.init(red: 99/255, green: 121/255, blue: 130/255, alpha: 1), font: .systemFont(ofSize: 12), alignments: .left)
    
    private let twdLabel = BaseLabel(text: "NT= 1.022", color: UIColor.init(red: 99/255, green: 121/255, blue: 130/255, alpha: 1), font: .systemFont(ofSize: 12), alignments: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupUI()
        
    }

    func configure(with vm: TradingPairs) {
        let baseStr = NSMutableAttributedString(string: vm.base.uppercased()+" ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1)])
        let targetStr = NSAttributedString(string: "/ "+vm.target.uppercased(), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1)])
        baseStr.append(targetStr)
        self.tradingPairLabel.attributedText = baseStr
        self.lastesPriceLabel.text = vm.last.toString()
        self.volumeLabel.text = vm.volume.toString()
        self.twdLabel.text = "TWD≈ "+vm.lastNt.toString(maxF: 2)
        if vm.bidAskSpreadPercentage > 0 {
            self.changePercentView.backgroundColor = upColor
            self.changePercentLabel.text = "+"+vm.bidAskSpreadPercentage.toString(maxF:2)+"%"
        } else if vm.bidAskSpreadPercentage < 0 {
            self.changePercentView.backgroundColor = #colorLiteral(red: 0.9601823688, green: 0.2764334977, blue: 0.3656736016, alpha: 1)
            self.changePercentLabel.text = vm.bidAskSpreadPercentage.toString(maxF:2)+"%"
        } else {
            self.changePercentView.backgroundColor = .systemGray
            self.changePercentLabel.text = "0 %"
        }
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
            make.left.equalTo(tradingPairLabel.snp.right).offset(15)
            make.width.equalTo(snp.width).multipliedBy(0.3)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }
        
        changePercentView.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(snp.right).offset(-20)
            make.width.equalTo(snp.width).multipliedBy(0.23)
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
            make.left.equalTo(tradingCountLabel.snp.right).offset(2)
            make.width.equalTo(snp.width).multipliedBy(0.3)
            make.height.equalTo(40)
        }
        
        twdLabel.snp.makeConstraints { make in
            make.top.equalTo(tradingPairLabel.snp.bottom).offset(-8)
            make.left.equalTo(lastesPriceLabel.snp.left)
            make.width.equalTo(snp.width).multipliedBy(0.4)
            make.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
