//
//  Advert.swift
//  Liveable
//
//  Created by engin gülek on 26.09.2023.
//

import Foundation

// MARK: - Advert
struct Advert: Codable {
    let baseImageURL: String
    let category : Int
    let decription: String
    let id: Int
    let images: [String]
    let location: Location
    let price: Price
    let rating: Double
    let roomCount: RoomCount
    let title: String
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case baseImageURL = "baseImageUrl"
        case category, decription, id, images, location, price, rating, roomCount, title
        case userID = "userId"
    }
    
    var asDictionary : [String:Any] {
       let mirror = Mirror(reflecting: self)
       let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
         guard let label = label else { return nil }
         return (label, value)
       }).compactMap { $0 })
       return dict
     }
    
    static let advertExample = Advert(baseImageURL: "https://a0.muscache.com/im/pictures/miso/Hosting-926080375184805181/original/61878729-c683-4983-bde9-d1922d9a75bf.jpeg?im_w=1200", category: 1, decription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley ", id: 0, images: ["https://a0.muscache.com/im/pictures/miso/Hosting-926080375184805181/original/61878729-c683-4983-bde9-d1922d9a75bf.jpeg?im_w=1200","https://a0.muscache.com/im/pictures/miso/Hosting-926080375184805181/original/61878729-c683-4983-bde9-d1922d9a75bf.jpeg?im_w=1200"], location: Location(city: "İstanbul", country: "Türkey", latitude: "12.000", longitude: "12.000"), price: Price(adult: 300, kid: 200, baby: 100), rating: 2.5, roomCount: RoomCount(bath: 1, bed: 1, bedroom: 1, guest: 1), title: "Title House", userID: 0)
}

// MARK: - Location
struct Location: Codable {
    let city, country, latitude, longitude: String
    

}

// MARK: - RoomCount
struct RoomCount: Codable {
    let bath, bed, bedroom, guest: Int
}

struct Price : Codable {
    let  adult,kid,baby : Int
    static let pricesExample : [Price] = [.init(adult: 1, kid: 0, baby: 0)]
}

typealias AdvertDic = [String: Advert]
