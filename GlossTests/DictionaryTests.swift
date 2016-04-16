//
//  DictionaryTests.swift
//  GlossExample
//
//  Created by Harlan Kellaway on 2/12/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Gloss
import UIKit
import XCTest

class DictionaryTests: XCTestCase {
    
    var testDictionary: JSON?
    
    override func setUp() {
        super.setUp()
        
        testDictionary = [
            "nested" : [
                "model" : [
                    "nestedModelId" : 123
                ]
            ],
            "id" : 456
        ]
        
    }
    
    override func tearDown() {
        testDictionary = nil
        
        super.tearDown()
    }
    
    func testValueForKeyPathProducesCorrectValueForDelimited() {
        let result = testDictionary?.valueForKeyPath("nested.model.nestedModelId")
        
        XCTAssertTrue((result as! Int) == 123, "Value for key path should product the correct value for delimited keypath.")
    }
    
    func testValueForKeyPathProducesCorrectValueForNonDelimited() {
        let result = testDictionary?.valueForKeyPath("id")
        
        XCTAssertTrue((result as! Int) == 456, "Value for key path should product the correct value for non-delimited keypath.")
    }
    
}