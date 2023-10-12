//
//  SearchResultService.swift
//  Liveable
//
//  Created by engin gülek on 5.10.2023.
//

import Foundation

protocol SearchResultServiceProtocol {
    func searchByCountry(text:String,completion:@escaping(Result<AdvertDic,Error>)->())
    func searchByCity(text:String,completion:@escaping(Result<AdvertDic,Error>)->())
}

final class SearchResultService :  SearchResultServiceProtocol {
    
    let networkManager: NetworkManagerProtocol
    static let shared =  SearchResultService()
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func searchByCountry(text: String, completion: @escaping (Result<AdvertDic, Error>) -> ()) {
        networkManager.fetch(target: .searchAdvertByCountry(text), responseClass: AdvertDic.self) { response in
            switch response {
            case .success(let dic):
                
                completion(.success(dic ?? [:]))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func searchByCity(text: String, completion: @escaping (Result<AdvertDic, Error>) -> ()) {
        networkManager.fetch(target: .searchAdvertByCity(text), responseClass: AdvertDic.self) { response in
            switch response {
            case .success(let dic):
                completion(.success(dic ?? [:]))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    
}