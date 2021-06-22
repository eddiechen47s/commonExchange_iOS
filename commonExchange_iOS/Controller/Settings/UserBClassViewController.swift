//
//  UserBClassViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/14.
//

import UIKit

class UserBClassViewController: UIViewController {
    var viewModel = UserInfoViewModel()
    var model = [String]()
    private lazy var tableView: UITableView = {
        let tab = UITableView()
        tab.register(UserBClassViewCell.self, forCellReuseIdentifier: UserBClassViewCell.identifier)
        tab.isScrollEnabled = false
        tab.delegate = self
        tab.dataSource = self
        tab.tableFooterView = UIView()
        tab.rowHeight = 60
        tab.separatorColor = .clear
        return tab
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9762050509, green: 0.976318419, blue: 0.9761529565, alpha: 1)
        self.title = "B Class"
        setupUI()
        binding()
    }
    
    // MARK: - Helpers
    private func binding() {
        if let token = userDefaults.string(forKey: "UserToken")  {
            let param = "token=\(token)"
            viewModel.getUserInfo(param: param) { result in
                self.model = result
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.left.right.equalToSuperview()
            make.height.equalTo(120)
        }
    }
    
    func hideInfo(sensitiveInfo: String) -> String {
        let length = sensitiveInfo.utf8.count
        if length <= 6 { return sensitiveInfo }
        return  String(sensitiveInfo.prefix(6) + String(repeating: "x", count: length - 9) + sensitiveInfo.suffix(3))
    }
}

extension UserBClassViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserBClassViewCell.identifier, for: indexPath) as? UserBClassViewCell else {
            fatalError("UserBClassCell was nil")
        }
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "註冊E-Mail"
            cell.detailLabel.text = model[0]
        case 1:
            cell.titleLabel.text = "手機號碼"
            let hideMoble = hideInfo(sensitiveInfo: model[1])
            cell.detailLabel.text = hideMoble
        default:
            break
        }

        cell.backgroundColor = #colorLiteral(red: 0.9960784314, green: 1, blue: 0.9963441491, alpha: 1)
        return cell
    }
}


