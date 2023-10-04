//
//  AdvertDetailService.swift
//  Liveable
//
//  Created by engin gülek on 3.10.2023.
//

import Foundation

protocol AdvertDetailViewServiceProtocol {
    func fetchUserInfo(userId id :Int,completion:@escaping(Result<UserInfo,Error>)->())
    func fetchAllComment(advertId id : Int,completion:@escaping(Result<Comment?,Error>)->())
}


final class AdvertDetailViewService : AdvertDetailViewServiceProtocol {
    
    
    let networkManager: NetworkManagerProtocol
    static let shared = AdvertDetailViewService()
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    
    func fetchUserInfo(userId id :Int ,completion: @escaping (Result<UserInfo, Error>) -> ()) {
        networkManager.fetch(target: .userInfo(id), responseClass: User.self) { response in
            switch response {
            case .success(let dic):
                
                guard let user = dic else {return}
                print(user)
                completion(.success(user["\(id)"] ?? UserInfo.defaultUserInfo))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    
    func fetchAllComment(advertId id: Int, completion: @escaping (Result<Comment?, Error>) -> ()) {
        networkManager.fetch(target: .advertComment(id), responseClass: Comment.self) { response in
            switch response {
            case .success(let dic):
                completion(.success(dic ?? [:]))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    
}
