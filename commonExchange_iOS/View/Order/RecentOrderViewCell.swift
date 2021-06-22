//
//  RecentOrderViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/4.
//

import UIKit

protocol RecentOrderCancel: AnyObject {
    func cancelOrder(in cell: RecentOrderViewCell)
}

class RecentOrderViewCell: UITableViewCell {
    
    static let identifier = "RecentOrderViewCell"
    
    weak var delegate: RecentOrderCancel?
    private let progreessBaseView = BaseView(color: .white)
    
    var progressCount: CGFloat = 0  // 控制百分比數字
    
    lazy var progreessView: ProgreessBarView = {
        let view = ProgreessBarView()
        view.backgroundColor = .white
        view.progress = progressCount
        return view
    }()
    
    private lazy var tradingPairLabel: UILabel = {
        let label = UILabel()
        let attStr = NSMutableAttributedString(string: "USDT / TWD")
        attStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(red: 77/255, green: 77/255, blue: 77/255, alpha: 1), range: NSMakeRange(0, 4))
        attStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(red: 99/255, green: 121/255, blue: 130/255, alpha: 1), range: NSMakeRange(5, 5))
        attStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 24, weight: .heavy), range: NSMakeRange(0, 4));
        label.attributedText = attStr
        return label
    }()
    
    private var orderPriceLabel = BaseLabel(text: "0.039688 BTC", color: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 14, weight: .bold), alignments: .left)
    private let amountLabel = BaseLabel(text: "10", color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), font: .systemFont(ofSize: 20, weight: .bold), alignments: .right)
    private let totalLabel = BaseLabel(text: "0.039688", color: #colorLiteral(red: 0.6063641906, green: 0.6064368486, blue: 0.6063307524, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), alignments: .right)
    
    private lazy var pairStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [tradingPairLabel, orderPriceLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var orderDetailStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [amountLabel, totalLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let cancelView = BaseView(color: .white)
    
    lazy var cancelOrderButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cancel"), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    func setupUI() {
        addSubViews(pairStackView, orderDetailStackView)
        
        pairStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.equalTo(snp.left).offset(15)
            make.width.equalTo(snp.width).multipliedBy(0.4)
        }
        
        orderDetailStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.right.equalTo(snp.right).offset(-15)
            make.width.equalTo(snp.width).multipliedBy(0.4)
        }

    }
    
    @objc func didTapCancel() {
        delegate?.cancelOrder(in: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
