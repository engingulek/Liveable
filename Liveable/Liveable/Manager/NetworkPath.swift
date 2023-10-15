
import Foundation
import Alamofire
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
    case savedList(String)
    case addAdvertToSavedList(String,Parameters)
    case deleteAdvertFromSavedList(String,String)
    
    static let baseUrl:String = ProductConstants.BASE_URL
  

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
        case .addAdvertToSavedList(let userId,_):
            return "savedList/\(userId).json"
        case .deleteAdvertFromSavedList(let id,let key):
            return "savedList/\(id)/\(key).json"
        case .savedList(let userId):
            return "savedList/\(userId).json"

        }
    }
    
    var method: AlamofireMethod {
        switch self {
        case .addAdvertToSavedList:
            return .post
        case .deleteAdvertFromSavedList:
            return .delete
        default:
            return .get
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .addAdvertToSavedList(_,let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.init())
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


