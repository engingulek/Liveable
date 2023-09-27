//
//  Advert.swift
//  Liveable
//
//  Created by engin gülek on 26.09.2023.
//

import Foundation

// MARK: - Advert
struct Advert: Decodable {
    let baseImageURL: String
    let category, decription: String
    let id: Int
    let images: [String]
    let location: Location
    let price: Int
    let rating: Double
    let roomCount: RoomCount
    let title: String
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case baseImageURL = "baseImageUrl"
        case category, decription, id, images, location, price, rating, roomCount, title
        case userID = "userId"
    }
    
    static let advertExample = Advert(baseImageURL: "https://a0.muscache.com/im/pictures/miso/Hosting-926080375184805181/original/61878729-c683-4983-bde9-d1922d9a75bf.jpeg?im_w=1200", category: "shacks", decription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley ", id: 0, images: ["https://a0.muscache.com/im/pictures/miso/Hosting-926080375184805181/original/61878729-c683-4983-bde9-d1922d9a75bf.jpeg?im_w=1200","https://a0.muscache.com/im/pictures/miso/Hosting-926080375184805181/original/61878729-c683-4983-bde9-d1922d9a75bf.jpeg?im_w=1200"], location: Location(city: "İstanbul", country: "Türkey", latitude: "12.000", longitude: "12.000"), price: 300, rating: 2.5, roomCount: RoomCount(bath: 1, bed: 1, bedroom: 1, guest: 1), title: "Title House", userID: 0)
}

// MARK: - Location
struct Location: Codable {
    let city, country, latitude, longitude: String
}

// MARK: - RoomCount
struct RoomCount: Codable {
    let bath, bed, bedroom, guest: Int
}

