
import Foundation
import Alamofire


enum AlamofireMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

enum RequestType {
    case requestPlain
    case requestParameters(parameters: Parameters, encoding: ParameterEncoding)
}

protocol TargetType {
    var path: String {get}
    
    var method: AlamofireMethod {get}
    
    var requestType: RequestType {get}
    
    var headers: [String: String]? {get}
}


