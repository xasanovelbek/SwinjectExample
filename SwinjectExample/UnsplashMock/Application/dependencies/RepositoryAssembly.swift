//
//  RepositoryAssembly.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 12/01/22.
//

import Foundation
import Swinject
class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PicturesRepositoryProtocol.self) { r in
            let repository = PicturesRepository()
            repository.manager = r.resolve(NetworkManagerProtocol.self)
            return repository
        }
        
        container.register(FavouritesRepositoryProtocol.self) { r in
            let repository = FavouritesRepository()
            repository.manager = r.resolve(DBManagerProtocol.self)
            return repository
        }
    }
}
