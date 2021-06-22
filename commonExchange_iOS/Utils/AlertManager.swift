//
//  AlertManager.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/15.
//

import UIKit

class AlertManager {
    static let shared = AlertManager()
    
    func uploadPhotoMask() -> UpdateMaskViewController {
        let storyboard = UIStoryboard(name: "UpdateMaskStoryboard", bundle: .main)
        let uuploadVC = storyboard.instantiateViewController(withIdentifier: "updateVC") as! UpdateMaskViewController
        
        return uuploadVC
    }

    
    
    
}
