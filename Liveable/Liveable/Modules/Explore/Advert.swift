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
}

// MARK: - Location
struct Location: Codable {
    let city, country, latitude, longitude: String
}

// MARK: - RoomCount
struct RoomCount: Codable {
    let bath, bed, bedroom, guest: Int
}

