
import Foundation

protocol PicturesRepositoryProtocol {
    func getPictures(_ page: Int, completion: @escaping((BaseResponse<[PictureModel]>) -> Void))
    func searchPictures(_ page: Int, q: String,completion: @escaping((BaseResponse<SearchResultModel>) -> Void))
    
    var manager: NetworkManagerProtocol? { get set }
}
class PicturesRepository: PicturesRepositoryProtocol {
    
    var manager: NetworkManagerProtocol?
    
    func getPictures(_ page: Int, completion: @escaping((BaseResponse<[PictureModel]>) -> Void)) {
        manager?.network(endpoint: .loadPictures(page: page), header: .simpleHeader) { (baseResponse: BaseResponse<[PictureModel]>) in
            completion(baseResponse)
        }
    }
    
    func searchPictures(_ page: Int, q: String,completion: @escaping((BaseResponse<SearchResultModel>) -> Void)) {
        manager?.cancelCurrentTask()
        manager?.network(endpoint: .search(page: page, q: q), header: .simpleHeader) { (baseResponse: BaseResponse<SearchResultModel>) in
            completion(baseResponse)
        }
    }
}
