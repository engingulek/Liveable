
import Foundation
@testable import Liveable
final class MockSearchResultService : SearchResultServiceProtocol {
    var mockSearchByCountry : Result<Liveable.AdvertDic, Error>?
    var mockSearchByCity : Result<Liveable.AdvertDic, Error>?
    
    
    func searchByCountry(text: String, completion: @escaping (Result<Liveable.AdvertDic, Error>) -> ()) {
        if let result = mockSearchByCountry {
            completion(result)
        }
    }
    
    func searchByCity(text: String, completion: @escaping (Result<Liveable.AdvertDic, Error>) -> ()) {
        if let result = mockSearchByCity {
            completion(result)
        }
    }
    
    
}
