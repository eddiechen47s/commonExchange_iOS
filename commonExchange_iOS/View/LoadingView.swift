//
//  LoadingView.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/26.
//

import UIKit

class LoadingView: UIView {
    
    static let shared = LoadingView()
    
    lazy var transparentView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.93)
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var loadingLabel: UILabel = {
       let label = UILabel()
        label.text = "載入中"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var activityView: UIActivityIndicatorView = {
        let ac = UIActivityIndicatorView(style: .large)
        ac.hidesWhenStopped = true
        ac.color = UIColor.white
        return ac
    }()
    
    func showLoader() {
        
        self.transparentView.isUserInteractionEnabled = true //關閉 User 在 loading 的時候還可以點擊其他頁面
        self.addSubview(transparentView)
        self.transparentView.addSubview(loadingLabel)
        self.transparentView.addSubview(activityView)
        
        loadingLabel.snp.makeConstraints { make in
            make.center.equalTo(transparentView.snp.center)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        activityView.snp.makeConstraints { make in
            make.bottom.equalTo(loadingLabel.snp.top).offset(-10)
            make.centerX.equalTo(transparentView.snp.centerX)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        self.transparentView.bringSubviewToFront(self.loadingLabel)
        self.transparentView.bringSubviewToFront(self.activityView)
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.addSubview(self.transparentView)
            self.activityView.startAnimating()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.activityView.stopAnimating()
            self.transparentView.removeFromSuperview()
        }
    }
}
