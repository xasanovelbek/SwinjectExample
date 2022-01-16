//
//  FavouriresRepository.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 12/01/22.
//

import Foundation
protocol FavouritesRepositoryProtocol {
    func getPictures(completion: @escaping((BaseResponse<[PictureModel]>) -> Void))
    func addToFavourite(picture: PictureModel, completion: @escaping((Bool) -> Void))
    func removeFromFavourite(picture: PictureModel, completion: @escaping((Bool) -> Void))
    
    var manager: DBManagerProtocol? { get set }
}
class FavouritesRepository: FavouritesRepositoryProtocol {
    var manager: DBManagerProtocol?
    func getPictures(completion: @escaping((BaseResponse<[PictureModel]>) -> Void)) {
        manager?.getFavourites { (baseResponse: BaseResponse<[PictureModel]>) in
            completion(baseResponse)
        }
    }
    
    func addToFavourite(picture: PictureModel, completion: @escaping((Bool) -> Void)) {
        manager?.addToFavourites(picture: picture) { isSuccess in
            completion(isSuccess)
        }
    }
    
    func removeFromFavourite(picture: PictureModel, completion: @escaping((Bool) -> Void)) {
        manager?.removeFromFavourites(picture: picture) { isSuccess in
            completion(isSuccess)
        }
    }
    
    
}
