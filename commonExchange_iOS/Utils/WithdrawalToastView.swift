//
//  WithdrawalToastView.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/4/26.
//

import UIKit

class WithdrawalToastView: UIView {
    
    init(img: BaseImageView, titleLabel: BaseLabel, detailLabel: BaseLabel, buttonTitle: String, action: Selector, vc: UIViewController) {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.2352941176, blue: 0.3254901961, alpha: 1)
        let toastImg = img
        let toastTitleLabel = titleLabel
        let detailLabel = detailLabel
        let backButton = BaseButton(title: buttonTitle, titleColor: .white, font: .systemFont(ofSize: 14, weight: .regular), backgroundColor: #colorLiteral(red: 0.4392156863, green: 0.662745098, blue: 0.6862745098, alpha: 1))
        backButton.addTarget(vc, action: action, for: .touchUpInside)
        
        addSubViews(toastTitleLabel,
                    toastImg,
                    detailLabel,
                    backButton
                    )
        
        toastImg.snp.makeConstraints { make in
            make.bottom.equalTo(toastTitleLabel.snp.top).offset(-15)
            make.centerX.equalTo(self.snp.centerX)
            make.width.height.equalTo(40)
        }
        
        toastTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-20)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(30)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(toastTitleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
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
