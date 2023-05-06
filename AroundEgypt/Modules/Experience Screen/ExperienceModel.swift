//
//  ExperienceModel.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 05/05/2023.
//

import Foundation

// MARK: - ExperienceModel
struct ExperienceModel: Codable {
    let meta: Meta?
    let data: dataType?
    let pagination: Pagination?
    
    enum CodingKeys: String, CodingKey {
        case meta, data, pagination
    }
    
    enum dataType: Codable{
        case int(Int)
        case experienceDetails(ExperienceDetailsModel)
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let experienceDetailsDecoded = try? container.decode(ExperienceDetailsModel.self) {
                self = .experienceDetails(experienceDetailsDecoded)
                return
            }
            
            if let intDecoded = try? container.decode(Int.self) {
                self = .int(intDecoded)
                return
            }
            throw DecodingError.typeMismatch(dataType.self, DecodingError.Context(codingPath: decoder.codingPath,
                                                                                  debugDescription: "Wrong type for dataType"))
            
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .int(let value):
                try container.encode(value)
            case .experienceDetails(let value):
                try container.encode(value)
            }
        }
    }
    
    
}
