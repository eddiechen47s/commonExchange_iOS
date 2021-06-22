//
//  GoogleVerifiedToastView.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/4/24.
//

import UIKit

class GoogleVerifiedToastView: UIView {
    
    init(img: BaseImageView, titleLabel: BaseLabel) {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.2352941176, blue: 0.3254901961, alpha: 1)
        let toastImg = img
        let titleLabel = titleLabel
        
        addSubViews(titleLabel,
                    toastImg
                    )
        
        toastImg.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(-10)
            make.centerX.equalTo(self.snp.centerX)
            make.width.height.equalTo(40)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(25)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
