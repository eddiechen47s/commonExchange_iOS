//
//  ExchangeViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/2/25.
//

import UIKit
import RxSwift
import RxCocoa

class ExchangeViewController: UIViewController {
    var viewModel = ExchangeViewModel()
    var disposed = DisposeBag()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = false
        cv.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        cv.register(ExchangeViewCell.self, forCellWithReuseIdentifier: ExchangeViewCell.identifier)
        return cv
    }()
    
    private let animationTitleView = BaseView(color: #colorLiteral(red: 0.9535424113, green: 0.962667644, blue: 0.9770348668, alpha: 1))
    private let animationView = BaseView(color: #colorLiteral(red: 0.1773758233, green: 0.2713364959, blue: 0.5842670798, alpha: 1))
    private let pairDetailView = BaseView(color: .white)
    private let bottomView = BaseView(color: #colorLiteral(red: 0.9535424113, green: 0.962667644, blue: 0.9770348668, alpha: 1))
    private var exchangePageViewController = ExchangePageViewController()
    private var currentPage: Int = 0
    private let disposeBag = DisposeBag()
        
    private let tradingMarketLabel = BaseLabel(text: "交易市場", color: .systemGray, font: .systemFont(ofSize: 14, weight: .black), alignments: .left)
    private let latestPriceLabel = BaseLabel(text: "最新價", color: .systemGray, font: .systemFont(ofSize: 14, weight: .black), alignments: .left)
    private let changePercentLabel = BaseLabel(text: "24h 漲幅", color: .systemGray, font: .systemFont(ofSize: 14, weight: .black), alignments: .left)
//    private var titleModel = [String]()
    private var titleModel = ["BTC", "ETH", "USDT", "KT"]
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        bindingPage()
        exchangePageViewController.exchangePageDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Helpers
    func bindingTitle() {
        self.viewModel.load { [weak self] data in
            self?.titleModel = data
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
            }
        }
    }
    
    func setupUI() {
        view.addSubViews(collectionView,
                         animationTitleView,
                         pairDetailView,
                         exchangePageViewController.view)
        
        animationTitleView.addSubview(animationView)
        pairDetailView.addSubViews(tradingMarketLabel,
                                   latestPriceLabel,
                                   changePercentLabel,
                                   bottomView
                                   )
        
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        animationTitleView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(3.5)
        }
        
        animationView.snp.makeConstraints { make in
            make.centerY.equalTo(animationTitleView.snp.centerY)
            make.left.equalTo(animationTitleView.snp.left)
            make.width.equalTo(animationTitleView.snp.width).multipliedBy(0.25)
            make.height.equalTo(animationTitleView.snp.height)
        }
        
        pairDetailView.snp.makeConstraints { make in
            make.top.equalTo(animationTitleView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(35)
        }
        
        tradingMarketLabel.snp.makeConstraints { make in
            make.centerY.equalTo(pairDetailView.snp.centerY)
            make.left.equalTo(pairDetailView.snp.left).offset(20)
            make.width.equalTo(pairDetailView.snp.width).multipliedBy(0.3)
            make.height.equalToSuperview()
        }
        
        latestPriceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(pairDetailView.snp.centerY)
            make.left.equalTo(tradingMarketLabel.snp.right).offset(20)
            make.width.equalTo(pairDetailView.snp.width).multipliedBy(0.3)
            make.height.equalToSuperview()
        }
        
        changePercentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(pairDetailView.snp.centerY)
            make.left.equalTo(latestPriceLabel.snp.right)
            make.width.equalTo(pairDetailView.snp.width).multipliedBy(0.3)
            make.height.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.bottom.equalTo(pairDetailView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
        
        exchangePageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(pairDetailView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    
    func bindingPage() {
        exchangePageViewController.didSelectedPageIndex
            .subscribe(onNext: { [weak self] index in
                self?.currentPage = index
                self?.setAnimationViewSelected(index: index)
                self?.setANimation(index: index)
                NotificationCenter.default.post(name: Notification.Name("didSelecredPageIndex"), object: index)
            })
            .disposed(by: disposeBag)
    }
    
    func setAnimationViewSelected(index: Int) {
        DispatchQueue.main.async {
            self.collectionView.selectItem(at: IndexPath(item: index, section: 0),
                                           animated: true,
                                           scrollPosition: .bottom)
        }
    }
    
    func setANimation(index: Int) {
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
            let targetX = UIScreen.main.bounds.width / CGFloat(ExchangeTitleType.allCases.count) * CGFloat(index)
            self.animationView.transform = CGAffineTransform(translationX: targetX, y: 0)
        } completion: { (_) in
        }

    }

}


// MARK: - CollectionView Set
extension ExchangeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExchangeViewCell.identifier, for: indexPath) as! ExchangeViewCell
        cell.configure(vm: titleModel[indexPath.row].uppercased())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/4, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.exchangePageViewController.disPlayPage(index: indexPath.item)
    }
}

extension ExchangeViewController: ExchangePageDidSelectedIndexDelegate {
    func sendData(model: ExchangeDetail) {
        let controller = ExchangePairViewController()
        controller.titles = model.symbol.uppercased()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
