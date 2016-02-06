//
//  KeyPathTests.swift
//  Gloss
//
//  Created by Rahul Katariya on 2/1/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Gloss
import XCTest

class KeyPathTests: XCTestCase {
    
    var nestedKeyPathJSON: JSON { return
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
    
    var nestedKeyPathModel: TestNestedKeyPathModel!
    
    override func setUp() {
        super.setUp()
        
        nestedKeyPathModel = TestNestedKeyPathModel(json: nestedKeyPathJSON)
    }
    
    override func tearDown() {
        nestedKeyPathModel = nil
        
        super.tearDown()
    }
    
    func testNestedKeyPathFromJSON() {
        XCTAssert(nestedKeyPathModel.keyPathModel?.id == "1" && nestedKeyPathModel.keyPathModel?.name == "foo" && nestedKeyPathModel.keyPathModel?.email == "bar" && nestedKeyPathModel.flag == true, "Passed")
    }
    
    func testNestedKeyPathToJSON() {
        XCTAssert((nestedKeyPathModel?.toJSON())! == ["keyPath" : ["id": "1", "args": ["name":"foo", "email":"bar", "flag" : true]]], "Passed")
    }
    
}
