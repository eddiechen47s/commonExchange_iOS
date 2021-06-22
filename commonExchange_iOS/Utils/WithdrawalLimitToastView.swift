//
//  WithdrawalLimitToastView.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/4/26.
//

import UIKit

class WithdrawalLimitToastView: UIView {
    
    init(titleLabel: BaseLabel, detailTextView: BaseTextView, action: Selector, vc: UIViewController) {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.2352941176, blue: 0.3254901961, alpha: 1)
        let toastTitleLabel = titleLabel
        let detailTextView = detailTextView
        let backButton = BaseButton(title: "我已瞭解", titleColor: .white, font: .systemFont(ofSize: 14, weight: .regular), backgroundColor: #colorLiteral(red: 0.4392156863, green: 0.662745098, blue: 0.6862745098, alpha: 1))
        backButton.addTarget(vc, action: action, for: .touchUpInside)
        
        addSubViews(toastTitleLabel,
                    detailTextView,
                    backButton
                    )

        toastTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(20)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(30)
        }
        
        detailTextView.snp.makeConstraints { make in
            make.top.equalTo(toastTitleLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(backButton.snp.top  )
        }
        
        backButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).offset(-20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

