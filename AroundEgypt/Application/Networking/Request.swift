//
//  Request.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import Combine
import Foundation

struct Request {
    static let baseURL = "aroundegypt.34ml.com"
    
    var headers: [String: String]?
    
    let url: URL
    var request: URLRequest? {
        return URLRequest(url: url)
    }
    
    //MARK:  EndPoint
    enum EndPoint {
        case experiences
        case singleExperience(String)
        case likeExperience(String)
        
        var endPoint: String {
            switch self {
            case .experiences:
                return "/api/v2/experiences"
            case .singleExperience(let id):
                return "/api/v2/experiences/\(id)"
            case .likeExperience(let id):
                return "/api/v2/experiences/\(id)/like"
            }
        }
    }
    
    //MARK: Methods
    enum Methods: String {
        case get = "GET"
        case post = "POST"
    }
    


    init(url: URL) {
        self.url = url
    }
}





extension Request {
    static func experiencesRequest() -> Request {
        let url = URL(string: self.baseURL + EndPoint.experiences.endPoint)!
        return Request(url: url)
    }
    
    static func singleExperienceRequest(with id: String) -> Request {
        let url = URL(string: self.baseURL + EndPoint.singleExperience(id).endPoint)!
        return Request(url: url)
    }
    
    static func likeExperienceRequest(with id: String) -> Request {
        let url = URL(string: self.baseURL + EndPoint.likeExperience(id).endPoint)!
        return Request(url: url)
    }
}
