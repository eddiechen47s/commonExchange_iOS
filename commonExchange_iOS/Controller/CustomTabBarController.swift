//
//  CustomTabBarController.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/2/24.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    fileprivate func createNavController(vc: UIViewController, title: String, image: UIImage) -> UINavigationController {
        vc.title = title
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        navController.tabBarItem.image = image
        return navController
    }
    
    private func configure() {
        let homeImg = UIImage(systemName: "house.fill")!
        let exchangeImg = UIImage(systemName: "flame.fill")!
        let orderImg = UIImage(systemName: "folder.fill")!
        let walletImg = UIImage(systemName: "heart.fill")!
        let userImg = UIImage(systemName: "person")!

        
        let home = createNavController(vc: HomeViewController(), title: "MAX", image: homeImg)
        let exchange = createNavController(vc: ExchangeViewController(), title: "交易", image: exchangeImg)
        let order = createNavController(vc: OrderViewController(), title: "訂單", image: orderImg)
        let wallet = createNavController(vc: WalletViewController(), title: "錢包", image: walletImg)
        let userProfile = createNavController(vc: UserProfileViewController(), title: "使用者", image: userImg)
        viewControllers = [home, exchange, order, wallet, userProfile]
        
        
    }
    
}
