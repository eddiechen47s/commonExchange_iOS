//
//  LatestResultViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/9.
//

import UIKit

class LatestDealViewController: UIViewController {
    var viewModel = LatestDealViewModel()
    private lazy var tableView: UITableView = {
        let tab = UITableView(frame: .zero, style: .grouped)
        tab.backgroundColor = .white
        tab.register(LatestResultViewCell.self, forCellReuseIdentifier: LatestResultViewCell.identifier)
        tab.register(LatestResultHeaderView.self, forHeaderFooterViewReuseIdentifier: LatestResultHeaderView.identifier)
        tab.dataSource = self
        tab.delegate = self
        tab.separatorColor = .clear
        tab.tableFooterView = UIView()
        return tab
    }()
    var pairTitle = ""
    var timer = Timer()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        bindingVM()
//        setupTimeReload()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    
    deinit {
        print("LatestDealViewController deinit")
    }
    
    // MARK: - Helpers
    private func bindingVM() {
        let param = "symbol=\(self.pairTitle)"
        viewModel.latestDeal(apiURL: APIPath.getTradeLogList.value, param: param) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupUI() {
        view.addSubViews(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupTimeReload() {
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(setupTableData), userInfo: nil, repeats: true)
    }
    
    // MARK: - Selector
    @objc private func setupTableData() {
        bindingVM()
    }
}


extension LatestDealViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LatestResultViewCell.identifier, for: indexPath) as? LatestResultViewCell else {
            fatalError("LatestResultViewCell nil")
        }
        cell.configure(with: viewModel.model[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: LatestResultHeaderView.identifier) as! LatestResultHeaderView
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
}
