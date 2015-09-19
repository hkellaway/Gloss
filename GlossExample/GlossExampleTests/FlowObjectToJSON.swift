//
//  FlowObjectToJSON.swift
//  GlossExample
//
// Copyright (c) 2015 Harlan Kellaway
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Gloss
import UIKit
import XCTest

class ObjectToJSONFlowTests: XCTestCase {
    
    var testModel: TestModel?
    
    override func setUp() {
        super.setUp()
        
        testModel = TestModel(json: [
            "bool" : true,
            "boolArray" : [true, false, true],
            "integer" : 1,
            "integerArray" : [1, 2, 3],
            "float" : 2.0,
            "floatArray" : [1.0, 2.0, 3.0],
            "double" : 6.0,
            "doubleArray" : [4.0, 5.0, 6.0],
            "string" : "abc",
            "stringArray" : ["def", "ghi", "jkl"],
            "nestedModel" : [
                "id" : 123,
                "name" : "nestedModel1"
            ],
            "nestedModelArray" : [
                [
                    "id" : 456,
                    "name" : "nestedModel2"
            ],
            [
                "id" : 789,
                "name" : "nestedModel3"
            ]
            ],
            "enumValue" : "A",
            "enumValueArray" : ["A", "B", "C"],
            "date" : "2015-08-16T20:51:46.600Z",
            "dateISO8601" : "2015-08-08T21:57:13Z",
            "url" : "http://github.com"
        ])
    }
    
    override func tearDown() {
        testModel = nil
        
        super.tearDown()
    }
    
    func testObjectEncodedToJSONHasCorrectProperties() {
        let result = testModel!.toJSON()
        
        XCTAssertTrue((result!["bool"] as! Bool == true), "JSON created from model should have correct values")
        XCTAssertTrue((result!["boolArray"] as! [Bool] == [true, false, true]), "JSON created from model should have correct values")
        XCTAssertTrue((result!["integer"] as! Int == 1), "JSON created from model should have correct values")
        XCTAssertTrue((result!["integerArray"] as! [Int] == [1, 2, 3]), "JSON created from model should have correct values")
        XCTAssertTrue((result!["float"] as! Float == 2.0), "JSON created from model should have correct values")
        XCTAssertTrue((result!["floatArray"] as! [Float] == [1.0, 2.0, 3.0]), "JSON created from model should have correct values")
        XCTAssertTrue((result!["double"] as! Double == 6.0), "JSON created from model should have correct values")
        XCTAssertTrue((result!["doubleArray"] as! [Double] == [4.0, 5.0, 6.0]), "JSON created from model should have correct values")
        XCTAssertTrue((result!["string"] as! String == "abc"), "JSON created from model should have correct values")
        XCTAssertTrue((result!["stringArray"] as! [String] == ["def", "ghi", "jkl"]), "JSON created from model should have correct values")
        XCTAssertTrue((result!["enumValue"] as! String == "A"), "JSON created from model should have correct values")
        XCTAssertTrue((result!["enumValueArray"] as! [String] == ["A", "B", "C"]), "JSON created from model should have correct values")
        XCTAssertTrue(((result!["date"] as! String) == "2015-08-16T20:51:46.600Z"), "JSON created from model should have correct values")
        
        let dateISO8601 = result!["dateISO8601"] as! String
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let resultDate = dateFormatter.dateFromString(dateISO8601)
        
        XCTAssertTrue(resultDate?.timeIntervalSince1970 == 1439071033, "JSON created from model should have correct values")
        
        XCTAssertTrue((result!["url"] as! String == "http://github.com"), "JSON created from model should have correct values")
        
        let nestedModel: JSON = result!["nestedModel"] as! JSON
        
        XCTAssertTrue((nestedModel["id"] as! Int == 123), "Encode nested model should return correct value")
        XCTAssertTrue((nestedModel["name"] as! String == "nestedModel1"), "Encode nested model should return correct value")
        
        let nestedModelsJSON: [JSON] = result!["nestedModelArray"] as! [JSON]
        let nestedModel2JSON: JSON = nestedModelsJSON[0]
        let nestedModel3JSON: JSON = nestedModelsJSON[1]
        
        XCTAssertTrue((nestedModel2JSON["id"] as! Int == 456), "Encode nested model array should return correct value")
        XCTAssertTrue((nestedModel2JSON["name"] as! String == "nestedModel2"), "Encode nested model array should return correct value")
        XCTAssertTrue((nestedModel3JSON["id"] as! Int == 789), "Encode nested model array should return correct value")
        XCTAssertTrue((nestedModel3JSON["name"] as! String == "nestedModel3"), "Encode nested model array should return correct value")
    }
    
}
