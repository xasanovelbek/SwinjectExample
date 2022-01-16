//
//  DBManager.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 12/01/22.
//

import UIKit
import CoreData
protocol DBManagerProtocol {
    func addToFavourites(picture: PictureModel, completed: @escaping((Bool) -> Void))
    func removeFromFavourites(picture: PictureModel, completed: @escaping((Bool) -> Void))
    func getFavourites(completed: @escaping((BaseResponse<[PictureModel]>) -> Void))
}
class DBManager: DBManagerProtocol {
    
    static let shared = DBManager()
    
    private var context: NSManagedObjectContext? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
    
    
    
    func addToFavourites(picture: PictureModel, completed: @escaping((Bool) -> Void)) {
        guard let context = context else { completed(false); return }

            do {
                if getPictureEntity(picture: picture) == nil {
                    guard let pictureData = try? JSONEncoder().encode(picture) else { completed(false); return }
                    let entity = PictureEntity(context: context)
                    entity.picture = pictureData
                    entity.id = picture.id
                    try context.save()
                    completed(true)
                } else {
                    completed(false)
                }
            } catch {
                completed(false)
            }
        
    }
    
    func removeFromFavourites(picture: PictureModel, completed: @escaping((Bool) -> Void)) {
        guard let context = context else { completed(false); return }

            do {
                if let entity = getPictureEntity(picture: picture) {
                    context.delete(entity)
                } else {
                    completed(false)
                }
                try context.save()
                completed(true)
            } catch {
                completed(false)
            }
        
    }
 
    func getFavourites(completed: @escaping((BaseResponse<[PictureModel]>) -> Void)) {
        var baseResponse = BaseResponse<[PictureModel]>(status: .loading, error: nil, response: nil)
        guard let context = context else {
            baseResponse.status = .fail
            baseResponse.error = "Favourites error"
            completed(baseResponse)
            return
        }
            do {
                let picturesEntity: [PictureEntity] = try context.fetch(PictureEntity.fetchRequest())
                var pictures = [PictureModel]()
                for entity in picturesEntity {
                    if let data = entity.picture {
                        let model = try JSONDecoder().decode(PictureModel.self, from: data)
                        pictures.append(model)
                        
                    }
                }
                baseResponse.status = .success
                baseResponse.response = pictures
                completed(baseResponse)
            } catch {
                
                baseResponse.status = .fail
                baseResponse.error = "Favourites fetch error"
                completed(baseResponse)
            }
        
    }
    
    private func getPictureEntity(picture: PictureModel) -> PictureEntity? {
        guard let context = context else { return nil }
        do {
            let pictures = try context.fetch(PictureEntity.fetchRequest())
            
            return pictures.first(where: { ($0.id ?? "-1") == (picture.id ?? "-2") })
        } catch {
            return nil
        }
    }
    

    
}
