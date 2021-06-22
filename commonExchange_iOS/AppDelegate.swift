//
//  AppDelegate.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/2/24.
//

import UIKit
import IQKeyboardManagerSwift
import AppTrackingTransparency
import AdSupport

let apiUrlprefixRobot = "https://www.ktrade.io/robot/"
let apiUrlPrefix = "https://www.ktrade.io/api/"
//let apiUrlprefixTest =  "http://21114-80.statecraft-baas.com/api/"
//let apiUrlprefixTestRobot = "http://21114-80.statecraft-baas.com/robot/"

let upColor = #colorLiteral(red: 0.2776432037, green: 0.6590948701, blue: 0.4378901124, alpha: 1)

let userDefaults = UserDefaults.standard
var isUserLogin: Bool? // 判斷使用者是否已登入
var tokenChange: Bool = false

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        requestATTrackingPermission()
        return true
    }

    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func requestATTrackingPermission() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    print("ATTrackingManager authorized, get AppTrackingTransparency Permission")
                    print(ASIdentifierManager.shared().advertisingIdentifier)
                case .notDetermined:
                    print("ATTrackingManager notDetermined")
                case .restricted:
                    print("ATTrackingManager restricted")
                case .denied:
                    print("ATTrackingManager denied")
                default:
                    break
                }
            }
        }
    }
    
}

