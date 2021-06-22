//
//  CustomTabBarController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/2/24.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(pushHome), name: NSNotification.Name(rawValue: "pushLogin"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pushCollection), name: NSNotification.Name(rawValue: "pushCollection"), object: nil)
        
        self.tabBarController?.hidesBottomBarWhenPushed = true
        initBaseLayout()
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8630494475, green: 0.8828283548, blue: 0.8894782662, alpha: 1)], for: .normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1332868636, green: 0.2370001972, blue: 0.3250783086, alpha: 1)], for: .selected)
        
        self.delegate = self
    }
    
    deinit {
        print("CustomTabBarController deinit")
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func createNavController(vc: UIViewController, title: String, image: UIImage) -> UINavigationController {
        vc.title = title
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        navController.tabBarItem.image = image
        return navController
    }
        
    //MARK: - prinvate methods
    func initBaseLayout(){
        let homeImg = UIImage(named: "KTrade_navbar")!
        let homeSelected = UIImage(named: "KTrade_hover_navbar")!.withRenderingMode(.alwaysTemplate)
        let exchangeImg = UIImage(named: "Trad_navbar")!
        let exchangeSelected = UIImage(named: "Trad_hover_navbar")!
        let orderImg = UIImage(named: "Order_navbar")!
        let orderImgSelected = UIImage(named: "Order_hover_navbar")!
        let walletImg = UIImage(named: "Wallet_navbar")!
        let walletImgSelected = UIImage(named: "Wallet_hover_navbar")!
        let userImg = UIImage(named: "account_navbar")!
        let userImgSelected = UIImage(named: "account_hover_navbar")!
        
        let main = createNavController(vc: MainViewController(), title: "KTeade", image: homeImg, selectedImage: homeSelected, tag: 0)
        let exchange = createNavController(vc: ExchangeViewController(), title: "交易", image: exchangeImg, selectedImage: exchangeSelected, tag: 1)
        let order = createNavController(vc: OrderViewController(), title: "訂單", image: orderImg, selectedImage: orderImgSelected, tag: 2)
        let wallet = createNavController(vc: WalletViewController(), title: "錢包", image: walletImg, selectedImage: walletImgSelected, tag: 3)
        let userProfile = createNavController(vc: SettingViewController(), title: "帳戶", image: userImg, selectedImage: userImgSelected, tag: 4)
        
        let tabArray = [main,exchange,order,wallet,userProfile]
        self.viewControllers = tabArray
    }
    
    //跳轉到首頁
    @objc func pushHome(){
        self.selectedIndex = 0
    }
    //跳轉到訂單
    @objc func pushCollection() {
        self.selectedIndex = 2
    }
    
    //MARK: --setter getter
    var _lastSelectedIndex: NSInteger!
    var lastSelectedIndex: NSInteger {
        if _lastSelectedIndex == nil {
            _lastSelectedIndex = NSInteger()
            //判斷是否相等，不同才設置
            if (self.selectedIndex != selectedIndex) {
                //設置最近一次
                _lastSelectedIndex = self.selectedIndex;
            }
            //調用父類的setSelectedIndex
            super.selectedIndex = selectedIndex
        }
        return _lastSelectedIndex
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //獲取選中的item
        let tabIndex = tabBar.items?.firstIndex(of: item)
        if tabIndex != self.selectedIndex {
            //設置最近一次變更
            _lastSelectedIndex = self.selectedIndex
        }
    }
    
    //MARK: - UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        switch viewController {
        case self.viewControllers![2] :
            if !(userDefaults.bool(forKey: "isUserLogin"))  {
                self.selectedIndex = _lastSelectedIndex
                let login = LoginViewController()
                login.tag = 2
                let nav = createNavController(vc: login, title: "登入", image: nil, selectedImage: nil, tag: 9)
                nav.modalPresentationStyle = .fullScreen
                self.viewControllers![selectedIndex].present(nav, animated: true, completion: nil)
                return false
            } else {
                return true
            }
        case self.viewControllers![3] :
            
            if !(userDefaults.bool(forKey: "isUserLogin")) {
                self.selectedIndex = _lastSelectedIndex
                let login = LoginViewController()
                login.tag = 2
                let nav = createNavController(vc: login, title: "登入", image: nil, selectedImage: nil, tag: 9)
                nav.modalPresentationStyle = .fullScreen
                self.viewControllers![selectedIndex].present(nav, animated: true, completion: nil)
                return false
            } else {
                return true
            }
        default:
            return true
        }
    }

    
}
