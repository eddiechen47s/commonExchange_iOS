//
//  AFManager.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/4/19.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

class AFManager {
    static let shared = AFManager()
    var isUploadStatus: PublishRelay<Bool> = PublishRelay<Bool>()
    var uploadImgName: PublishRelay<String> = PublishRelay<String>()
    
    // 上傳照片
    func uploadImg(image: UIImage, completion: @escaping (Bool) -> Void) {
        
        guard let token = userDefaults.string(forKey: "UserToken")?.data(using: .utf8) else {
            return
        }
        
        Alamofire.upload(multipartFormData: { (data) in
            //先將 UIImage 變成 Data
            guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
            //利用 append function 將它添加到上傳的 data。
            data.append(imageData, withName: "files", fileName: "test.jpg", mimeType: "image/jpeg")
            data.append(token, withName: "token")
        }, to: apiUrlPrefix+APIPath.conformTrueUserToImg.value) { (encodingResult) in
            print(encodingResult)
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let data = response.data {
                        do {
                            let json = try JSONDecoder().decode(TrueUserToImg.self, from: data)
                            if json.status == 1 {
                                self.isUploadStatus.accept(true)
                                self.uploadImgName.accept(json.data.imgName)
                            } else {
                                self.isUploadStatus.accept(false)
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                        completion(true)
                    } else {
                        self.isUploadStatus.accept(false)
                        completion(false)
                    }
                }
            case .failure(let encodingError):
                print("encodingError:", encodingError)
            }
        }
        
    }
    
    //SMS簡訊
//    func sendSMS(sms: String, completion: @escaping (Bool) -> Void) {
//        Alamofire.upload(multipartFormData: { (data) in
//            //利用 append function 將它添加到上傳的 data。
//            let smsData = sms.data(using: .utf8)!
//            data.append(smsData, withName: "mobilePhone", fileName: "", mimeType: "")
//        }, to: apiUrlprefixTest+"user/sendPhoneCode?") { (encodingResult) in
//            print(encodingResult)
//            switch encodingResult {
//            case .success(let upload, _, _):
//                upload.responseJSON { response in
//                    if let data = response.data {
//                        do {
//                            let json = try JSONDecoder().decode(SMSSendPhoneList.self, from: data)
//                            print(json)
//                        } catch {
//                            print(error.localizedDescription)
//                        }
//                        completion(true)
//                    } else {
//                        completion(false)
//                    }
//                }
//            case .failure(let encodingError):
//                print("encodingError:", encodingError)
//            }
//        }
//
//    }
    
  
}
