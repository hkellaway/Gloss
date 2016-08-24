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
        let nestedKeyPathJson = nestedKeyPathModel!.toJSON()! as! [String: [String: Any]]
        let referenceJson = ["keyPath" : ["id": 1 as AnyObject, "args": ["name":"foo", "url": "http://url.com", "flag" : true]]]
        
        XCTAssert(nestedKeyPathJson["keyPath"]!["id"] as! Int == referenceJson["keyPath"]!["id"] as! Int, "Should encode with nested key path")
        
        let args = nestedKeyPathJson["keyPath"]!["args"] as! JSON
        let referenceArgs = referenceJson["keyPath"]!["args"] as! JSON
        XCTAssert(args["name"] as! String == referenceArgs["name"] as! String, "Should encode with nested key path")
        XCTAssert(args["url"] as! String == referenceArgs["url"] as! String, "Should encode with nested key path")
        XCTAssert(args["flag"] as! Bool == referenceArgs["flag"] as! Bool, "Should encode with nested key path")
    }
    
    func testNonDefaultKeyPathDecode() {
        XCTAssertTrue(keyPathModelWithCustomDelimiter.id == 123, "Should decode model with custom key path delimiter")
        XCTAssertTrue(keyPathModelWithCustomDelimiter.url?.absoluteString == "http://url.com", "Should decode model with custom key path delimiter")
    }
    
    func testNonDefaultKeyPathEncode() {
        let result = keyPathModelWithCustomDelimiter.toJSON()
        let nested = result!["nested"] as! JSON
        let id = nested["id"] as? Int
        let url = nested["url"] as? String
        
        XCTAssertTrue(id == 123, "Should encode model with custom key path delimiter")
        XCTAssertTrue(url == "http://url.com", "Should encode model with custom key path delimiter")
    }
    
}
