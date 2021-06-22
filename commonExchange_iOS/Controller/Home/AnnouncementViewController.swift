//
//  AnnouncementViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/19.
//

import UIKit

class AnnouncementViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tab = UITableView(frame: .zero, style: .plain)
        tab.register(AnnouncementViewCell.self, forCellReuseIdentifier: AnnouncementViewCell.identifier)
        tab.delegate = self
        tab.dataSource = self
        tab.tableFooterView = UIView()
        tab.rowHeight = 70
        return tab
    }()
    
    var viewModel = AnnouncementViewModel()
    var listModel = [ListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        bindingVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden  = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden  = false
    }
    

    
    // MARK: - Helpers
    func bindingVM() {
        viewModel.getArticleList {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    
}

extension AnnouncementViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = viewModel.listModel[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnnouncementViewCell.identifier, for: indexPath) as? AnnouncementViewCell else{
            fatalError("cell is nil")
        }
        cell.backgroundColor = .clear
        cell.configure(with: vm)
        return cell
    }
}

extension AnnouncementViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoList = viewModel.listModel[indexPath.row]
        let controller = AnnouncementDetailViewController(infoList: infoList)
        self.navigationController?.pushViewController(controller, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
