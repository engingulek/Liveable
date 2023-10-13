//
//  AdvertDetailService.swift
//  Liveable
//
//  Created by engin gülek on 3.10.2023.
//

import Foundation
import Alamofire

// MARK: - Welcome
struct Welcome: Codable {
    let name: String
}

protocol AdvertDetailViewServiceProtocol {
    func fetchUserInfo(userId id :Int,completion:@escaping(Result<UserInfo,Error>)->())
    func fetchAllComment(advertId id : Int,completion:@escaping(Result<Comment?,Error>)->())
    func fetchSavedList(userId:String,completion:@escaping (Result<AdvertDic,Error>)->())
    
    func addAdvertToSavedList(advert:Parameters,userId:String,completion: @escaping (Result<Welcome?, Error>) -> ())
    func deleteAdvertFromSavedList(userId:String,key:String,completion: @escaping (Result<Welcome?, Error>) -> ())
    
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
    
    func fetchSavedList(userId: String, completion: @escaping (Result<AdvertDic, Error>) -> ()) {
        networkManager.fetch(target: .savedList(userId), responseClass: AdvertDic.self) { response in
            switch response {
            case .success(let dic):
                completion(.success(dic ?? [:]))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    func addAdvertToSavedList(advert:Parameters,userId:String,completion: @escaping (Result<Welcome?, Error>) -> ()) {
         networkManager.fetch(target: .addAdvertToSavedList(userId,advert), responseClass: Welcome.self) { response in
             switch response {
             case .success(let success):
                 completion(.success(success))
             case .failure(let failure):
                 completion(.failure(failure))
             }
         }
     }
    
    func deleteAdvertFromSavedList(userId: String, key: String,completion: @escaping (Result<Welcome?, Error>) -> ()) {
        networkManager.fetch(target: .deleteAdvertFromSavedList(userId, key), responseClass: Welcome.self) { response in
            switch response {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
            
        }
    }
}
