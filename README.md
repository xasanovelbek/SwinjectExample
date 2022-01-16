# SwinjectExample
In this project I chose MVVM architectural pattern in order to design applications structure.
Also I used "Swinject" framework for control my dependencies. 
For binding datas, apples own framework  "Combine"  was chosen.
For networking process I decided to use simple "URLSession" API.
I download images from URL by using "Kingfisher" pod.
Local database was created by using "CoreData".




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


For resolving viewcontroller from container you have to call like this:

    guard let vc = Assembler.sharedAssembler.resolver.resolve(PictureDatasVC.self, 
                                                              argument: self.pictures[indexPath.row]) else { return }
    self.navigationController?.pushViewController(vc, animated: true)
             
As you can see we are sending our data to "argument:". This data will be injected to second viewcontroller.

    class ViewAssembly: Assembly {
        func assemble(container: Container) {
            container.register(PictureDatasVC.self) { (r, data: PictureModel) in
                let vc = PictureDatasVC()
                vc.pictureModel = data
                return vc
            }
            ...
        }
    }
    
             
             
