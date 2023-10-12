//
//  SavedService.swift
//  Liveable
//
//  Created by engin gülek on 12.10.2023.
//

import Foundation

protocol SavedServiceProtocol {
    func fetchSavedList(userId:String,completion:@escaping (Result<AdvertDic?,Error>)->())
    func deleteAdvertFromSavedList(userId:String,key:String,completion: @escaping (Result<Welcome?, Error>) -> ())
}


final class SavedService  :SavedServiceProtocol {
    
    
    
    let networkManager: NetworkManagerProtocol
    static let shared = SavedService()
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchSavedList(userId: String, completion: @escaping (Result<AdvertDic?, Error>) -> ()) {
        networkManager.fetch(target: .savedList(userId), responseClass: AdvertDic.self) { response in
            switch response {
            case .success(let dic):
                completion(.success(dic ?? [:]))
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
