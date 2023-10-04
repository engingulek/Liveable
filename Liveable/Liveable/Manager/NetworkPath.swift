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
        }
    }
    
    var method: AlamofireMethod {
        switch self {
        case .adverts:
            return .get
        case .categories:
            return .get
        case .categoryFilter:
            return .get
        
        case .userInfo:
            return .get
        case .advertComment:
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


