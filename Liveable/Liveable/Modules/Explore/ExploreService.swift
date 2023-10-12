//
//  ExploreService.swift
//  Liveable
//
//  Created by engin gülek on 26.09.2023.
//

import Foundation
import Alamofire






protocol ExploreServiceProtocol{
    func fetchAdverts(completion:@escaping (Result<[Advert]?,Error>)  -> ())
    func fetchCategory(completion:@escaping (Result<[Category]?,Error>)  -> ())
    func fetchAdvertFilter(categoryId id:Int,completion:@escaping(Result<[Advert]?,Error>) -> ())
    
}

final class ExploreService : ExploreServiceProtocol {

    let networkManager: NetworkManagerProtocol
    static let shared = ExploreService()
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchAdverts(completion: @escaping (Result<[Advert]?, Error>) -> ()) {
        networkManager.fetch(target: .adverts, responseClass: [Advert]?.self) { response in
            switch response {
            case .success(let list):
                
                completion(.success(list ?? []))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    
    func fetchCategory(completion: @escaping (Result<[Category]?, Error>) -> ()) {
        networkManager.fetch(target: .categories, responseClass: [Category]?.self) { response in
            switch response {
            case .success(let list):
                completion(.success(list ?? []))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func fetchAdvertFilter(categoryId id : Int,completion:@escaping(Result<[Advert]?,Error>) -> ())  {
   
   
        networkManager.fetch(target: .categoryFilter(id), responseClass: AdvertDic.self) { response in
            switch response {
            case .success(let list):
                var filterList : [Advert] = []
                /// The data does come in dic type. Convert to Array
                list?.forEach{ (key: String, value: Advert) in
                    filterList.append(value)
                }
                completion(.success(filterList))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}

