//
//  _RMCalculatorTests.swift
//  1RMCalculatorTests
//
//  Created by Tunde Alao on 23/10/2017.
//  Copyright © 2017 Tunde Alao. All rights reserved.
//

import XCTest
@testable import _RMCalculator

class _RMCalculatorTests: XCTestCase {
    func test1RepMaxCalculation() {
        let set = WorkoutSet(date: Date(), reps: 10, weight: 200)
        assert(set.oneRepMax == 267.0)
        
        let set2 = WorkoutSet(date: Date(), reps: 1, weight: 200)
        assert(set2.oneRepMax == 200)
        
        let workout = Workout(name: "Test Workout")
        workout.addSet(set: set)
        workout.addSet(set: set2)
        
        assert(workout.maxOneRepMax == 267.0)
        
    }
    
    func testHistoricOneRepMax() {
        let timeInterval1 = TimeInterval(1506294000)
        let timeInterval2 = TimeInterval(1508945635)
        
        let workout = Workout(name: "Test Workout")
        
        assert(workout.historicOneRepMax().count == 0)
        
        workout.addSet(set: WorkoutSet(date: Date(timeIntervalSince1970: timeInterval2), reps: 10, weight: 200))
        workout.addSet(set: WorkoutSet(date: Date(timeIntervalSince1970: timeInterval2), reps: 10, weight: 100))
        
        let historicOneRepMax1 = workout.historicOneRepMax()
        assert(historicOneRepMax1.count == 1)
        assert(historicOneRepMax1[0].0 == Date(timeIntervalSince1970: timeInterval2))
        assert(historicOneRepMax1[0].1 == 267.0)
        
        workout.addSet(set: WorkoutSet(date: Date(timeIntervalSince1970: timeInterval1), reps: 1, weight: 100))
        workout.addSet(set: WorkoutSet(date: Date(timeIntervalSince1970: timeInterval1), reps: 1, weight: 50))
        
        let historicOneRepMax2 = workout.historicOneRepMax()
        assert(historicOneRepMax2.count == 2)
        assert(historicOneRepMax2[0].0 == Date(timeIntervalSince1970: timeInterval1))
        assert(historicOneRepMax2[0].1 == 100)
        assert(historicOneRepMax2[1].0 == Date(timeIntervalSince1970: timeInterval2))
        assert(historicOneRepMax2[1].1 == 267.0)
    }
}
