//
//  UIView+Extension.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/2/27.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    // 時間戳記
    func timeToTimeStamp(time: String) -> String {
        let timeInterval = TimeInterval(time)
        let date = Date(timeIntervalSince1970: timeInterval ?? 0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let announcementDate = dateFormatter.string(from: date)
        return String(announcementDate)
    }
    
    func timeToMinStamp(time: String) -> String {
        let timeInterval = TimeInterval(time)
        let date = Date(timeIntervalSince1970: timeInterval ?? 0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let announcementDate = dateFormatter.string(from: date)
        return String(announcementDate)
    }
    
    func timeToSecondStamp(time: String) -> String {
        let timeInterval = TimeInterval(time)
        let date = Date(timeIntervalSince1970: timeInterval ?? 0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let announcementDate = dateFormatter.string(from: date)
        return String(announcementDate)
    }
    
    func unixToDateString(time: String) -> String {
        let timeInterval = TimeInterval(time)
        let date = Date(timeIntervalSince1970: timeInterval ?? 0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm:ss"
        let announcementDate = dateFormatter.string(from: date)
        return String(announcementDate)
    }
    
    func secondStamp(time: String) -> String {
        let timeInterval = TimeInterval(time)
        let date = Date(timeIntervalSince1970: timeInterval ?? 0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let announcementDate = dateFormatter.string(from: date)
        return String(announcementDate)
    }
    
    func strConvertDoublePercent(str: String) -> String {
        let value = (str as NSString).doubleValue

        if value > 0 {
            let newValue = "+" + String(format: "%.2f", value)
            return newValue
        } else if value == 0 {
            return "0"
        } else {
            let newValue = String(format: "%.2f", value)
            return newValue
        }
    }
    

    
    

}


extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
