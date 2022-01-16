//
//  AllPicturesModel.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 12/01/22.
//

import Foundation


struct PictureModel: Codable {
    var id: String?
    var likes: Int?
    var user: UserModel?
    var urls: URLS?
    var created_at: String?
    
    var links: Links?

}
struct URLS: Codable {
    var regular: String?
}

struct Links: Codable {
    var download_location: String?
}



