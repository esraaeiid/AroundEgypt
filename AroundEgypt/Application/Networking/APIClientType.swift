//
//  APIClientType.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import Combine
import Foundation

enum APIError: Error {
    case networkError
    case requestError(String)
    case unknown(String)
    case parameterEncodingError
}

public enum RequestCreationError: LocalizedError {

    case invalidURL(Error? = nil, String? = "Invalid Url")
    case parameterEncodingFailed(Error? = nil, String? = "Encoding Failed")
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL(let underlyingError, let errorMessage):
            return underlyingError?.localizedDescription ?? errorMessage
        case .parameterEncodingFailed(let underlyingError, let errorMessage):
            return underlyingError?.localizedDescription ?? errorMessage
            
        }
    }
}

protocol APIClientType{
    @discardableResult
    func execute<T>(_ request: Request) -> AnyPublisher<Result<T, APIError>, Never> where T: Decodable
}

extension APIClient {
    // consider change this to @published variable
    func checkReachability() -> Bool {
        if Reachability.isConnectedToNetwork() {
            return true
        } else {
            return false
        }
    }
}

class APIClient: APIClientType{
    // MARK: - Function
    
    @discardableResult
    func execute<T>(_ request: Request) -> AnyPublisher<Result<T, APIError>, Never> where T : Decodable {
        guard var requestedURL = request.request
        else {
            return .just(.failure(.networkError))
        }
        
        if !checkReachability() {
           return  .just(.failure(.networkError))
        }
        
        requestedURL.httpMethod = request.method
        
        if let headers = request.headers {
            for (key, value) in headers {
                requestedURL.setValue(key, forHTTPHeaderField: value)
            }
        }
        

        
        if let param = request.param {
            switch request.method {
            case "POST":
                do {
                    requestedURL = try JSONEncoding.default.encode(requestedURL, with: param)
                } catch {
                    return .just(.failure(APIError.parameterEncodingError))
                }
                
            case "GET":
                do {
                    requestedURL = try URLEncoding.default.encode(requestedURL, with: param)
                } catch {
                    return .just(.failure(APIError.parameterEncodingError))
                }
                
            default:
                break
                
            }
        }
    
        return URLSession.shared.dataTaskPublisher(for: requestedURL)
        .map(\.data)
        .decode(type: T.self, decoder: JSONDecoder())
        .map {.success($0)}
     
        .catch ({ error  -> AnyPublisher<Result<T, APIError>, Never> in
            

            switch error as? DecodingError {
            case .typeMismatch(let key, let value):
                return .just(.failure(APIError.requestError("error typeMismatch: \(key), value \(value) and ERROR: \(error.localizedDescription)")))
                
            case .valueNotFound(let key, let value):
                return .just(.failure(APIError.requestError("error valueNotFound: \(key), value \(value) and ERROR: \(error.localizedDescription)")))
                
            case .keyNotFound(let key, let value):
                return .just(.failure(APIError.requestError("error keyNotFound: \(key), value \(value) and ERROR: \(error.localizedDescription)")))
                
            case .dataCorrupted(let key):
                return .just(.failure(APIError.requestError("error dataCorrupted: \(key), and ERROR: \(error.localizedDescription)")))
                
            default:
                return .just(.failure(APIError.unknown("ERROR: \(error.localizedDescription)")))
            }
            
        })
        .eraseToAnyPublisher()
    }
}


extension String {
    var urlEncoded: String? {
        let allowedCharacterSet = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "~-_."))
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
    }
}
