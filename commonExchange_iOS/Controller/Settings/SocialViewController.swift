//
//  SocialViewController.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/4/11.
//

import UIKit
import MessageUI
import SafariServices

class SocialViewController: UITableViewController {

    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel = SocialViewModel()
    
    var titles: [String] = []
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
    }
    
    // MARK: - Helpers
    func setupTableView() {
        tableView.backgroundColor = #colorLiteral(red: 0.9694051147, green: 0.9695176482, blue: 0.9693532586, alpha: 1)
        tableView.register(SocialViewCell.self, forCellReuseIdentifier: SocialViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.tableFooterView = UIView()
    }
    
    func setupUI() {
        self.tableView.frame = view.bounds
    }

    // MARK: - TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = viewModel.model[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SocialViewCell.identifier, for: indexPath) as! SocialViewCell
        cell.configure(with: vm)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let vm = viewModel.model[indexPath.row].title

        switch vm {
        case "Facebook":
            self.openURL(with: CommunityType.fb.url)
        case "Instagram":
            self.openURL(with: CommunityType.ig.url)
        case "Twitter":
            self.openURL(with: CommunityType.twitter.url)
        case "Line":
            self.openURL(with: CommunityType.line.url)
        case "Telegram":
            self.openURL(with: CommunityType.telegram.url)
        case "Meduim":
            self.openURL(with: CommunityType.med.url)
        default:
            break
        }

    }

}

// MARK: - Open URL(社群)
extension SocialViewController: SFSafariViewControllerDelegate {
    
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
