//
//  NetworkOptions.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 11/01/22.
//

import Foundation
enum Endpoint {
    case loadPictures(page: Int)
    case search(page: Int, q: String)
}

enum Headers {
    case simpleHeader
}


enum RequestType: String {
    case post = "POST"
    case get = "GET"
}



extension Endpoint {
    
    private var basePath: String {
        "https://api.unsplash.com"
    }
    
    var pathURL: URL? {
        switch self {
        case .loadPictures(let page):
                return URL(string: basePath + "/photos?page=\(page)")
        case .search(let page, let q):
            return URL(string: basePath + "/search/photos?page=\(page)&query=\(q)")
        }
    }
    
    
    var requestType: RequestType {
        switch self {
        case .loadPictures:
            return .get
        case .search:
            return .get
        }
    }

    
}


extension Headers {
    var requestHeader: [String : String]{
        switch self {
        case .simpleHeader:
            return simpleHeader
        }
    }
    

    
    
    private var simpleHeader: [String: String] {
        ["Authorization": "Client-ID \(client_id)" ]
    }
    
    private var client_id: String {
        "OIHV8uveeW95TBhAJ0ikyPLPgfO3stVs5nJDjhpIuUo"
    }
    
    private var client_secret_id: String {
        "gBdEnbPm3Xiku7wJCKreuwBWa_mEWjOiXmO-FbRS-yc"
    }
}

