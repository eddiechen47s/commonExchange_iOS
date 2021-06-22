//
//  APIClient.swift
//  commonExchange_iOS
//
//  Created by ktrade on 2021/3/24.
//

import Foundation

enum NetWorkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpsMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HttpsMethod = .get
    var body: Data? = nil
}

protocol APIClientPost: AnyObject {
    func create<T>(url: String, vm: T) -> Resource<T?>
}

class APIClient {
    
    static let shared = APIClient()
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetWorkError>) -> Void) {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data , error == nil else {
                completion(.failure(.domainError))
                return
            }
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()

    }

    
}

extension APIClientPost {
    func create<T>(url: String, vm: T) -> Resource<T?> {
        
        guard let url = URL(string: url) else {
            fatalError("url error")
        }
        
        guard let data = try? JSONEncoder().encode(vm) else {
            fatalError("Error encoding data")
        }
        
        var resource = Resource<T?>(url: url)
        resource.httpMethod = HttpsMethod.post
        resource.body = data
        
        return resource
    }
}


class APIManager {
    
    static let shared = APIManager()
    
    func handleFetchAPI(apiURL: String, param: String, completion:@escaping (Data?, URLResponse?, Error?) -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        guard let url = URL(string: apiUrlPrefix + apiURL) else { return }
        //傳遞予 API 的參數
        let postString = param
        print(url)
        do {
            //建立 API 連線要求
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody =  postString.data(using: String.Encoding.utf8)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            //傳送 request 並非同步接收 response
            
            let task = session.dataTask(with: request, completionHandler: completion)
            //非同步傳送 request，不等待 response，讓程式先繼續往下執行
            task.resume()
        }
    }
    
    func handleFetchAPIss(apiURL: String, param: [String: String], completion:@escaping (Data?, URLResponse?, Error?) -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        guard let url = URL(string: apiUrlPrefix + apiURL) else { return }
        //傳遞予 API 的參數
//        let postString = try param.jso
        print(param)
        let data = try! JSONSerialization.data(withJSONObject: param, options: [])
        print(data)
        print(url)
        print(param)
        do {
            //建立 API 連線要求
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody =  data
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            //傳送 request 並非同步接收 response
            
            let task = session.dataTask(with: request, completionHandler: completion)
            //非同步傳送 request，不等待 response，讓程式先繼續往下執行
            task.resume()
        }
    }
    
    
    func fetchRobotAPI(apiURL: String, param: String, completion:@escaping (Data?, URLResponse?, Error?) -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        guard let Url = URL(string: apiUrlprefixRobot  + apiURL) else { return }
        //傳遞予 API 的參數
        let postString = param
        do {
            //建立 API 連線要求
            var request = URLRequest(url: Url)
            request.httpMethod = "POST"
            request.httpBody =  postString.data(using: String.Encoding.utf8)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            //傳送 request 並非同步接收 response
            
            let task = session.dataTask(with: request, completionHandler: completion)
            //非同步傳送 request，不等待 response，讓程式先繼續往下執行
            task.resume()
        }
    }
    
    func handleTestAPI(apiURL: String, param: String, completion:@escaping (Data?, URLResponse?, Error?) -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        guard let url = URL(string: apiUrlPrefix + apiURL) else { return }
        //傳遞予 API 的參數
        let postString = param
        
        do {
            //建立 API 連線要求
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody =  postString.data(using: String.Encoding.utf8)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            //傳送 request 並非同步接收 response
            
            let task = session.dataTask(with: request, completionHandler: completion)
            //非同步傳送 request，不等待 response，讓程式先繼續往下執行
            task.resume()
        }
    }
}
