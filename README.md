# SwinjectExample
In this project I chose MVVM architectural pattern. 
Also I used "Swinject" framework for control my dependencies. 
For binding datas, apples own framework  "Combine"  was chosen.
For networking process I decided to use simple "URLSession" API.
I download images from URL by using "Kingfisher" pod.


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
