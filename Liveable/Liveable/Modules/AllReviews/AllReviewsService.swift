//
//  AllReviewsService.swift
//  Liveable
//
//  Created by engin gülek on 4.10.2023.
//

import Foundation
import Alamofire
protocol AllReviewServiceProtocol {
    func fetchAllComment(advertId id : Int,completion:@escaping(Result<Comment?,Error>)->())
}


final class AllReviewService : AllReviewServiceProtocol  {
  
   static  let shared = AllReviewService()
   private let networkManager: NetworkManagerProtocol
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
   
    func fetchAllComment(advertId id : Int,completion: @escaping (Result<Comment?, Error>) -> ()) {
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
