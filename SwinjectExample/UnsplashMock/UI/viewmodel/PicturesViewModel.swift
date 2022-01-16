//
//  PicturesViewModel.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 11/01/22.
//

import Foundation
import Combine
protocol PicturesViewModelProtocol: BaseViewModel {
    
    var pictures: [PictureModel] { get set }
    var searchResult: SearchResultModel? { get set }
    var repository: PicturesRepositoryProtocol? { get set }
    
    func getPictures(_ page: Int)
    func searchPictures(_ page: Int, q: String)
    
}
class PicturesViewModel: ObservableObject, PicturesViewModelProtocol {
    
    @Published var pictures: [PictureModel] = [PictureModel]()
    @Published var searchResult: SearchResultModel?
    @Published var isLoading: Bool = false
    @Published var error: String?
    
    
    
    var repository: PicturesRepositoryProtocol?
    
    func getPictures(_ page: Int) {
        repository?.getPictures(page) { [weak self] (baseResponse: BaseResponse<[PictureModel]>) in
            guard let self = self else { return }
            switch baseResponse.status {
            case .success:
                self.pictures = baseResponse.response ?? []
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
    
    func searchPictures(_ page: Int, q: String) {
        repository?.searchPictures(page,
                                  q: q) { [weak self] (baseResponse: BaseResponse<SearchResultModel>) in
            guard let self = self else { return }
            switch baseResponse.status {
            case .success:
                self.searchResult = baseResponse.response
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
