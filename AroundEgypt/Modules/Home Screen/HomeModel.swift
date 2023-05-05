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
    let data: [Datum]?
    let pagination: Pagination?
    
    
    // MARK: - Datum
    struct Datum: Codable {
        let id, title: String?
        let coverPhoto: String?
        let description: String?
        let viewsNo, likesNo, recommended, hasVideo: Int?
        let tags: [City]?
        let city: City?
        let tourHTML: String?
        let famousFigure: String?
        let detailedDescription: String?
        let address: String?
        let isLiked: Bool?
        let reviews: [Review]?
        let rating, reviewsNo: Int?
        let hasAudio: Bool?
        
        enum CodingKeys: String, CodingKey {
            case id, title
            case coverPhoto = "cover_photo"
            case description
            case viewsNo = "views_no"
            case likesNo = "likes_no"
            case recommended
            case hasVideo = "has_video"
            case tags, city
            case tourHTML = "tour_html"
            case famousFigure = "famous_figure"
            case detailedDescription = "detailed_description"
            case address
            case isLiked = "is_liked"
            case reviews, rating
            case reviewsNo = "reviews_no"
            case hasAudio = "has_audio"
        }
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
    
    
    // MARK: - Review
    struct Review: Codable {
        let id, experience, name: String?
        let rating: Int?
        let comment, createdAt: String?
        
        enum CodingKeys: String, CodingKey {
            case id, experience, name, rating, comment
            case createdAt = "created_at"
        }
    }
    
    
    
    
    // MARK: - Meta
    struct Meta: Codable {
        let code: Int?
        let errors: [Error]?
        let exception: String?
    }
    
    // MARK: - Error
    struct Error: Codable {
        let type, message: String?
    }
    
    
    // MARK: - Pagination
    struct Pagination: Codable {
    }
    
}
