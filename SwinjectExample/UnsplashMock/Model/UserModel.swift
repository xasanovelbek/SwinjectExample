//
//  UserModel.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 12/01/22.
//

import Foundation
struct UserModel: Codable {
    var id: String?
    var username: String?
    var name: String?
    var total_photos: Int?
    var total_likes: Int?
}
