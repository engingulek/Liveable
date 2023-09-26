//
//  ExploreService.swift
//  Liveable
//
//  Created by engin gülek on 26.09.2023.
//

import Foundation

protocol ExploreServiceProtocol{
    func fetchAdverts() async -> Result<[Advert]?,Error>
}

final class ExploreService : ExploreServiceProtocol {
    
    let networkManager: NetworkManagerProtocol
    static let shared = ExploreService()
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchAdverts() async -> Result<[Advert]?, Error> {
        let response = await networkManager.fetch(target: .adverts, responseClass: [Advert].self)
        return response
        
    }
    
   
    
    
}
