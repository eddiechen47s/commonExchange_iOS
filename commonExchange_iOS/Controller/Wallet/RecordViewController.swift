//
//  RecordViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/12.
//

import UIKit

class RecordViewController: UIViewController {
    
    var viewModel = RecordViewModel()
    
    private lazy var tableView: UITableView = {
        let tab = UITableView()
        tab.register(RecordViewCell.self, forCellReuseIdentifier: RecordViewCell.identifier)
        tab.dataSource = self
        tab.delegate = self
        tab.backgroundColor = #colorLiteral(red: 0.9762050509, green: 0.976318419, blue: 0.9761529565, alpha: 1)
        tab.separatorColor = .clear
        tab.tableFooterView = UIView()
        tab.rowHeight = 70
        return tab
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        setupUI()
        bindingVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "所有歷史紀錄"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = "訂單"
    }
    
    deinit {
        print("RecordViewController deinit")
    }
    
    // MARK: - Helpers
    func bindingVM() {
        viewModel.configure(on: self)
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension RecordViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = viewModel.model[indexPath.section].options[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordViewCell.identifier, for: indexPath) as? RecordViewCell else {
            fatalError("RecordViewCell was error")
        }
        cell.configure(with: vm)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let vm = viewModel.model[indexPath.section].options[indexPath.row]
        switch vm.title {
        case "訂單記錄":
            let controller = AllRecordOrderViewController()
            controller.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(controller, animated: true)
        case "已成交記錄":
            let controller = AllFinishRecordViewController()
            controller.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(controller, animated: true)
        case "存入記錄":
            let controller = AllDepositViewController()
            controller.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(controller, animated: true)
        case "提領記錄":
            let controller = AllWithdrawalRecordViewController()
            controller.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(controller, animated: true)
        default:
            let controller = InternalTransferViewController()
            controller.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(controller, animated: true)
        }
        print(viewModel.model[indexPath.section].options[indexPath.row])
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9762050509, green: 0.976318419, blue: 0.9761529565, alpha: 1)
        return view
    }
    
    
}
