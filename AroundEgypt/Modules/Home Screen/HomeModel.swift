//
//  HomeModel.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import Foundation

// MARK: - HomeModel
struct HomeModel: Codable {
    let meta: Meta?
    let data: [ExperienceDetailsModel]?
    let pagination: Pagination?
    
}

// MARK: - Datum
struct ExperienceDetailsModel: Codable {
    let id, title: String?
    let coverPhoto: String?
    let description: String?
    let viewsNo, likesNo, recommended: Int?
    let city: City?
    let famousFigure: String?
    let detailedDescription: String?
    let address: String?
    let isLiked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case coverPhoto = "cover_photo"
        case description
        case viewsNo = "views_no"
        case likesNo = "likes_no"
        case recommended
        case city
        case famousFigure = "famous_figure"
        case detailedDescription = "detailed_description"
        case address
        case isLiked = "is_liked"
    }
    
    
    // MARK: - City
    struct City: Codable {
        let id: Int?
        let name: String?
        let disable: Bool?
        let topPick: Int?
        
        enum CodingKeys: String, CodingKey {
            case id, name, disable
            case topPick = "top_pick"
        }
    }
    
    
}


// MARK: - Meta
struct Meta: Codable {
    let code: Int?
    let errors: [Error]?
    let exception: String?
    
    // MARK: - Error
    struct Error: Codable {
        let type, message: String?
    }
    
    
}


// MARK: - Pagination
struct Pagination: Codable {
}


