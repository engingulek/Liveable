//
//  UserInfo.swift
//  Liveable
//
//  Created by engin gülek on 3.10.2023.
//

import Foundation

typealias User = [String:UserInfo]

struct UserInfo: Codable {
    let id: Int
    let imageURL: String
    let nameSurname: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
        case nameSurname
    }
    static let defaultUserInfo = UserInfo(id: -1, imageURL: "", nameSurname: "Name Surname")
}

