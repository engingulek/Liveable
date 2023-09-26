//
//  NetworkPath.swift
//  Liveable
//
//  Created by engin gülek on 26.09.2023.
//

import Foundation

enum NetworkPath {
    case adverts
    
    static let baseUrl:String = ProductConstants.BASE_URL
    static let auth : String = ProductConstants.auth
}

extension NetworkPath : TargetType {
   
    
    
    
    var path: String {
        switch self {
        case .adverts:
            return "advertList.json"
        }
    }
    
    var method: AlamofireMethod {
        switch self {
        case .adverts:
            return .get
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .adverts:
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


