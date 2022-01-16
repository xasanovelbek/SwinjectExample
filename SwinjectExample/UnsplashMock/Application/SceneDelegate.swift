//
//  SceneDelegate.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 11/01/22.
//

import UIKit
import Swinject
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var container: Container?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        window?.backgroundColor = ._light_gray
        window?.rootViewController = Assembler.sharedAssembler.resolver.resolve(BaseTabBarController.self)
        
        window?.makeKeyAndVisible()
    }
}
extension SceneDelegate {
    
}
