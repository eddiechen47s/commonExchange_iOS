//
//  UserProfileViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/2/25.
//

import UIKit
import MessageUI
import SafariServices
import RxSwift
import RxCocoa

class SettingViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tab = UITableView(frame: .zero, style: .grouped)
        tab.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tab.register(SettingProfileViewCell.self, forCellReuseIdentifier: SettingProfileViewCell.identifier)
        tab.register(SettingLogoutFooterView.self, forHeaderFooterViewReuseIdentifier: SettingLogoutFooterView.identifier)
        tab.register(SettingHeaderViewCell.self, forHeaderFooterViewReuseIdentifier: SettingHeaderViewCell.identifier)
        tab.delegate = self
        tab.dataSource = self
        tab.tableFooterView = UIView()
        tab.rowHeight = 60
        tab.backgroundColor = .clear
        tab.separatorColor = .clear
        tab.showsVerticalScrollIndicator = false
        return tab
    }()
    
    private lazy var kycToastView = KYCStatusToastView(img: toastWarningImg, titleLabel: toastTitleLabel, detailLabel: toastDetailLabel, leftBtnTitle: "我已瞭解", rightBtnTitle: "前往綁定", lefeBtnAction: #selector(didTapWait), rightBtnAction: #selector(didTapTobindingKYC), vc: self)
    private let toastWarningImg = BaseImageView(image: "ic_warning", color: nil)
    private let toastTitleLabel = BaseLabel(text: "請注意", color: .white, font: .systemFont(ofSize: 22, weight: .regular), alignments: .center)
    private let toastDetailLabel = BaseLabel(text: "未完成A Class（KYC）驗證，不可進行交易", color: .white, font: .systemFont(ofSize: 16, weight: .regular), alignments: .center)
    
    private var viewModel = SettingViewModel()
    private var logoutVM = LogoutViewModel()
    private var userInfoVM = UserInfoViewModel()
    private let bisposeBag = DisposeBag()
    private var inviteCode = ""
    private let sectionTitles = ["", "帳戶", "設置", "聯絡"]
    private var userEmail = ""
    private var userClassLavel = ""
    private var isUserLogin: Bool = userDefaults.bool(forKey: "isUserLogin")

    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        self.kycToastView.isHidden = true

        setupUI()
        setupDetails()
        bindingVM()
        userDefaults.set(false, forKey: "kycConfirm")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindingUserLogin()
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Helpers
    private func bindingVM() {
        viewModel.configure(on: self)
    }
    
    private func bindingUserLogin() {

        if let token = userDefaults.string(forKey: "UserToken")  {
            let param = "token=\(token)"
            
            userInfoVM.getUserInfo(param: param) { [weak self] (result) in
                if result.count > 0 {
                    self?.userEmail = result[0]
                    self?.userClassLavel = result[2]+" Class"
                    
                    DispatchQueue.main.async {
                        if !userDefaults.bool(forKey: "kycConfirm") {
                            if result[2] == "A" && result[3] == "3" {
                                self?.kycToastView.isHidden = true
                            } else {
                                self?.kycToastView.isHidden = false
                            }
                        }
                    }
                }
            }
            
            userInfoVM.userLoginStatus
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] loginStatus in
                    if loginStatus {
                        self?.bindingInvite()
                    } else {
                        userDefaults.set(false, forKey: "isUserLogin")
                        self?.tableView.reloadData()
                    }
                }).disposed(by: bisposeBag)
        } else {
        }
    }
    
    private func bindingInvite() {
        userInfoVM.inviteCode
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] invite in
                self?.inviteCode = invite
                self?.tableView.reloadData()
            }).disposed(by: bisposeBag)
    }

    private func setupDetails() {
        self.kycToastView.isHidden = true
        self.toastDetailLabel.numberOfLines = 2
    }
    
    private func setupUI() {
        view.addSubViews(tableView,
                         kycToastView)
        
        tableView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        kycToastView.snp.makeConstraints {
            $0.center.equalTo(view.snp.center)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(view.snp.height).multipliedBy(0.37)
        }
    }
    
    private func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mailVC = MFMailComposeViewController()
            mailVC.delegate = self
            mailVC.setToRecipients(["contact@gmail.com"])
            mailVC.setSubject("")
            mailVC.setMessageBody("", isHTML: false)
            mailVC.delegate = self
            //            mailVC.modalPresentationStyle = .fullScreen
            self.present(mailVC, animated: true, completion: nil)
        } else {
            guard let url = URL(string: "https://www.google.com") else { return }
            let vc = SFSafariViewController(url: url)
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    // MARK: - Selector
    @objc private func didTapWait() {
        print("didTapWait")
        self.kycToastView.isHidden = true
        userDefaults.set(true, forKey: "kycConfirm")
    }
    
    @objc private func didTapTobindingKYC() {
        print("didTapTobindingKYC")
        userDefaults.set(true, forKey: "kycConfirm")
        let controller = UserIdentifyViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - TableView
extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel.models.count > 4 {
            return 4
        }
        return viewModel.models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.models[indexPath.section].options[indexPath.row]
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingProfileViewCell.identifier, for: indexPath) as! SettingProfileViewCell

            if !userDefaults.bool(forKey: "isUserLogin") {
                cell.titlelabel.text = "訪客"
                cell.levellabel.text = ""
                cell.iconImageView.image = model.icon
            } else {
                cell.titlelabel.text = self.userEmail
                cell.levellabel.text = self.userClassLavel
                cell.iconImageView.image = model.icon
            }
            cell.accessoryType = .none
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
        if indexPath.section == 1 && indexPath.row == 1 {
            cell.configureRecommend(text: self.inviteCode)
        } else if indexPath.section == 2 && indexPath.row == 0 {
            cell.configureLanguage()
        } else if indexPath.section == 2 && indexPath.row == 1 {
            cell.configureRate()
        } else if indexPath.section == 3 && indexPath.row == 1 {
            cell.hiddenaccessoryImg()
        } else if indexPath.section == 3 && indexPath.row == 2 {
            cell.hiddenaccessoryImg()
        }
        
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let model = viewModel.models[indexPath.section].options[indexPath.row]
        switch model.title {
        //身份驗證
        case SettingType.userIdentify.rawValue:
            if !userDefaults.bool(forKey: "isUserLogin") {
                let controller = createNavController(vc: LoginViewController(), title: "", image: nil, selectedImage: nil, tag: 7)
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true, completion: nil)
            } else {
                let controller = UserIdentifyViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            }
         
        //分享推薦碼
        case SettingType.recommendCode.rawValue:
            if userDefaults.bool(forKey: "isUserLogin") {
                UIPasteboard.general.string = self.inviteCode
                setupToast()
            }
        //所有歷史紀錄
        case SettingType.allHistory.rawValue:
            let controller = RecordViewController()
            controller.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(controller, animated: true)
        //安全驗證
        case SettingType.verified.rawValue:
            let controller = VerifiedViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        //語言
        case SettingType.language.rawValue:
            break
        //社群
        case SettingType.social.rawValue:
            let vc = SocialViewController(style: .grouped)
            vc.modalPresentationStyle = .fullScreen
            vc.title = SettingType.social.rawValue
            self.navigationController?.pushViewController(vc, animated: true)
        //官方網站
        case SettingType.officialWeb.rawValue:
            self.openURL(with: CommunityType.officialWeb.url)
        //客服信箱
        case SettingType.email.rawValue:
            self.sendEmail()
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = viewModel.models[section].title
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingHeaderViewCell.identifier) as? SettingHeaderViewCell else {
            return UIView()
        }
        header.configure(title: title)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 30
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 3 {
            if userDefaults.bool(forKey: "isUserLogin") {
                let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingLogoutFooterView.identifier) as! SettingLogoutFooterView
                footer.delegate = self
                return footer
            }
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if userDefaults.bool(forKey: "isUserLogin") {
            return section == 3 ? 120 : 20
        }
        return section == 3 ? 20 : 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0  && indexPath.row == 0 ? 100 : 50
    }

    func setupSectionHeader(str: String) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        view.addSubview(label)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 34/255, green: 60/255, blue: 83/255, alpha: 1),
                          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)]
        label.attributedText = NSAttributedString(string: str, attributes: attributes)
        return view
    }
}

// MARK: - Email
extension SettingViewController: MFMailComposeViewControllerDelegate,
                                 UINavigationControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

// MARK: - Logout
extension SettingViewController: SettingLogoutDelegate {
    // 按下登出 Button 後動作
    func logOut() {
        let alert = UIAlertController(title: "登出", message: "確定要登出嗎？", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "確定", style: .default) { _ in
            LoadingView.shared.showLoader()
            guard let userName = userDefaults.string(forKey: "UserName") else {
                return
            }
            LogoutViewModel.shared.loginOutAPI(username: userName, completion: { [weak self] result in
                if result {
                    userDefaults.set(false, forKey: "isUserLogin")
                    DispatchQueue.main.async {
                        let logOutAlert = UIAlertController(title: "成功", message: "您已成功登出", preferredStyle: .alert)
                        let logoutAction = UIAlertAction(title: "確定", style: .cancel) { [weak self] (_) in
                            userDefaults.set("", forKey: "UserToken")
                            self?.bindingUserLogin()
                            userDefaults.set(false, forKey: "isUserLogin")
                            self?.userInfoVM.model.removeAll()
                            DispatchQueue.main.async {
                                self?.tableView.reloadData()
                            }
                            LoadingView.shared.hideLoader()
                        }
                        logOutAlert.addAction(logoutAction)
                        self?.present(logOutAlert, animated: true, completion: nil)
                    }
                }
            })
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alert.addAction(logoutAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension SettingViewController: SFSafariViewControllerDelegate {
    func openURL(with url: String) {
        let urlStr = URL(string: url)!
        let safariVC = SFSafariViewController(url: urlStr)
        safariVC.preferredBarTintColor = .white
        safariVC.preferredControlTintColor = .black
        safariVC.dismissButtonStyle = .done
        
        safariVC.delegate = self
        self.present(safariVC, animated: true, completion: nil)
    }
}



