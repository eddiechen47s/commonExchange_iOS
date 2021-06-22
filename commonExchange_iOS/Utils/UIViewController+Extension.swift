//
//  UIViewController+Extension.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/9.
//

import UIKit

extension UIViewController {
    var statusBarHeight: CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
    
    func createNavController(vc: UIViewController, title: String, image: UIImage?, selectedImage: UIImage?, tag: Int) -> UINavigationController {
        self.tabBarItem.tag = tag
        vc.title = title
        
        let navController = UINavigationController(rootViewController: vc)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 34/255, green: 60/255, blue: 83/255, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navController.navigationBar.tintColor = .white
        appearance.shadowColor = nil //新版消陰影

        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.compactAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        navController.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selectedImage

        return navController
    }
    
    func backToPriviousController() {
        let backImage = UIImage(named: "icArrowBack")?.withRenderingMode(.alwaysTemplate).withTintColor(.white)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(tapBack))
    }
    
    @objc func tapBack() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    // 時間戳記
    func timeToTimeStamp(time: String) -> String {
        let timeInterval = TimeInterval(time)
        let date = Date(timeIntervalSince1970: timeInterval ?? 0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let announcementDate = dateFormatter.string(from: date)
        return String(announcementDate)
    }
    
    func timeToMonthStamp(time: String) -> String {
        let timeInterval = TimeInterval(time)
        let date = Date(timeIntervalSince1970: timeInterval ?? 0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm:ss"
        let announcementDate = dateFormatter.string(from: date)
        return String(announcementDate)
    }

    // string to QRCode
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    func countNumber(str: String) -> String {
        let value = (str as NSString).doubleValue
        if value > 0 {
            let newValue = String(format: "%.1f", value)
            return newValue
        } else if value == 0 {
            return "0"
        } else {
            let newValue = String(format: "%.5f", value)
            return newValue
        }
    }
    
    func hiddenKeyboardWithTapView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(tap) // to Replace "TouchesBegan"
    }
    
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
}


extension UIViewController {

    func setupToast() {
        let toastView = BaseView(color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        toastView.layer.cornerRadius = 7
        let toastLabel = BaseLabel(text: "已複製", color: .white, font: .systemFont(ofSize: 18), alignments: .center)
        view.addSubview(toastView)
        toastView.addSubview(toastLabel)
        
        toastView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        toastLabel.snp.makeConstraints { make in
            make.center.equalTo(toastView.snp.center)
            make.width.equalTo(toastView)
            make.height.equalTo(toastView)
        }
        
        UIView.animate(withDuration: 2, delay: 0.5, options: .curveEaseOut) {
            toastView.alpha = 0
            toastLabel.alpha = 0
        } completion: { (done) in
            toastView.removeFromSuperview()
            toastLabel.removeFromSuperview()
        }

    }
    
}
