//
//  DecoderTests.swift
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

class DecoderTests: XCTestCase {
    
    var testJSON: JSON? = [:]
    
    enum TestEnumValue: String {
        case A = "A"
        case B = "B"
        case C = "C"
    }

    override func setUp() {
        super.setUp()
        
        let float1: Float = 1.0
        let float2: Float = 2.0
        let float3: Float = 3.0
        let double1: Double = 4.0
        let double2: Double = 5.0
        let double3: Double = 6.0
        
        testJSON = [
            "bool" : true,
            "integer" : 1,
            "float" : float2,
            "double" : double3,
            "string" : "abc",
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
            "date" : "2015-08-08T21:57:13Z",
            "url" : "http://github.com"
        ]
        
    }
    
    override func tearDown() {
        testJSON = nil
        
        super.tearDown()
    }
    
    func testDecodeBool() {
        let result: Bool? = Decoder.decode("bool")(testJSON!)
        
        XCTAssertTrue((result == true), "Decode Bool should return correct value")
    }
    
    func testDecodeInt() {
        let result: Int? = Decoder.decode("integer")(testJSON!)
        
        XCTAssertTrue((result == 1), "Decode Int should return correct value")
    }
    
    func testDecodeFloat() {
        let result: Float? = Decoder.decode("float")(testJSON!)
        
        XCTAssertTrue((result == 2.0), "Decode Float should return correct value")
    }
    
    func testDecodeDouble() {
        let result: Double? = Decoder.decode("double")(testJSON!)
        
        XCTAssertTrue((result == 6.0), "Decode Double should return correct value")
    }
    
    func testDecodeString() {
        let result: String? = Decoder.decode("string")(testJSON!)
        
        XCTAssertTrue((result == "abc"), "Decode String should return correct value")
    }
    
    func testDecodeNestedModel() {
        let result: TestNestedModel? = Decoder.decode("nestedModel")(testJSON!)
        
        XCTAssertTrue((result?.id == 123), "Decode nested model should return correct value")
        XCTAssertTrue((result?.name == "nestedModel1"), "Decode nested model should return correct value")
    }
    
    func testDecodeNestedModelArray() {
        let result: [TestNestedModel]? = Decoder.decodeArray("nestedModelArray")(testJSON!)
        let model1: TestNestedModel = result![0]
        let model2: TestNestedModel = result![1]

        XCTAssertTrue((model1.id == 456), "Decode nested model array should return correct value")
        XCTAssertTrue((model1.name == "nestedModel2"), "Decode nested model array should return correct value")
        XCTAssertTrue((model2.id == 789), "Decode nested model array should return correct value")
        XCTAssertTrue((model2.name == "nestedModel3"), "Decode nested model array should return correct value")
    }
    
    func testDecodeEnumValue() {
        let result: TestEnumValue? = Decoder.decodeEnum("enumValue")(testJSON!)
        
        XCTAssertTrue((result?.rawValue == "A"), "Decode enum value should return correct value")
    }
    
    func testDecodeDate() {
        let result: NSDate? = Decoder.decodeDate("date", dateFormatter: TestModel.dateFormatter)(testJSON!)
        
        let year: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: result!).year
        let month: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: result!).month
        let day: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: result!).day
        let hour: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: result!).hour
        let minute: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Minute, fromDate: result!).minute
        let second: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: result!).second
        
        XCTAssertTrue((year == 2015), "Decode NSDate should return correct value")
        XCTAssertTrue((month == 8), "Decode NSDate should return correct value")
        XCTAssertTrue((day == 8), "Decode NSDate should return correct value")
        XCTAssertTrue((hour == 21), "Decode NSDate should return correct value")
        XCTAssertTrue((minute == 57), "Decode NSDate should return correct value")
        XCTAssertTrue((second == 13), "Decode NSDate should return correct value")
    }
    
    func testDecodeURL() {
        let result: NSURL? = Decoder.decodeURL("url")(testJSON!)
        
        XCTAssertTrue((result?.absoluteString == "http://github.com"), "Decode NSURL should return correct value")
    }
    
    func testInvalidValue() {
        let result: String? = Decoder.decode("invalid")(testJSON!)
        
        XCTAssertTrue((result == nil), "Decode should return nil for invalid value");
    }
    
}
