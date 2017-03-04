//
//  BeaCodeAppTests.swift
//  BeaCodeAppTests
//
//  Created by Marek Bruchatý on 12/12/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import XCTest
@testable import BeaCodeApp

class BeaCodeAppTests: XCTestCase {
    var vc : NavigationViewController?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        vc = (storyboard.instantiateInitialViewController() as! NavigationViewController)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDictionaryReduction() {
        var trackedBeacons: Dictionary<String, BeaconMeasuraments> = Dictionary<String, BeaconMeasuraments>()
        var beaconMeasuraments1 = BeaconMeasuraments()
        beaconMeasuraments1.key = "key1"
        beaconMeasuraments1.major = "major1"
        beaconMeasuraments1.minor = "minor1"
        beaconMeasuraments1.accuracyMeasuraments.append(4.5)
        beaconMeasuraments1.accuracyMeasuraments.append(4.9)
        beaconMeasuraments1.accuracyMeasuraments.append(5.0)
        trackedBeacons["key1"] = beaconMeasuraments1
        
        var beaconMeasuraments2 = BeaconMeasuraments()
        beaconMeasuraments2.key = "key2"
        beaconMeasuraments2.major = "major2"
        beaconMeasuraments2.minor = "minor2"
        beaconMeasuraments2.accuracyMeasuraments.append(6.5)
        beaconMeasuraments2.accuracyMeasuraments.append(6.0)
        beaconMeasuraments2.accuracyMeasuraments.append(5.0)
        trackedBeacons["key2"] = beaconMeasuraments1
        
        let closest = vc?.getClosestBeaconByAverageDistance(trackedBeacons: trackedBeacons)
        XCTAssert(closest?.key == beaconMeasuraments1.key)
    }
    
}
