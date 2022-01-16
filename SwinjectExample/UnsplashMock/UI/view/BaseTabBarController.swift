

import UIKit
import Swinject
class BaseTabBarController: UITabBarController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    
    
    private func configureTabBar() {
        
        guard let pictureVC = Assembler.sharedAssembler.resolver.resolve(PicturesVC.self) else { return }
        guard let favouritesVC = Assembler.sharedAssembler.resolver.resolve(FavouritesVC.self) else { return }
        
        let picturesItem = UITabBarItem(title: "Pictures",
                                        image: UIImage(systemName: "globe"),
                                        selectedImage: UIImage(systemName: "globe"))
        
        let favouriteItem = UITabBarItem(title: "Favourites",
                                        image: UIImage(systemName: "heart"),
                                        selectedImage: UIImage(systemName: "heart"))
        self.tabBar.tintColor = .red
        
        pictureVC.tabBarItem = picturesItem
        
        
        favouritesVC.tabBarItem = favouriteItem
        
        self.tabBar.backgroundColor = .white
        
        let firstTabBarNavController = UINavigationController(rootViewController: pictureVC)
        firstTabBarNavController.navigationBar.isTranslucent = false
        let secondTabBarNavController = UINavigationController(rootViewController: favouritesVC)
        secondTabBarNavController.navigationBar.isTranslucent = false
        self.setViewControllers([firstTabBarNavController, secondTabBarNavController], animated: true)
    }
    
    
    
}

