

import Foundation

import Foundation

// MARK: - CityElement
struct CityElement: Codable {
    let id: Int
    let title: String
}

typealias City = [CityElement]


// MARK: - MapCountryElement
struct MapCountryElement: Codable {
    let id: Int
    let imageURL: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
        case title
    }
}

typealias MapCountry = [MapCountryElement]
