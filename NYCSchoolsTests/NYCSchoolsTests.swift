//
//  NYCSchoolsTests.swift
//  NYCSchoolsTests
//
//  Created by Amit Patel on 2/23/20.
//  Copyright © 2020 Amit Patel. All rights reserved.
//

import XCTest
@testable import NYCSchools

class NYCSchoolsTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    func testGetSchoolsList() {
        let dataModel = SchoolDataModel()
        let expect = XCTestExpectation(description: "wait for results set")
        var count = 0
        DispatchQueue.global(qos: .userInitiated).async  {
            dataModel.getSchools { (data, response, error) in
                if error != nil {
                    if let schoolData = data {
                        count = schoolData.count
                        expect.fulfill()
                    }
                }
            }
        }
        wait(for: [expect], timeout: 15.0)
        XCTAssertTrue(count > 0)
    }
    
    func testGetSATScoresForSchool() {
        let dbnId = "13K499"
        let dataModel = SchoolSATDataModel(dbn: dbnId )
        var count = 0
        let expect = XCTestExpectation(description: "wait for sat results")
        //DispatchQueue.global(qos: .userInitiated).async {
            dataModel.getSchoolSATScoresFor(identifier: dbnId) { (data, response, error) in
                if error != nil {
                    if let satData = data {
                        count = satData.count
                        expect.fulfill()
                    }
                }
            }
        //}
        wait(for: [expect], timeout: 10.0)
        XCTAssertTrue(count > 0)
    }

}
