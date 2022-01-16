//
//  SearchResultModel.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 12/01/22.
//

import Foundation
struct SearchResultModel: Decodable {
    var total_pages: Int?
    var results: [PictureModel]?
}
