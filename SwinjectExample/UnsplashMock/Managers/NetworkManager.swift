//
//  NetworkManager.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 11/01/22.
//

import Foundation
protocol NetworkManagerProtocol {
    func network<T: Decodable>(endpoint: Endpoint, header: Headers, completion: @escaping((BaseResponse<T>) -> Void))
    func cancelCurrentTask()
}
class NetworkManager:  NetworkManagerProtocol {
    
    private let urlSession: URLSession!
    
    static let shared = NetworkManager()
    
    private var currentTask: URLSessionDataTask?
    
    private init() {
        self.urlSession = URLSession.shared
        self.urlSession.configuration.timeoutIntervalForRequest = 3
    }
    
    func network<T: Decodable>(endpoint: Endpoint, header: Headers = .simpleHeader, completion: @escaping((BaseResponse<T>) -> Void)) {
        var baseResponse = BaseResponse<T>(status: .loading, error: nil, response: nil)
        completion(baseResponse)
        
        guard let url = endpoint.pathURL else {
            baseResponse.status = .fail
            baseResponse.error = "URL not found"
            completion(baseResponse)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.requestType.rawValue
        for (key, value) in header.requestHeader {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        print(urlRequest)
        currentTask = urlSession.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                baseResponse.error = error.localizedDescription
                baseResponse.status = .fail
                completion(baseResponse)
            }
            if let response = response as? HTTPURLResponse {
                if let data = data {
                    do {
                        baseResponse.status = .success
                        baseResponse.response = try data.decodeData() as T
                        completion(baseResponse)
                    } catch {
                        baseResponse.status = .fail
                        baseResponse.error = "Decode error"
                        completion(baseResponse)
                    }
                }
            }
            
        }
        currentTask?.resume()
    }
    
    func cancelCurrentTask() {
        currentTask?.cancel()
    }
}

extension Data {
    func decodeData<T: Decodable>() throws -> T {
        try JSONDecoder().decode(T.self, from: self)
    }
}
