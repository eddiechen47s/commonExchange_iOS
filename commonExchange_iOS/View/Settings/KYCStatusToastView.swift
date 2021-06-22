//
//  KYCStatusToastView.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/5/8.
//

import UIKit

class KYCStatusToastView: UIView {
    
    init(img: BaseImageView, titleLabel: BaseLabel, detailLabel: BaseLabel, leftBtnTitle: String, rightBtnTitle: String, lefeBtnAction: Selector, rightBtnAction: Selector, vc: UIViewController) {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.2352941176, blue: 0.3254901961, alpha: 1)
        let toastImg = img
        let toastTitleLabel = titleLabel
        let detailLabel = detailLabel
        detailLabel.numberOfLines = 2
        let leftButton = BaseButton(title: leftBtnTitle, titleColor: .white, font: .systemFont(ofSize: 13, weight: .regular), backgroundColor: #colorLiteral(red: 0.4392156863, green: 0.662745098, blue: 0.6862745098, alpha: 1))
        let rightButton = BaseButton(title: rightBtnTitle, titleColor: .white, font: .systemFont(ofSize: 13, weight: .regular), backgroundColor: #colorLiteral(red: 0.4392156863, green: 0.662745098, blue: 0.6862745098, alpha: 1))
        leftButton.layer.cornerRadius = 5
        rightButton.layer.cornerRadius = 5
        leftButton.addTarget(vc, action: lefeBtnAction, for: .touchUpInside)
        rightButton.addTarget(vc, action: rightBtnAction, for: .touchUpInside)

        addSubViews(toastTitleLabel,
                    toastImg,
                    detailLabel,
                    leftButton,
                    rightButton
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
        
        leftButton.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom).offset(-20)
            $0.left.equalTo(snp.left).offset(20)
            $0.right.equalTo(snp.centerX).offset(-5)
            $0.height.equalTo(40)
        }
        
        rightButton.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom).offset(-20)
            $0.right.equalTo(snp.right).offset(-20)
            $0.left.equalTo(snp.centerX).offset(5)
            $0.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
