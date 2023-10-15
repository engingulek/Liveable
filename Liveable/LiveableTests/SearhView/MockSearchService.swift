
import Foundation
@testable import Liveable

final class MockSearchService :  SearchServiceProtocol {
    var mockFetchCityList : Result<City,Error>?
    var mockFetchMapCountryList :  Result <MapCountry,Error>?
    func fetchCityList(completion: @escaping (Result<Liveable.City, Error>) -> ()) {
        
        if let result = mockFetchCityList {
            completion(result)
        }
        
    }
    
    func fetchMapCountryList(completion: @escaping (Result<Liveable.MapCountry, Error>) -> ()) {
        if let result = mockFetchMapCountryList {
            completion(result)
        }
    }
    
    
}
