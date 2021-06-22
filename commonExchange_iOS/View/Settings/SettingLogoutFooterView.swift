//
//  SettingLogoutFooterView.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/8.
//

import UIKit

protocol SettingLogoutDelegate: AnyObject {
    func logOut()
}

class SettingLogoutFooterView: UITableViewHeaderFooterView {
    static let identifier = "SettingLogoutFooterView"
    
    weak var delegate: SettingLogoutDelegate?
    
    private let logoutView = BaseView(color: .clear)
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("登出", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6070429087, green: 0.6070575714, blue: 0.6070497036, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9181004763, green: 0.92492944, blue: 0.9373696446, alpha: 1)
        button.setBackgroundColor(#colorLiteral(red: 0.4406845272, green: 0.6621912718, blue: 0.6876695752, alpha: 1), forState: .highlighted)
        button.setTitleColor(.white, for: .highlighted)
        button.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
        addSubViews(logoutView)
        logoutView.addSubview(logoutButton)
        
        logoutView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        logoutButton.snp.makeConstraints { make in
            make.centerY.equalTo(logoutView.snp.centerY)
            make.left.right.equalTo(logoutView).inset(15)
            make.height.equalTo(logoutView.snp.height).multipliedBy(0.4)
        }

    }
    
    @objc func didTapLogOut() {
        delegate?.logOut()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
