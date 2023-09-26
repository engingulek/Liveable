//
//  NetworkManager.swift
//  Liveable
//
//  Created by engin gülek on 26.09.2023.
//

import Foundation
import Alamofire

enum CustomError : Error{
    case networkError
}

struct NetworkConfig {
    let baseUrl : String
    let auth :String
}

protocol NetworkManagerProtocol {
    var config : NetworkConfig {get set}
    func fetch<T:Decodable>(target:NetworkPath,responseClass:T.Type) async -> Result<T?,Error>
}

final class NetworkManager : NetworkManagerProtocol {
    var config: NetworkConfig
    init(config: NetworkConfig) {
        self.config = config
    }
    
    static let shared : NetworkManagerProtocol = NetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseUrl,auth: NetworkPath.auth))
    
    func fetch<T:Decodable>(target: NetworkPath, responseClass: T.Type) async -> Result<T?, Error> {
        let url = "\(config.baseUrl)\(target.path)?auth=\(config.auth)"
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
                let parameters = buildParams(requestType: target.requestType)
        let request = AF.request(url,method: method,parameters: parameters.0,encoding: parameters.1,headers: headers)
            .validate()
            .serializingDecodable(T.self)
        let result = await request.response
        guard let value = result.value else {
            return .failure(result.error ?? CustomError.networkError)
        }
        
        return .success(value)
    }
    
    private func buildParams(requestType: RequestType) -> ([String: Any], ParameterEncoding) {
            switch requestType {
            case .requestPlain:
                return ([:], URLEncoding.default)
            }
        }
}
