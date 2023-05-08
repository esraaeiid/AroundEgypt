//
//  AroundEgyptTests.swift
//  AroundEgyptTests
//
//  Created by Esraa Eid on 05/05/2023.
//

import XCTest
@testable import AroundEgypt

final class AroundEgyptTests: XCTestCase {

    func test_load_recommendedExperiences_successfully_on_store() {
        
        let store = ExperienceStore()
        let viewModel = HomeViewModel(useCase: HomeUseCase())
        
        XCTAssertEqual(store.recommendedExperiencesList, viewModel.recommendedExperiencesList)
    }
    
    
    func test_load_recentExperiences_successfully_on_store() {
        
        let store = ExperienceStore()
        let viewModel = HomeViewModel(useCase: HomeUseCase())
        
        XCTAssertEqual(store.recentExperiencesList, viewModel.recentExperiencesList)
    }
    

}
