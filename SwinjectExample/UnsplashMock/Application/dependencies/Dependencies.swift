
import Foundation
import Swinject
import SwinjectStoryboard

extension Assembler {
    static let sharedAssembler: Assembler = {
        let assembler = Assembler(
            [
                ViewAssembly(),
                ViewModelAssembly(),
                RepositoryAssembly(),
                ManagersAssembly()
                
            ],
            container: Container())
        return assembler
    }()
}
