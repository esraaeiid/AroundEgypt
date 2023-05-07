//
//  ExperienceStore.swift
//  AroundEgypt
//
//  Created by Esraa Eid on 07/05/2023.
//

import Foundation
import UIKit
import Combine


final class ExperienceStore {
    @Published var recentExperiencesList: [ExperienceDetailsModel] = []
    @Published var recommendedExperiencesList: [ExperienceDetailsModel] = []
    
   
    private static func fileURL(name: String) throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("\(name).json")
    }
    
    //TODO: should delete old file if exist
    static func delete(){
       
    }
    
    static func loadRecentExperience(completion: @escaping (Result<[ExperienceDetailsModel], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL(name: "RecentExperience")
                print("FileURL✅", fileURL)
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let savedExperiences = try JSONDecoder().decode([ExperienceDetailsModel].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(savedExperiences))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func loadRecommendedExperience(completion: @escaping (Result<[ExperienceDetailsModel], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL(name: "RecommendedExperience")
                print("FileURL✅", fileURL)
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let savedExperiences = try JSONDecoder().decode([ExperienceDetailsModel].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(savedExperiences))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(recentExperiences: [ExperienceDetailsModel], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(recentExperiences)
                let outfile = try fileURL(name: "RecentExperience")
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(recentExperiences.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(recommendedExperiences: [ExperienceDetailsModel], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(recommendedExperiences)
                let outfile = try fileURL(name: "RecommendedExperience")
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(recommendedExperiences.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
