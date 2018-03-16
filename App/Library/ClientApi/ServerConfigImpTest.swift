//
//  ServerConfigImpTest.swift
//  ISATests
//
//  Created by 斌王 on 06/03/2018.
//  Copyright © 2018 斌王. All rights reserved.
//

import XCTest

class ServerConfigImpTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        let s0 = ServerConfigImp(apiBaseURL: URL(string: "http://baidu.com")!, logBaseURL: URL(string: "http://baidu.com")!, webBaseURL: URL(string: "http://baidu.com")!)
        let s1 = ServerConfigImp(apiBaseURL: URL(string: "http://baidu1.com")!, logBaseURL: URL(string: "http://baidu.com")!, webBaseURL: URL(string: "http://baidu.com")!)
        assert(s0 == s1, "出错啦,两者不等于哦")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
