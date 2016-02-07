//
//  EncoderTests.swift
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

class EncoderTests: XCTestCase {
    
    var testNestedModel1: TestNestedModel? = nil
    var testNestedModel2: TestNestedModel? = nil
    
    override func setUp() {
        super.setUp()
        
        testNestedModel1 = TestNestedModel(json: [ "id" : 1, "name" : "nestedModel1" ])
        testNestedModel2 = TestNestedModel(json: ["id" : 2, "name" : "nestedModel2"])
    }
    
    override func tearDown() {
        testNestedModel1 = nil
        testNestedModel2 = nil
        
        super.tearDown()
    }
    
    func testInvalidValue() {
        let notAnyObject: NSURL? = NSURL()
        let result: JSON? = Encoder.encode("invalid")(notAnyObject)
        
        XCTAssertTrue((result == nil), "Encode should return nil for invalid value");
    }
    
    func testEncodeBool() {
        let bool: Bool? = true
        let result: JSON? = Encoder.encode("bool")(bool)
        
        XCTAssertTrue((result!["bool"] as! Bool == true), "Encode Bool should return correct value")
    }
    
    func testEncodeBoolArray() {
        let boolArray: [Bool]? = [true, false, true]
        let result: JSON? = Encoder.encode("boolArray")(boolArray)
        
        XCTAssertTrue((result!["boolArray"] as! [Bool] == [true, false, true]), "Encode Bool array should return correct value")
    }
    
    func testEncodeInt() {
        let integer: Int? = 1
        let result: JSON? = Encoder.encode("integer")(integer)
        
        XCTAssertTrue((result!["integer"] as! Int == 1), "Encode Int should return correct value")
    }
    
    func testEncodeIntArray() {
        let integerArray: [Int]? = [1, 2, 3]
        let result: JSON? = Encoder.encode("integerArray")(integerArray)
        
        XCTAssertTrue((result!["integerArray"] as! [Int] == [1, 2, 3]), "Encode Int array should return correct value")
    }

    func testEncodeFloat() {
        let float: Float? = 1.0
        let result: JSON? = Encoder.encode("float")(float)
        
        XCTAssertTrue((result!["float"] as! Float == 1.0), "Encode Float should return correct value")
    }
    
    func testEncodeFloatArray() {
        let floatArray: [Float]? = [1.0, 2.0, 3.0]
        let result: JSON? = Encoder.encode("floatArray")(floatArray)
        
        XCTAssertTrue((result!["floatArray"] as! [Float] == [1.0, 2.0, 3.0]), "Encode Float array should return correct value")
    }
    
    func testEncodeDouble() {
        let double: Double? = 4.0
        let result: JSON? = Encoder.encode("double")(double)
        
        XCTAssertTrue((result!["double"] as! Double == 4.0), "Encode Double should return correct value")
    }
    
    func testEncodeDoubleArray() {
        let doubleArray: [Double]? = [4.0, 5.0, 6.0]
        let result: JSON? = Encoder.encode("doubleArray")(doubleArray)
        
        XCTAssertTrue((result!["doubleArray"] as! [Double] == [4.0, 5.0, 6.0]), "Encode Double array should return correct value")
    }
    
    func testEncodeEncodableDictionary() {
        let dictionary = ["dictionary" : testNestedModel1!]
        let result: JSON? = Encoder.encodeEncodableDictionary("dictionary")(dictionary)
        
        XCTAssertTrue(result!["dictionary"]!["id"] == 1, "Encode Dictionary should return correct value")
        XCTAssertTrue(result!["dictionary"]!["name"] == "nestedModel1", "Encode Dictionary should return correct value")
    }

    func testEncodeString() {
        let string: String? = "abc"
        let result: JSON? = Encoder.encode("string")(string)
        
        XCTAssertTrue((result!["string"] as! String == "abc"), "Encode String should return correct value")
    }
    
    func testEncodeStringArray() {
        let stringArray: [String]? = ["def", "ghi", "jkl"]
        let result: JSON? = Encoder.encode("stringArray")(stringArray)
        
        XCTAssertTrue((result!["stringArray"] as! [String] == ["def", "ghi", "jkl"]), "String array should return correct value")
    }
    
    func testEncodeNestedModel() {
        let result: JSON? = Encoder.encodeEncodable("nestedModel")(testNestedModel1)
        let modelJSON: JSON = result!["nestedModel"] as! JSON
        
        XCTAssertTrue((modelJSON["id"] as! Int == 1), "Encode nested model should return correct value")
        XCTAssertTrue((modelJSON["name"] as! String == "nestedModel1"), "Encode nested model should return correct value")
    }
    
    func testEncodeNestedModelArray() {
        let model1: TestNestedModel = testNestedModel1!
        let model2: TestNestedModel = testNestedModel2!
        let result: JSON? = Encoder.encodeEncodableArray("nestedModelArray")([model1, model2])
        let modelsJSON: [JSON] = result!["nestedModelArray"] as! [JSON]
        let model1JSON: JSON = modelsJSON[0]
        let model2JSON: JSON = modelsJSON[1]
        
        XCTAssertTrue((model1JSON["id"] as! Int == 1), "Encode nested model array should return correct value")
        XCTAssertTrue((model1JSON["name"] as! String == "nestedModel1"), "Encode nested model array should return correct value")
        XCTAssertTrue((model2JSON["id"] as! Int == 2), "Encode nested model array should return correct value")
        XCTAssertTrue((model2JSON["name"] as! String == "nestedModel2"), "Encode nested model array should return correct value")
    }
    
    func testEncodeEnumValue() {
        let enumValue: TestModel.EnumValue? = TestModel.EnumValue.A
        let result: JSON? = Encoder.encodeEnum("enumValue")(enumValue)
        
        XCTAssertTrue((result!["enumValue"] as! TestModel.EnumValue.RawValue == "A"), "Encode enum value should return correct value")
    }
    
    func testEncodeEnumArray() {
        let enumArray: [TestModel.EnumValue]? = [TestModel.EnumValue.A, TestModel.EnumValue.B, TestModel.EnumValue.C]
        let result: JSON? = Encoder.encodeEnumArray("enumValueArray")(enumArray)
        
        XCTAssertTrue((result!["enumValueArray"] as! [TestModel.EnumValue.RawValue] == ["A", "B", "C"]), "Encode enum value array should return correct value")
    }
    
    func testEncodeDate() {
        let date: NSDate? = TestModel.dateFormatter.dateFromString("2015-08-16T20:51:46.600Z")
        let result: JSON? = Encoder.encodeDate("date", dateFormatter: TestModel.dateFormatter)(date)
        
        XCTAssertTrue(result!["date"] as! String == "2015-08-16T20:51:46.600Z", "Encode NSDate should return correct value")
    }
    
    func testEncodeDateArray() {
        let date: NSDate? = TestModel.dateFormatter.dateFromString("2015-08-16T20:51:46.600Z")
        let dateArray: [NSDate]? = [date!, date!]
        let result: JSON? = Encoder.encodeDateArray("dateArray", dateFormatter: TestModel.dateFormatter)(dateArray)
        
        XCTAssertTrue(result!["dateArray"] as! [String] == ["2015-08-16T20:51:46.600Z", "2015-08-16T20:51:46.600Z"], "Encode NSDate array should return correct value")
    }
    
    func testEncodeDateISO8601() {
        let dateISO8601: NSDate? = NSDate(timeIntervalSince1970: 1439071033)
        let result: JSON? = Encoder.encodeDateISO8601("dateISO8601")(dateISO8601!)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let resultDate = dateFormatter.dateFromString(result!["dateISO8601"] as! String)
        
        XCTAssertTrue(resultDate?.timeIntervalSince1970 == 1439071033, "Encode ISO8601 NSDate should return correct value")
    }
    
    func testEncodeDateISO8601Array() {
        let dateISO8601: NSDate? = NSDate(timeIntervalSince1970: 1439071033)
        let dateISO8601Array: [NSDate]? = [dateISO8601!, dateISO8601!]
        let result: JSON? = Encoder.encodeDateISO8601Array("dateISO8601Array")(dateISO8601Array!)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let resultDate1 = dateFormatter.dateFromString(result!["dateISO8601Array"]![0] as! String)
        let resultDate2 = dateFormatter.dateFromString(result!["dateISO8601Array"]![1] as! String)
        
        XCTAssertTrue(resultDate1?.timeIntervalSince1970 == 1439071033, "Encode ISO8601 NSDate array should return correct value")
        XCTAssertTrue(resultDate2?.timeIntervalSince1970 == 1439071033, "Encode ISO8601 NSDate array should return correct value")
    }
    
    func testEncodeURL() {
        let url: NSURL? = NSURL(string: "http://github.com")
        let result: JSON? = Encoder.encodeURL("url")(url)
        
        XCTAssertTrue((result!["url"] as! String == "http://github.com"), "Encode NSURL should return correct value")
    }
    
    func testEncodeURLArray() {
        let urls: [NSURL]? = [NSURL(string: "http://github.com")!, NSURL(string: "http://github.com")!]
        let result: JSON? = Encoder.encodeArray("urlArray")(urls)
        
        let test = result!["urlArray"] as! [NSURL]
        
        XCTAssertTrue(test.map { url in url.absoluteString } == ["http://github.com", "http://github.com"], "Encode NSURL array should return correct value")
    }

}
