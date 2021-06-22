//
//  UserIdentifyViewCell.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/14.
//

import UIKit

class UserIdentifyFooterViewCell: UITableViewHeaderFooterView {
    static let identifier = "UserIdentifyFooterViewCell"

    private let textViewContainerView = BaseView(color: .white)
    private let detailTextView: UITextView = {
       let tv = UITextView()
        tv.backgroundColor = .clear
        tv.textColor = #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)
        tv.isEditable = false
        tv.font = .systemFont(ofSize: 13, weight: .bold)
        return tv
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func configure(withText: String) {
        self.detailTextView.text = withText
    }
    
    private func setupUI() {
        addSubview(textViewContainerView)
        textViewContainerView.addSubViews(detailTextView)
        
        textViewContainerView.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(snp.left)
        }
        
        detailTextView.snp.makeConstraints { make in
            make.top.equalTo(textViewContainerView.snp.top).offset(10)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


