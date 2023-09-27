//
//  MockExploreService.swift
//  LiveableTests
//
//  Created by engin gülek on 27.09.2023.
//

import Foundation
@testable import Liveable

final class MockExploreService : ExploreServiceProtocol {
    var mockFetchAdvert : Result<[Advert]?,Error>?
    
    func fetchAdverts(completion: @escaping (Result<[Liveable.Advert]?, Error>) -> ()) {
        
        if let result = mockFetchAdvert {
            completion(result)
        }
    }
    
    
    
    
}
