//
//  KeyPathTests.swift
//  Gloss
//
//  Created by Rahul Katariya on 01/02/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import XCTest
@testable import Gloss

class KeyPathTests: XCTestCase {
    
    var nestedKeyPathParams: JSON { return
        [
            "keyPath" : [
                "id": "1",
                "args": [
                    "name":"foo",
                    "email":"bar",
                    "flag" : true
                ]
            ]
        ]
    }
    var nestedKeyPath: NestedKeyPath!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        nestedKeyPath = NestedKeyPath(json: nestedKeyPathParams)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNestedKeyPathFromJSON() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssert(nestedKeyPath.keyPath?.id == "1" && nestedKeyPath.keyPath?.name == "foo" && nestedKeyPath.keyPath?.email == "bar" && nestedKeyPath.flag == true, "Passed")
    }
    
    func testNestedKeyPathToJSON() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssert((nestedKeyPath?.toJSON())! == ["keyPath" : ["id": "1", "args": ["name":"foo", "email":"bar", "flag" : true]]], "Passed")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

    
}

extension KeyPathTests {
    
    struct NestedKeyPath: Glossy {
        
        var keyPath: KeyPath?
        var flag: Bool
        
        init?(json: JSON) {
            self.keyPath = "keyPath" <~~ json
            self.flag = "keyPath.args.flag" <~~ json ?? false
        }
        
        func toJSON() -> JSON? {
            return jsonify([
                "keyPath" ~~> self.keyPath,
                "keyPath.args.flag" ~~> self.flag
                ])
        }
        
    }
    
    struct KeyPath: Glossy {
        
        var id: String?
        var name: String?
        var email: String?
        
        init?(json: JSON) {
            self.id = "id" <~~ json
            self.name = "args.name" <~~ json
            self.email = "args.email" <~~ json
        }
        
        func toJSON() -> JSON? {
            return jsonify([
                "id" ~~> self.id,
                "args.name" ~~> self.name,
                "args.email" ~~> self.email
                ])
        }
        
    }
    
}
