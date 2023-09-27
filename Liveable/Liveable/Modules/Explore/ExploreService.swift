//
//  ExploreService.swift
//  Liveable
//
//  Created by engin gülek on 26.09.2023.
//

import Foundation



protocol ExploreServiceProtocol{
    func fetchAdverts(completion:@escaping (Result<[Advert]?,Error>)  -> ())
}

final class ExploreService : ExploreServiceProtocol {
    func fetchAdverts(completion: @escaping (Result<[Advert]?, Error>) -> ()) {
        networkManager.fetch(target: .adverts, responseClass: [Advert].self) { response in
            switch response {
            case .success(let list):
                completion(.success(list ?? []))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
       // let response = await networkManager.fetch(target: .adverts, responseClass: [Advert].self)
        
    }
    
    
    let networkManager: NetworkManagerProtocol
    static let shared = ExploreService()
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
   
    
   
    
    
}
