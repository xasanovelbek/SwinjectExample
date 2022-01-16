//
//  ViewAssembly.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 12/01/22.
//

import Foundation
import Swinject
class ViewAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(PicturesVC.self) { r in
            let vc = PicturesVC()
            
            vc.picturesViewModel = r.resolve(PicturesViewModel.self)
            return vc
        }
        
        container.register(FavouritesVC.self) { r in
            let vc = FavouritesVC()
            vc.favouritesViewModel = r.resolve(FavouritesViewModel.self)
            return vc
        }
        
        container.register(BaseTabBarController.self) { r in
            let tabbarcontroller = BaseTabBarController()
            return tabbarcontroller
        }

    }
}
