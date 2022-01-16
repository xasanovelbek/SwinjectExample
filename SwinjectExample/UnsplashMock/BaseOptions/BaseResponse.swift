//
//  File.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 11/01/22.
//

import Foundation
struct BaseResponse<T> {
    var status: NetworkStatus
    var error: String?
    var response: T?
}
enum NetworkStatus {
    case loading
    case success
    case fail
}


