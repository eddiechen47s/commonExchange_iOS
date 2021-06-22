//
//  SearchPairsViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/9.
//

import UIKit

class SearchPairsViewController: UIViewController {
    
    private var searchBar = UISearchBar()
    private var newSearchPairs = [SearchListData]()
    private var isSearching = false
    let exchangePairViewController = ExchangePairViewController()
    var viewModel = SearchPairsViewModel()
    
    private lazy var tableView: UITableView = {
        let tab = UITableView()
        tab.backgroundColor = #colorLiteral(red: 0.1772809327, green: 0.2758469284, blue: 0.5724449158, alpha: 1)
        tab.delegate = self
        tab.dataSource = self
        tab.register(SearchPairsViewCell.self, forCellReuseIdentifier: SearchPairsViewCell.identifier)
        tab.rowHeight = 60
        return tab
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        setupNavBar()
        setupNavBar()
        setupUI()
        bindingVM()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSearchBar()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1772809327, green: 0.2758469284, blue: 0.5724449158, alpha: 1)
        navigationItem.titleView = searchBar
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Helpers
    private func setupNavBar() {
        searchBar.sizeToFit()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1772809327, green: 0.2758469284, blue: 0.5724449158, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationItem.titleView = searchBar
    }
    
    private func setupSearchBar() {
        searchBar.showsCancelButton = true
        searchBar.delegate = self
    }
    
    private func setupUI() {
        view.addSubViews(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func bindingVM() {
        LoadingView.shared.showLoader()
        viewModel.load {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            LoadingView.shared.hideLoader()
        }
    }

}

extension SearchPairsViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: false, completion: nil)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        newSearchPairs = viewModel.model.filter({ $0.symbol.lowercased().prefix(searchText.count) == searchText.lowercased() })
        if searchText.count > 0 {
            isSearching = true
        } else {
            isSearching = false
        }
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.becomeFirstResponder()
    }
    
}

extension SearchPairsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return newSearchPairs.count
        }else {
            return viewModel.model.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchPairsViewCell.identifier, for: indexPath) as? SearchPairsViewCell else { fatalError("search cell not found")}
        if isSearching {
            let newSearch = newSearchPairs[indexPath.row]
            cell.configure(with: newSearch)
        } else {
            let vm = viewModel.model[indexPath.row]
            cell.configure(with: vm)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        let controller = exchangePairViewController
        controller.modalPresentationStyle = .fullScreen
        navigationItem.titleView = nil
        
        if isSearching {
            controller.titles = newSearchPairs[indexPath.row].symbol.uppercased()
            userDidSelectedPair = newSearchPairs[indexPath.row].symbol.uppercased()
        } else {
            controller.titles = viewModel.model[indexPath.row].symbol.uppercased()
            userDidSelectedPair = viewModel.model[indexPath.row].symbol.uppercased()
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

