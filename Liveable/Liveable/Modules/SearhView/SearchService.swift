//
//  SearchService.swift
//  Liveable
//
//  Created by engin gülek on 5.10.2023.
//

import Foundation

protocol SearchServiceProtocol {
    func fetchCityList(completion:@escaping(Result<City,Error>)->())
    func fetchMapCountryList(completion:@escaping(Result<MapCountry,Error>)->())
}


final class SearchService : SearchServiceProtocol {
    
    let networkManager: NetworkManagerProtocol
    static let shared = SearchService()
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    
    
    func fetchCityList(completion: @escaping (Result<City, Error>) -> ()) {
        networkManager.fetch(target: .cityList, responseClass: City.self) { response in
            switch response {
            case .success(let list):
                completion(.success(list ?? []))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func fetchMapCountryList( completion: @escaping (Result<MapCountry, Error>) -> ()) {
        networkManager.fetch(target: .mapCountryList, responseClass: MapCountry.self) { response in
            switch response {
            case .success(let list):
                completion(.success(list ?? []))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    
}
