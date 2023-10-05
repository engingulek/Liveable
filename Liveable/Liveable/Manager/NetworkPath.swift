//
//  NetworkPath.swift
//  Liveable
//
//  Created by engin gülek on 26.09.2023.
//

import Foundation

enum NetworkPath {
    case adverts
    case categories
    case categoryFilter(Int)
    case userInfo(Int)
    case advertComment(Int)
    case cityList
    case mapCountryList
    case searchAdvertByCity(String)
    case searchAdvertByCountry(String)
    
    static let baseUrl:String = ProductConstants.BASE_URL
    static let auth : String  = "zR45PQS3lkRWU7TEEJNosjYVadRJ1JSpxpnulT6z"

}

extension NetworkPath : TargetType {
    var path: String {
        switch self {
        case .adverts:
            return "advertList.json"
        case .categories:
            return "categoryList.json"
        case .categoryFilter(let id):
            return "advertList.json?orderBy=\"category\"&equalTo=\(id)"
        case .userInfo(let id):
            return "userList.json?orderBy=\"id\"&equalTo=\(id)"
        case .advertComment(let id):
            return "commentList.json?orderBy=\"advertOwnerId\"&equalTo=\(id)"
        case .cityList:
            return "cityList.json"
        case .mapCountryList:
            return "mapCountryList.json"
        case .searchAdvertByCity(let text):
            return "advertList.json?orderBy=\"location/country\"&equalTo=\"\(text)\""
        case .searchAdvertByCountry(let text):
            return "advertList.json?orderBy=\"location/country\"&equalTo=\"\(text)\""
            
        }
    }
    
    var method: AlamofireMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var requestType: RequestType {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
}


