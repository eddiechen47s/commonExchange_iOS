//
//  UIImageView+Extension.swift
//  commonExchange_iOS
//
//  Created by Keita on 2021/4/25.
//

import UIKit

extension UIImageView {
    
    static func generateQRCode(from string: String, imageView: UIImageView) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            // L: 7%, M: 15%, Q: 25%, H: 30%
            filter.setValue("M", forKey: "inputCorrectionLevel")
            
            if let qrImage = filter.outputImage {
                let scaleX = imageView.frame.size.width / qrImage.extent.size.width
                let scaleY = imageView.frame.size.height / qrImage.extent.size.height
                let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                let output = qrImage.transformed(by: transform)
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    
}
