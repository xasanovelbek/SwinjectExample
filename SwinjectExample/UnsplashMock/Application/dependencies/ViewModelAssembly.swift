//
//  ViewModelAssembly.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 12/01/22.
//

import Foundation
import Swinject
class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PicturesViewModel.self) { r in
            let viewModel = PicturesViewModel()
            viewModel.repository = r.resolve(PicturesRepositoryProtocol.self)
            return viewModel
        }
        
        container.register(FavouritesViewModel.self) { r in
            let viewModel = FavouritesViewModel.shared
            viewModel.repository = r.resolve(FavouritesRepositoryProtocol.self)
            return viewModel
        }
    }
}
