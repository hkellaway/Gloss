//
//  FlowObjectCreationTests.swift
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

class FlowObjectCreationTests: XCTestCase {
    
    var testJSON: JSON? = [:]
    
    override func setUp() {
        super.setUp()
        
        let testJSONPath: NSString = NSBundle(forClass: self.dynamicType).pathForResource("TestModel", ofType: "json")!
        let testJSONData: NSData = NSData(contentsOfFile: testJSONPath as String)!
        
        do {
            try testJSON = NSJSONSerialization.JSONObjectWithData(testJSONData, options: NSJSONReadingOptions(rawValue: 0)) as? JSON
        } catch {
            print(error)
        }
    }
    
    override func tearDown() {
        testJSON = nil
        
        super.tearDown()
    }
    
    func testObjectDecodedFromJSONHasCorrectProperties() {
        let result = TestModel.init(json: testJSON!)!
        
        XCTAssertTrue((result.bool == true), "Model created from JSON should have correct property values")
        XCTAssertTrue((result.boolArray! == [true, false, true]), "Model created from JSON should have correct property values")
        XCTAssertTrue((result.integer == 1), "Model created from JSON should have correct property values")
        XCTAssertTrue((result.integerArray! == [1, 2, 3]), "Model created from JSON should have correct property values")
        XCTAssertTrue((result.float == 2.0), "Model created from JSON should have correct property values")
        XCTAssertTrue((result.floatArray! == [1.0, 2.0, 3.0]), "Model created from JSON should have correct property values")
        XCTAssertTrue((result.double == 6.0), "Model created from JSON should have correct property values")
        XCTAssertTrue((result.doubleArray! == [4.0, 5.0, 6.0]), "Model created from JSON should have correct property values")
        XCTAssertTrue(result.dictionary!["otherModel"]!.id! == 789, "Model created from JSON should have correct property values")
        XCTAssertTrue(result.dictionary!["otherModel"]!.name! == "otherModel1", "Model created from JSON should have correct property values")
        XCTAssertTrue((result.string == "abc"), "Model created from JSON should have correct property values")
        XCTAssertTrue((result.stringArray! == ["def", "ghi", "jkl"]), "Model created from JSON should have correct property values")
        XCTAssertTrue((result.enumValue == TestModel.EnumValue.A), "Model created from JSON should have correct property values")
        XCTAssertTrue((result.enumValueArray! == [TestModel.EnumValue.A, TestModel.EnumValue.B, TestModel.EnumValue.C]), "Model created from JSON should have correct property values")
        XCTAssertTrue((TestModel.dateFormatter.stringFromDate(result.date!) == "2015-08-16T20:51:46.600Z"), "Model created from JSON should have correct property values")
        XCTAssertTrue((result.dateArray!.map { date in TestModel.dateFormatter.stringFromDate(date) }) == ["2015-08-16T20:51:46.600Z", "2015-08-16T20:51:46.600Z"], "Model created from JSON should have correct property values")
        XCTAssertTrue((result.dateISO8601 == NSDate(timeIntervalSince1970: 1439071033)), "Model created from JSON should have correct property values")
        XCTAssertTrue((result.dateISO8601Array!.map { date in date.timeIntervalSince1970 }) == [1439071033, 1439071033], "Model created from JSON should have correct property values")
        XCTAssertTrue((result.url?.absoluteString == "http://github.com"), "Model created from JSON should have correct property values")
        XCTAssertTrue((result.urlArray?.map { url in url.absoluteString })! == ["http://github.com", "http://github.com", "http://github.com"], "Model created from JSON should have correct property values")
        
        XCTAssertTrue((result.nestedModel?.id == 123), "Model created from JSON should have correct property values")
        XCTAssertTrue((result.nestedModel?.name == "nestedModel1"), "Model created from JSON should have correct property values")
        
        let nestedModel2: TestNestedModel = result.nestedModelArray![0]
        let nestedModel3: TestNestedModel = result.nestedModelArray![1]
        XCTAssertTrue((nestedModel2.id == 456), "Model created from JSON should have correct property values")
        XCTAssertTrue((nestedModel2.name == "nestedModel2"), "Model created from JSON should have correct property values")
        XCTAssertTrue((nestedModel3.id == 789), "Model created from JSON should have correct property values")
        XCTAssertTrue((nestedModel3.name == "nestedModel3"), "Model created from JSON should have correct property values")
    }
    
}
