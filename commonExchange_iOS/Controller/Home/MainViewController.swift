//
//  MainViewController.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/2/27.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Network
import FSPagerView

let homeQueue = DispatchQueue(label: "bannerQueue", qos: .userInteractive, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)

class MainViewController: UIViewController {
    let mainTradingPairViewController = MainTradingPairViewController()
    let mainTradingDetailViewController = MainTradingDetailViewController()
    var bannerVM = MainBannerViewModel()
    var isScrollToIndex = true // 強制判斷 scroll index
    var userInfoVM = UserInfoViewModel()
    let bisposeBag = DisposeBag()
    var inviteCode = ""
    
    private let scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.backgroundColor = #colorLiteral(red: 0.9507853389, green: 0.9660757184, blue: 0.9805125594, alpha: 1)
        scrollview.showsVerticalScrollIndicator = false
        return scrollview
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9507853389, green: 0.9660757184, blue: 0.9805125594, alpha: 1)
        return view
    }()
    
    private let annButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bell")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapBell), for: .touchUpInside)
        return button
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        return button
    }()
    
    private let recommendView: BaseView = {
        let view = BaseView(color: .white)
        return view
    }()
    
    private let recommendButton: UIButton = {
        let button = UIButton()
        button.setTitle("立即推薦", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.backgroundColor = #colorLiteral(red: 0.1772809327, green: 0.2758469284, blue: 0.5724449158, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapRecommend), for: .touchUpInside)
        return button
    }()
    
    private let spaceView: BaseView = {
        let view = BaseView(color: .white)
        return view
    }()
    
    // 懒加载滚动图片浏览器
    private lazy var pagerView : FSPagerView = {
        let pagerView = FSPagerView()
//        pagerView.backgroundColor = .black
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval = 4
        pagerView.isInfinite = !pagerView.isInfinite
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: BannerPagerViewCell.identifier)
        return pagerView
    }()
    
    // 懒加载滚动图片浏下标
    lazy var pagerControl:FSPageControl = {
        let pageControl = FSPageControl()
        //设置下标的个数
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        //设置下标位置
        pageControl.contentHorizontalAlignment = .center
        return pageControl
        
    }()
    var imageNameList = [String]()
    private let navBarAnimatedView = BaseView(color: #colorLiteral(red: 0.1784736216, green: 0.2739090323, blue: 0.5731135011, alpha: 1))
    private let navBarLabel = BaseLabel(text: "KTrade", color: .white, font: .systemFont(ofSize: 20, weight: .bold), alignments: .center)
    private let annImg = NavbarImageView(image: "bell", color: .white)

    private lazy var navBarAnnButton = NavBarButton(img: annImg, action: #selector(didTapBell), vc: self)
    private let navBarSearchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        return button
    }()
//    race condition
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        scrollView.delegate = self
        setupUI()
        //        WsManager.shared.initMainTradingSocket(url: WSURL.mainTradingPair.rawValue)
        bindingVM()
        confirmServerStatus()
        self.navBarAnimatedView.alpha = 0.95
        self.annImg.tintColor = .white
        self.navBarAnnButton.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden  = true
    }

    deinit {
        print("MainViewController deinit")
    }
    
    // MARK: - Helpers
    private func setupNavBar() {
        let width = view.frame.width
        let titleView = BaseView(color: .clear)
        let titleLabel = BaseLabel(text: "Ktrade", color: .white, font: .systemFont(ofSize: 25), alignments: .left)
        titleView.addSubview(titleLabel)
        
        titleView.frame = .init(x: 0, y: 0, width: width, height: 50)
        titleLabel.snp.makeConstraints {
            $0.edges.equalTo(titleView)
        }
        navigationItem.titleView = titleView
    }
    
    func bindingVM() {
        homeQueue.async {
            self.bannerVM.loadBannerImg { [weak self] imgAr in
                self?.imageNameList.removeAll()
                self?.imageNameList = imgAr
                self?.pagerControl.numberOfPages = self?.bannerVM.model.count ?? 0
                DispatchQueue.main.async {
                    self?.pagerView.reloadData()
                }
            }
        }
    }
    
    private func confirmServerStatus() {
        bannerVM.netWorkError
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { netStatus in
                if !netStatus {
                    let alert = UIAlertController(title: "錯誤", message: "網路出現異常，請重新連線。", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "確定", style: .cancel, handler: nil)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }).disposed(by: bisposeBag)
    }
    
    func setupUI() {
        view.addSubViews(scrollView, navBarAnimatedView)
        scrollView.addSubview(contentView)
        addChild(mainTradingPairViewController)
        contentView.addSubview(mainTradingPairViewController.view)
        mainTradingPairViewController.didMove(toParent: self)
        
        addChild(mainTradingDetailViewController)
        contentView.addSubview(mainTradingDetailViewController.view)
        mainTradingDetailViewController.didMove(toParent: self)
        scrollView.addSubview(pagerView)
        pagerView.addSubViews(pagerControl, annButton, searchButton)
        contentView.addSubViews(recommendView, spaceView)
        recommendView.addSubview(recommendButton)
        navBarAnimatedView.addSubViews(navBarLabel, navBarAnnButton, navBarSearchButton)
   
        //限制在安全區域（因此它不會在標籤欄下方延伸）
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(-statusBarHeight) // 減去狀態列高度
            make.left.equalTo(view.snp.left)
            make.width.equalTo(self.view.snp.width)
            //            make.height.equalTo(self.view.snp.height)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        // 實際控制高度
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.scrollView)
            make.width.equalTo(self.view.snp.width)
            make.height.equalTo(900)
        }
        navBarAnimatedView.snp.makeConstraints {
            $0.bottom.equalTo(self.scrollView.snp.top).offset(-statusBarHeight)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(100)
        }
        navBarLabel.snp.makeConstraints {
            $0.bottom.equalTo(navBarAnimatedView.snp.bottom)
            $0.centerX.equalTo(navBarAnimatedView.snp.centerX)
            $0.width.equalTo(navBarAnimatedView.snp.width)
            $0.height.equalTo(50)
        }
        navBarAnnButton.snp.makeConstraints {
            $0.centerY.equalTo(navBarLabel.snp.centerY)
            $0.left.equalTo(navBarAnimatedView.snp.left).offset(15)
            $0.width.height.equalTo(18)
        }
        navBarSearchButton.snp.makeConstraints {
            $0.centerY.equalTo(navBarLabel.snp.centerY)
            $0.right.equalTo(navBarAnimatedView.snp.right).offset(-15)
            $0.width.height.equalTo(18)
        }
        pagerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.25)
        }
        pagerControl.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.bottom.equalTo(pagerView.snp.bottom).offset(0)
            make.centerX.equalTo(self.pagerView)
        }
        annButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(statusBarHeight+10)
            make.left.equalTo(contentView.snp.left).offset(15)
            make.width.height.equalTo(18)
        }
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(statusBarHeight+10)
            make.right.equalTo(contentView.snp.right).offset(-15)
            make.width.height.equalTo(18)
        }
        
        recommendView.snp.makeConstraints { make in
            make.top.equalTo(pagerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
        recommendButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(recommendView.snp.centerX)
            make.centerY.equalTo(recommendView.snp.centerY)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        mainTradingPairViewController.view.snp.makeConstraints { make in
            make.top.equalTo(recommendView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(70)
        }
        
        spaceView.snp.makeConstraints { make in
            make.top.equalTo(mainTradingPairViewController.view.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(10)
        }
        
        mainTradingDetailViewController.view.snp.makeConstraints { make in
            make.top.equalTo(spaceView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(contentView.snp.bottom)
        }

    }
    
    func bindingUserInfo() {
        if let token = userDefaults.string(forKey: "UserToken")  {
            let param = "token=\(token)"
            userInfoVM.getUserInfo(param: param) { (_) in }
            userInfoVM.inviteCode
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] invite in
                    UIPasteboard.general.string = invite
                    if invite != "" {
                        self?.setupToast()
                    }
                }).disposed(by: bisposeBag)
        }
    }
    
    // MARK: - Selector
    @objc private func didTapRecommend() {
        bindingUserInfo()
    }
    
    @objc private func didTapBell() {
        print("didTapBellButton")
        let vc = AnnouncementViewController()
        vc.title = "公告"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapSearch() {
        let vc = UINavigationController(rootViewController: SearchPairsViewController())
        vc.modalPresentationStyle = .fullScreen
        self.present(vc , animated: false, completion: nil)
    }
    
    
}

extension MainViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    // - FSPagerView Delegate
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imageNameList.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: BannerPagerViewCell.identifier, at: index)
        let imgName = imageNameList[index]
        cell.imageView?.kf.setImage(with: URL(string: apiUrlPrefix+"files/banner/\(imgName)"))
        self.pagerControl.currentPage = 0
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pagerControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pagerControl.currentPage = pagerView.currentIndex
    }
    
    
}

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let safeAreaTop = UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.safeAreaInsets.top ?? 0
        let offset = scrollView.contentOffset.y + safeAreaTop
//        print("y:", scrollView.contentOffset.y)
//        print("safeAreaTop:", safeAreaTop)
//        print("offset:", offset)
        navBarAnimatedView.bringSubviewToFront(self.view)
        if scrollView.contentOffset.y == 0 || scrollView.contentOffset.y < 0 {
            scrollView.bounces = false
            navBarAnimatedView.transform = .init(translationX: 0, y: 0)
            self.searchButton.isHidden = false
            self.annButton.isHidden = false
        } else {
            scrollView.bounces = true
            if safeAreaTop < 22 {
                navBarAnimatedView.transform = .init(translationX: 0, y: offset)
                if offset > navBarAnimatedView.frame.height {
                    navBarAnimatedView.transform = .init(translationX: 0, y: 100)
                    self.searchButton.isHidden = true
                    self.annButton.isHidden = true
                }
            } else  if safeAreaTop == 47 {
                if offset > -safeAreaTop/2 {
                    navBarAnimatedView.transform = .init(translationX: 0, y: 210-safeAreaTop/2)
                    self.searchButton.isHidden = true
                    self.annButton.isHidden = true
                }
            } else if safeAreaTop == 44 {
                if offset > -safeAreaTop/2 {
                    navBarAnimatedView.transform = .init(translationX: 0, y: 207-safeAreaTop/2)
                    self.searchButton.isHidden = true
                    self.annButton.isHidden = true
                }
            }
        }
    }
    
}
