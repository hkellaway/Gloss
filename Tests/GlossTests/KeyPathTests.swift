//
//  KeyPathTests.swift
//  Gloss
//
//  Created by Maciej Kołek on 10/18/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation
import Gloss
import XCTest

class KeyPathTests: XCTestCase {

    static var allTests : [(String, (KeyPathTests) -> () throws -> Void)] {
        return [
            ("testNestedKeyPathFromJSON", testNestedKeyPathFromJSON),
            ("testNestedKeyPathToJSON", testNestedKeyPathToJSON),
            ("testNonDefaultKeyPathDecode", testNonDefaultKeyPathDecode),
            ("testNonDefaultKeyPathEncode", testNonDefaultKeyPathEncode)
        ]
    }
    
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
        XCTAssertTrue(nestedKeyPathModel.keyPathModel?.id == 1, "Should decode with nested key path")
        XCTAssertTrue(nestedKeyPathModel.keyPathModel?.name == "foo", "Should decode with nested key path")
        XCTAssertTrue(nestedKeyPathModel.keyPathModel?.url?.absoluteString == "http://url.com", "Should decode with nested key path")
        XCTAssertTrue(nestedKeyPathModel.flag == true, "Should decode with nested key path")
    }
    
    
    func testNestedKeyPathToJSON() {
        XCTAssertTrue((nestedKeyPathModel?.toJSON())! == nestedKeyPathJSON, "Should encode with nested key path")
    }
    
    func testNonDefaultKeyPathDecode() {
        XCTAssertTrue(keyPathModelWithCustomDelimiter.id == 123, "Should decode model with custom key path delimiter")
        XCTAssertTrue(keyPathModelWithCustomDelimiter.url?.absoluteString == "http://url.com", "Should decode model with custom key path delimiter")
    }
    
    func testNonDefaultKeyPathEncode() {
        let result = keyPathModelWithCustomDelimiter.toJSON()
        
        let nested = result!["nested"] as! JSON
        let id = nested["id"] as! Int
        let url = nested["url"] as! String
        
        XCTAssertTrue(id == 123, "Should encode model with custom key path delimiter")
        XCTAssertTrue(url == "http://url.com", "Should encode model with custom key path delimiter")
    }
    
}
