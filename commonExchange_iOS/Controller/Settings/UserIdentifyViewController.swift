//
//  UserIdentifyViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/14.
//

import UIKit
import RxSwift
import RxCocoa

class UserIdentifyViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tab = UITableView(frame: .zero, style: .grouped)
        tab.register(UserIdentifyViewCell.self, forCellReuseIdentifier: UserIdentifyViewCell.identifier)
        tab.register(UserIdentifyFooterViewCell.self, forHeaderFooterViewReuseIdentifier: UserIdentifyFooterViewCell.identifier)
        tab.delegate = self
        tab.dataSource = self
        tab.tableFooterView = UIView()
        tab.rowHeight = 60
        return tab
    }()
    
    private var viewModel = UserInfoViewModel()
    private let defaultVM = UserIdentifyViewModel()
    private var model = [UserIdentify]()
    private var isLogin = userDefaults.bool(forKey: "isUserLogin")
    private var disposeBag = DisposeBag()
    private var idAuth: String?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        self.title = "身份驗證"
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        binding()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Helpers
    private func confirmIdAuth() {
        viewModel.userIdcardauth
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] auth in
                print(auth)
                switch auth {
                case 1:
                    self?.idAuth = "審核中"
                case 2:
                    self?.idAuth = "審核不通過"
                case 3:
                    self?.idAuth = "已驗證"
                default:
                    break
                }
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    private func binding() {
        if isLogin {
            if let token = userDefaults.string(forKey: "UserToken")  {
                let param = "token=\(token)"
                viewModel.getUserInfo(param: param) { [weak self] result in
                    print("r:", result)
                    if result[2] == "A" {
                        self?.confirmIdAuth()
                    } else {
                        self?.idAuth = "未驗證"
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    }
                }

            }
        }
    }
    
    private func setupUI() {
        view.addSubViews(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    

}

extension UserIdentifyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isLogin {
            return 2
        }
        return defaultVM.model.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLogin {
//            let vm = viewModel.model[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserIdentifyViewCell.identifier, for: indexPath) as? UserIdentifyViewCell else {
                fatalError("UserIdentifyCell was nil")
            }
            if indexPath.section == 0 && indexPath.row == 0 {
                cell.titleLabel.text = "B Class"
            } else {
                cell.titleLabel.text = "A Class"
                cell.statusLabel.text = self.idAuth
                switch self.idAuth {
                case "審核中":
                    cell.statusLabel.textColor = #colorLiteral(red: 0.9272395968, green: 0.6945468187, blue: 0.02005103044, alpha: 1)
                case "審核不通過":
                    cell.statusLabel.textColor = #colorLiteral(red: 0.8481625915, green: 0.242911458, blue: 0.3187170029, alpha: 1)
                case "已驗證":
                    cell.statusLabel.textColor = #colorLiteral(red: 0.2333128452, green: 0.7429219484, blue: 0.5215145946, alpha: 1)
                default:
                    cell.statusLabel.textColor = .systemGray
                }
            }
            return cell
        } else {
//            let vm = viewModel.model[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserIdentifyViewCell.identifier, for: indexPath) as? UserIdentifyViewCell else {
                fatalError("UserIdentifyCell was nil")
            }
            if indexPath.section == 0 && indexPath.row == 0 {
                cell.titleLabel.text = "B Class"
                cell.statusLabel.text = "未通過"
                cell.statusLabel.textColor = .systemGray
            } else {
                cell.titleLabel.text = "A Class"
                cell.statusLabel.text = "未驗證"
                cell.statusLabel.textColor = .systemGray            }
            return cell
        }
    
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: UserIdentifyFooterViewCell.identifier) as! UserIdentifyFooterViewCell
            footer.configure(withText:"""
                                      • 數位資產存入與提領（需綁定安全驗證）
                                      • 數位資產提領限額：
                                        (1).單筆限額：等值 490,000 TWD以下（約 15,000 USD之數位資產）
                                        (2).24小時限額：等值 5,000,000 TWD以下（約150,000USD之數位資產）
                                      """
                            )
            return footer
        } else if section == 1 {
            let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: UserIdentifyFooterViewCell.identifier) as! UserIdentifyFooterViewCell
            footer.configure(withText:"""
                                      • B Class所有功能
                                      • 幣幣交易
                                      • 數位資產提領限額：
                                        (1).單筆限額：等值 500,000 TWD（約 16,600 USD之數位資產）
                                        (2).24小時限額：等值 5,000,000 TWD以下（約 150,000USD之數位資產）
                                      """
                            )
            return footer
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 150
        }
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        if isLogin {
            if indexPath.section == 0 && indexPath.row == 0 {
                let controller = UserBClassViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            } else {
                let controller = UserAClassViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
}

