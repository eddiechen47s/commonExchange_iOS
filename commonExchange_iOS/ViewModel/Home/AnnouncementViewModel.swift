//
//  AnnouncementViewModel.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/19.
//

import UIKit

class AnnouncementViewModel {
    
    var listModel :[ListModel] = []
    
    func getArticleList(completion: @escaping () -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        guard let Url = URL(string: apiUrlPrefix+APIPath.getArticleList.value) else { return }
        
        //傳遞予 API 的參數
        let postString = APIParam.getArticleList.value
        
        do {
            //建立 API 連線要求
            var request = URLRequest(url: Url)
            request.httpMethod = "POST"
            request.httpBody =  postString.data(using: String.Encoding.utf8)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            //傳送 request(with: request)，並非同步接收 Response
            let task = session.dataTask(with: request) { (data, request, error) in
                if let error = error {
                    print("Error to get data",error)
                } else {
                    //取得回傳值，並且解析
                    if let data = data {
                        do {
                            let returnobject = try JSONDecoder().decode(SystemAnnouncementList.self, from: data)
                            let jsonData = returnobject.data.list
//                            print(jsonData.count)
                            self.listModel = jsonData
//                            print(self.listModel)
//                            for json in jsonData {
//                                let addtime = json.addtime
//                                let title = json.title
////                                let content = json.contentCt?.withoutHtml
//                                let newContent = json.contentCt
//
//                                self.models.append(ListModel(addtime: addtime, title: title, contentCt: newContent))
//                            }
                            completion()
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            //非同步傳送 request，不等待 response，讓程式先繼續往下執行
            task.resume()
        }
    }
    
    
    
}
