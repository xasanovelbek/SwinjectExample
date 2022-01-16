//
//  FavouritesViewModel.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 12/01/22.
//

import Foundation
protocol FavouritesViewModelProtocol: BaseViewModel {
    var isLoading: Bool { get set}
    var error: String? { get set }
    var favourites: [PictureModel] { get set }
    var repository : FavouritesRepositoryProtocol? { get set }
    
    func removeFavouritePicture(picture: PictureModel)
    func addToFavouritePicture(picture: PictureModel)
    func loadFavourites()
}

class FavouritesViewModel: ObservableObject, FavouritesViewModelProtocol {
    
    static let shared = FavouritesViewModel()
    
    @Published var isLoading: Bool = false
    
    @Published var error: String?
    
    @Published var favourites: [PictureModel] = [PictureModel]()
    
    var repository: FavouritesRepositoryProtocol?
    

    func removeFavouritePicture(picture: PictureModel) {
        repository?.removeFromFavourite(picture: picture) { [weak self] isSuccess in
            DispatchQueue.main.async {
                if isSuccess {
                    self?.loadFavourites()
                } else {
                    self?.isLoading = false
                    self?.error = "Removing error"
                }
            }
        }
    }
    
    func addToFavouritePicture(picture: PictureModel) {
        repository?.addToFavourite(picture: picture) { [weak self] isSuccess in
            DispatchQueue.main.async {
                if isSuccess {
                    self?.loadFavourites()
                } else {
                    self?.isLoading = false
                    self?.error = "Adding error"
                }
            }
        }
    }
    
    func loadFavourites() {
        repository?.getPictures { [weak self] (baseResponse: BaseResponse<[PictureModel]>) in
            
            guard let self = self else { return }
            switch baseResponse.status {
            case .success:
                self.favourites = baseResponse.response ?? []
                self.isLoading = false
                return
            case .fail:
                self.error = baseResponse.error
                self.isLoading = false
                return
            case .loading:
                self.isLoading = true
                return
            }
        }
    }
}
    
