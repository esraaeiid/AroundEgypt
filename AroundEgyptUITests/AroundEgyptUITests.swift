//
//  AroundEgyptUITests.swift
//  AroundEgyptUITests
//
//  Created by Esraa Eid on 05/05/2023.
//

import XCTest

final class AroundEgyptUITests: XCTestCase {

    
    func test_should_display_placeHolder_example_on_searchbar(){
        
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let _ = app.otherElements["search"].waitForExistence(timeout: 2.0)
        app.otherElements["search"].tap()
        
        XCTAssertEqual("Try \"Luxor\"", app.otherElements["search"].searchFields.element.placeholderValue)
        
    }
}
