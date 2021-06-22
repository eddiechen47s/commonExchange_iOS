//
//  WalletDetailViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/13.
//

import UIKit

class WalletDetailViewCell: UITableViewCell {
    static let identifier = "WalletDetailViewCell"
    private let bottomView = BaseView(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
    private let pairsView = BaseView(color: .white)
    private let priceView = BaseView(color: .white)
    private let persentView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9601823688, green: 0.2764334977, blue: 0.3656736016, alpha: 1)
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let coinPairsLabel = BaseLabel(text: "ETH", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 14, weight: .bold), alignments: .left)
    private let lastesPriceLabel = BaseLabel(text: "0.035812", color: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1), font: .systemFont(ofSize: 18, weight: .regular), alignments: .left)
    private let amountLabel =  BaseLabel(text: "成交量 123.38277622", color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), font: .systemFont(ofSize: 12, weight: .regular), alignments: .left)
    private let twdLabel =  BaseLabel(text: "TWD≈ 62,312.9", color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), font: .systemFont(ofSize: 12, weight: .regular), alignments: .left)
    private let persentLabel =  BaseLabel(text: "-1.29 %", color: #colorLiteral(red: 0.9960784314, green: 1, blue: 0.9960784314, alpha: 1), font: .systemFont(ofSize: 16, weight: .regular), alignments: .center)
    
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
    
    func configure(with vm: WalletDetailPairs) {
        let symbolPrefix = vm.symbol.uppercased().split(separator: "_")[0]
        let symbolSuffix = vm.symbol.uppercased().split(separator: "_")[1]
        print(vm.change)
        self.amountLabel.text = "成交量 "+vm.count.toString()
        let baseStr = NSMutableAttributedString(string: String(symbolPrefix)+" ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1)])
        let targetStr = NSAttributedString(string: "/ "+String(symbolSuffix), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1)])
        baseStr.append(targetStr)
        self.coinPairsLabel.attributedText = baseStr
        self.persentLabel.text = vm.change.toString(maxF: 2)+"%"
        if vm.change > 0 {
            self.persentView.backgroundColor = upColor
            self.persentLabel.text = "+"+vm.change.toString(maxF: 2)+"%"

        } else if vm.change < 0 {
            self.persentView.backgroundColor = #colorLiteral(red: 0.9601823688, green: 0.2764334977, blue: 0.3656736016, alpha: 1)
        } else {
            self.persentView.backgroundColor = .systemGray
        }
    }
    
    func setupUI() {
        addSubViews(pairsView,
                    priceView,
                    persentView,
                    bottomView
        )
        
        pairsView.addSubViews(coinPairsLabel, amountLabel)
        priceView.addSubViews(lastesPriceLabel, twdLabel)
        persentView.addSubview(persentLabel)
        
        pairsView.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left).offset(15)
            make.width.equalTo(snp.width).multipliedBy(0.33)
            make.height.equalTo(snp.height).multipliedBy(0.8)
        }
        
        priceView.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(pairsView.snp.right)
            make.width.equalTo(snp.width).multipliedBy(0.33)
            make.height.equalTo(snp.height).multipliedBy(0.8)
        }
        
        coinPairsLabel.snp.makeConstraints { make in
            make.top.equalTo(pairsView.snp.top)
            make.left.equalTo(pairsView.snp.left)
            make.width.equalTo(100)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }

        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(coinPairsLabel.snp.bottom)
            make.left.equalTo(coinPairsLabel.snp.left)
            make.right.equalTo(pairsView.snp.right)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }

        lastesPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(priceView.snp.top)
            make.left.equalTo(priceView.snp.left)
            make.width.equalTo(priceView.snp.width)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }
        
        twdLabel.snp.makeConstraints { make in
            make.top.equalTo(lastesPriceLabel.snp.bottom)
            make.left.equalTo(priceView.snp.left)
            make.width.equalTo(priceView.snp.width)
            make.height.equalTo(snp.height).multipliedBy(0.4)
        }

        persentView.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(priceView.snp.right)
            make.width.equalTo(snp.width).multipliedBy(0.25)
            make.height.equalTo(snp.height).multipliedBy(0.55)
        }
        
        persentLabel.snp.makeConstraints { make in
            make.center.equalTo(persentView.snp.center)
            make.width.height.equalTo(persentView)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

