//
//  BasePairCollectionViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/3.
//

import UIKit
import RxSwift
import RxCocoa

protocol BasePairDidSelectedIndexDelegate: AnyObject {
    func sendData(model: ExchangeDetail)
}

class BasePairViewController: UIViewController {

    var viewModel = BasePairViewModel()
    let disposeBag = DisposeBag()
    weak var delegate: BasePairDidSelectedIndexDelegate?
    private lazy var tableView: UITableView = {
        let tab = UITableView(frame: .zero, style: .plain)
        tab.backgroundColor = .white
        tab.isScrollEnabled = true
        tab.register(BasePairViewCell.self, forCellReuseIdentifier: BasePairViewCell.identifier)
        tab.delegate = self
        tab.dataSource = self
        tab.tableFooterView = UIView()
        return tab
    }()
    var model = [ExchangeDetail]()
    var exchangePairViewController = ExchangePairViewController()
    private var exchangePageViewController = ExchangePageViewController()

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        bindingPage()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.isScrollEnabled = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // remove noti
//        NotificationCenter.default.removeObserver(self)
    }
    
    deinit {
        print("BasePairViewController deinit")
    }

    // MARK: - Helpers
    func bindingPage() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(notification:)), name: Notification.Name("didSelecredPageIndex"), object: nil)
    }
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
    }
    
    //MARK: - Selector
    @objc func reloadData(notification: Notification) {
        guard let info = notification.object as? Int else { return }
        var coinName: String = ""
        switch info {
        case 0:
            coinName = "btc"
        case 1:
            coinName = "eth"
        case 2:
            coinName = "usdt"
        case 3:
            coinName = "kt"
        default:
            break
        }
        
        LoadingView.shared.showLoader()
        let param = "coinname=\(coinName)"

        let exchangeQueue = DispatchQueue(label: "exchangeQueue", qos: .userInteractive, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
        exchangeQueue.async {
            self.viewModel.getChangeAndPriceList(apiURL: APIPath.getChangeAndPriceList.value, param: param) { (result) in
                self.model = result
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                    LoadingView.shared.hideLoader()
                }
            }
        }

        coinName = ""
    }
    
}

extension BasePairViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasePairViewCell.identifier, for: indexPath) as! BasePairViewCell
        cell.configure(with: model[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let data = model[indexPath.row]
        self.delegate?.sendData(model: data)
        
        let controller = exchangePairViewController
        controller.titles = data.symbol
        userDidSelectedPair = data.symbol
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(UINavigationController(rootViewController: controller), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

struct ExchangeDidSelected {
    let symbol: String
}
