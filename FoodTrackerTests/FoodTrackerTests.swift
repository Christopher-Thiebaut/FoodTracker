//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Christopher Thiebaut on 12/2/17.
//  Copyright © 2017 Christopher Thiebaut. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    // MARK: Meal Class Tests
    func testMealInitializationSucceeds(){
        //ZERO RATING
        let zeroRatingMeal = Meal.init(name: "zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        //5-STAR RATING
        let fiveStarMeal = Meal.init(name: "five", photo: nil, rating: 5)
        XCTAssertNotNil(fiveStarMeal)
    }
    
    func testMealInitializationFails(){
        //NEGATIVE RATING
        let negativeRatingMeal = Meal.init(name: "negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        //NO NAME
        let noNameMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(noNameMeal)
        
        //RATING TOO HIGH
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
    }
    
}
