//
//  ExchangePageViewController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/3.
//

import UIKit
import RxSwift
import RxCocoa

protocol ExchangePageDidSelectedIndexDelegate: AnyObject {
    func sendData(model: ExchangeDetail)
}

class ExchangePageViewController: UIPageViewController {
    
    private var viewControlerList: [UIViewController] = [UIViewController]()
    private var currentPageIndex: Int = 0
    var didSelectedPageIndex = BehaviorRelay<Int>(value: 0)
    var model: ExchangeDetail?
    var exchangePageDelegate: ExchangePageDidSelectedIndexDelegate?
    var viewModel = ExchangeViewModel()
    var disposeBag = DisposeBag()

    // MARK: - init
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Helpers
    func setupPageView() {
        self.delegate = self
        self.dataSource = self
        
        for _ in 0..<ExchangeTitleType.allCases.count {
            let subViewController = BasePairViewController()
            subViewController.delegate = self
            viewControlerList.append(subViewController)
        }
        
        self.currentPageIndex = 0
        //設定首頁
        self.setViewControllers([viewControlerList.first!],
                                direction: .forward,
                                animated: true,
                                completion: nil)
    }
    
    func disPlayPage(index: Int, animated: Bool = true) {
        if self.currentPageIndex == index { return }
        if index < self.currentPageIndex {
            self.setViewControllers([self.viewControlerList[index]],
                                    direction: .reverse,
                                    animated: true,
                                    completion: nil)
        } else if index > self.currentPageIndex {
            self.setViewControllers([self.viewControlerList[index]],
                                    direction: .forward,
                                    animated: true,
                                    completion: nil)
        }
        self.currentPageIndex = index
        self.didSelectedPageIndex.accept(index)
    }
}

extension ExchangePageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentViewController: UIViewController = (self.viewControllers?.first)!
        let currentIndex: Int = self.viewControlerList.firstIndex(of: currentViewController)!
        self.currentPageIndex = currentIndex
        self.didSelectedPageIndex.accept(currentIndex)
    }
}

extension ExchangePageViewController: UIPageViewControllerDataSource {
    // 上一頁
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // 取得當前頁數
        let currentIndex: Int = self.viewControlerList.firstIndex(of: viewController)!
        self.currentPageIndex = currentIndex

        // 設定上一頁 index
        let priviousIndex: Int = currentIndex - 1
        // 判斷上一頁<0 , 回傳 nil , 否則回傳 priviousIndex Controller
        return priviousIndex < 0 ? nil : self.viewControlerList[priviousIndex]
    }
    
    // 下一頁
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // 取得當前頁數
        let currentIndex: Int = self.viewControlerList.firstIndex(of: viewController)!
        self.currentPageIndex = currentIndex

        // 設定下一頁 index
        let nextIndex: Int = currentIndex + 1
        // 判斷下一頁的 index 是否大於總頁數，若大於則停留在當前的頁數
        return nextIndex > viewControlerList.count - 1 ? nil : self.viewControlerList[nextIndex]
    }
}

extension ExchangePageViewController: BasePairDidSelectedIndexDelegate {
    func sendData(model: ExchangeDetail) {
        self.exchangePageDelegate?.sendData(model: model)
    }
}
