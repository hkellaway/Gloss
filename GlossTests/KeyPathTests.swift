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
                "id": 1,
                "args": [
                    "name":"foo",
                    "url":"http://url.com",
                    "flag" : true
                ]
            ]
        ]
    }
    
    var keyPathJSONWithCustomDelimiter: JSON { return
        [
            "nested" : [
                "id" : 123,
                "url" : "http://url.com"
            ]
        ]
    }
    
    var nestedKeyPathModel: TestNestedKeyPathModel!
    var keyPathModelWithCustomDelimiter: TestKeyPathModelCustomDelimiter!
    
    override func setUp() {
        super.setUp()
        
        nestedKeyPathModel = TestNestedKeyPathModel(json: nestedKeyPathJSON)
        keyPathModelWithCustomDelimiter = TestKeyPathModelCustomDelimiter(json: keyPathJSONWithCustomDelimiter)
    }
    
    override func tearDown() {
        nestedKeyPathModel = nil
        keyPathModelWithCustomDelimiter = nil
        
        super.tearDown()
    }
    
    func testNestedKeyPathFromJSON() {
        XCTAssert(nestedKeyPathModel.keyPathModel?.id == 1 && nestedKeyPathModel.keyPathModel?.name == "foo" && nestedKeyPathModel.keyPathModel?.url?.absoluteString == "http://url.com" && nestedKeyPathModel.flag == true, "Should decode with nested key path")
    }
    
    func testNestedKeyPathToJSON() {
        XCTAssert((nestedKeyPathModel?.toJSON())! == ["keyPath" : ["id": 1, "args": ["name":"foo", "url": "http://url.com", "flag" : true]]], "Should encode with nested key path")
    }
    
    func testNonDefaultKeyPathDecode() {
        XCTAssertTrue(keyPathModelWithCustomDelimiter.id == 123, "Should decode model with custom key path delimiter")
        XCTAssertTrue(keyPathModelWithCustomDelimiter.url?.absoluteString == "http://url.com", "Should decode model with custom key path delimiter")
    }
    
    func testNonDefaultKeyPathEncode() {
        let result = keyPathModelWithCustomDelimiter.toJSON()
        let id = result!["nested"]!["id"]
        let url = result!["nested"]!["url"]
        
        XCTAssertTrue(id == 123, "Should encode model with custom key path delimiter")
        XCTAssertTrue(url == "http://url.com", "Should encode model with custom key path delimiter")
    }
    
}
