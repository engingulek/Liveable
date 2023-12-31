
import Foundation
import Alamofire

enum CustomError : Error{
    case networkError
    case defaultError
    case nilError
}

struct NetworkConfig {
    let baseUrl : String

}

protocol NetworkManagerProtocol {
    var config : NetworkConfig {get set}
    func fetch<T:Codable>(target:NetworkPath,responseClass:T.Type,completion:@escaping (Result<T?,Error>) -> ())
}

final class NetworkManager : NetworkManagerProtocol {
    var config: NetworkConfig
    init(config: NetworkConfig) {
        self.config = config
    }
    
    static let shared : NetworkManagerProtocol = NetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseUrl))
    
    func fetch<T:Codable>(target:NetworkPath,responseClass:T.Type,completion:@escaping (Result<T?,Error>) -> ())  {
        let url = "\(config.baseUrl)\(target.path)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let parameters = buildParams(requestType: target.requestType)

        
      
       
        AF.request(url!,method: method,parameters: parameters.0  ,encoding: parameters.1,headers: headers)
            .response{ response in
                
               
                if let data = response.data {
              
                    do {
                        let result = try JSONDecoder().decode(responseClass, from: data )
                      
                        completion(.success(result))
                    }catch{
                        print(error.localizedDescription)
                        if let statusCode = response.response?.statusCode {
                            print(statusCode)
                            if statusCode == 404{
                                completion(.failure(CustomError.networkError))
                            }
                            else if statusCode == 200 {
                                completion(.failure(CustomError.nilError))
                            }
                            else {
                                completion(.failure(CustomError.defaultError))
                            }
                        }
                    }
                }
                
            }
    }
    
    private func buildParams(requestType: RequestType) -> ([String:Any], ParameterEncoding) {
            switch requestType {
            case .requestPlain:
                return ([:], URLEncoding.default)
            case .requestParameters(parameters: let parameters, encoding: let encoding):
                return (parameters, encoding)
            }
        }
}
