//
//  Request.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import Combine
import Foundation

struct Request {
    static let baseURL = "https://aroundegypt.34ml.com"
    
    var headers: [String: String]?
    var method: String = Methods.get.value
    
    
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
    enum Methods {
        case get
        case post
        
        var value: String {
            switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            }
        }
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
