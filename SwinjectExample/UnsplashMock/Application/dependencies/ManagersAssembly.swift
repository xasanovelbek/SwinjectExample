//
//  NetworkAssembly.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 12/01/22.
//

import Foundation
import Swinject
class ManagersAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkManagerProtocol.self) { r in
            return NetworkManager.shared
        }
        
        container.register(DBManagerProtocol.self) { r in
            return DBManager.shared
        }
    }
}
