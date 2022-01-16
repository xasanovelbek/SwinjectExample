# SwinjectExample
In this project I chose MVVM architectural pattern. 
Also I used "Swinject" framework for control my dependencies. 
For binding datas, apples own framework  "Combine"  was chosen.
For networking process I decided to use simple "URLSession" API.
I download images from URL by using "Kingfisher" pod.


I made extension from Assebmler and using singleton pattern created all dependencies. Such as View, ViewModel, Repository, Manager dependencies.

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
