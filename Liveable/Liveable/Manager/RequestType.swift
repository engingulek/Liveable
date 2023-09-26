//
//  RequesrType.swift
//  Liveable
//
//  Created by engin gülek on 26.09.2023.
//

import Foundation
import Alamofire


enum AlamofireMethod: String {
    case get = "GET"
}

enum RequestType {
    case requestPlain
}

protocol TargetType {
    var path: String {get}
    
    var method: AlamofireMethod {get}
    
    var requestType: RequestType {get}
    
    var headers: [String: String]? {get}
}


