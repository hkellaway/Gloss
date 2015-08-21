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
    
    let validJSON: JSON = [
        "identifier": "unique",
        "value" : 99999,
    ]
    
    let invalidJSON: JSON = [
        "asdf": "dsafhkjdaf",
        "asjdkfhl": 203183492749,
        "asdfjhkhfsldjghi": 0.12390
    ]

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
    
    func testSerializingObjectsCanFai() {
        let maybeModel = FailableModel(json: invalidJSON)
        XCTAssertTrue(maybeModel == nil, "Expected initialization with bad data to fail, instead got \(maybeModel)")
    }
    
    func testSerializingFailableObjectsCanSucceed() {
        let maybeModel = FailableModel(json: validJSON)
        XCTAssertTrue(maybeModel != nil, "Expected initialization with valid data to succeed, instead got \(maybeModel)")
    }
    
    func testJSONIsNotNil() {
        XCTAssertTrue((testJSON != nil), "Test JSON should not be nil")
    }
    
    func testInvalidValue() {
        let result: String? = Decoder.decode("invalid")(testJSON!)
        
        XCTAssertTrue((result == nil), "Decode should return nil for invalid value");
    }
    
    func testDecodeBool() {
        let result: Bool? = Decoder.decode("bool")(testJSON!)
        let force: Bool = Decoder.forceDecode("bool")(testJSON!)
        
        XCTAssertTrue((result == true), "Decode Bool should return correct value")
        XCTAssertTrue((force == true), "Force decode Bool should return correct value")
    }
    
    func testDecodeBoolArray() {
        let result: [Bool]? = Decoder.decode("boolArray")(testJSON!)
        let element1: Bool = result![0]
        let element2: Bool = result![1]
        let element3: Bool = result![2]
        
        XCTAssertTrue((element1 == true), "Decode Bool array should return correct value")
        XCTAssertTrue((element2 == false), "Decode Bool array should return correct value")
        XCTAssertTrue((element3 == true), "Decode Bool array should return correct value")
    }
    
    func testDecodeInt() {
        let result: Int? = Decoder.decode("integer")(testJSON!)
        
        XCTAssertTrue((result == 1), "Decode Int should return correct value")
    }
    
    func testDecodeIntArray() {
        let result: [Int]? = Decoder.decode("integerArray")(testJSON!)
        let element1: Int = result![0]
        let element2: Int = result![1]
        let element3: Int = result![2]
        
        XCTAssertTrue((element1 == 1), "Decode Int array should return correct value")
        XCTAssertTrue((element2 == 2), "Decode Int array should return correct value")
        XCTAssertTrue((element3 == 3), "Decode Int array should return correct value")
    }
    
    func testDecodeFloat() {
        let result: Float? = Decoder.decode("float")(testJSON!)
        
        XCTAssertTrue((result == 2.0), "Decode Float should return correct value")
    }
    
    func testDecodeFloatArray() {
        let result: [Float]? = Decoder.decode("floatArray")(testJSON!)
        let element1: Float = result![0]
        let element2: Float = result![1]
        let element3: Float = result![2]
        
        XCTAssertTrue((element1 == 1.0), "Decode Float array should return correct value")
        XCTAssertTrue((element2 == 2.0), "Decode Float array should return correct value")
        XCTAssertTrue((element3 == 3.0), "Decode Float array should return correct value")
    }
    
    func testDecodeDouble() {
        let result: Double? = Decoder.decode("double")(testJSON!)
        
        XCTAssertTrue((result == 6.0), "Decode Double should return correct value")
    }
    
    func testDecodeDoubleArray() {
        let result: [Double]? = Decoder.decode("doubleArray")(testJSON!)
        let element1: Double = result![0]
        let element2: Double = result![1]
        let element3: Double = result![2]
        
        XCTAssertTrue((element1 == 4.0), "Decode Double array should return correct value")
        XCTAssertTrue((element2 == 5.0), "Decode Double array should return correct value")
        XCTAssertTrue((element3 == 6.0), "Decode Double array should return correct value")
    }
    
    func testDecodeString() {
        let result: String? = Decoder.decode("string")(testJSON!)
        
        XCTAssertTrue((result == "abc"), "Decode String should return correct value")
    }
    
    func testDecodeStringArray() {
        let result: [String]? = Decoder.decode("stringArray")(testJSON!)
        let element1: String = result![0]
        let element2: String = result![1]
        let element3: String = result![2]
        
        XCTAssertTrue((element1 == "def"), "Decode String array should return correct value")
        XCTAssertTrue((element2 == "ghi"), "Decode String array should return correct value")
        XCTAssertTrue((element3 == "jkl"), "Decode String array should return correct value")
    }
    
    func testDecodeNestedModel() {
        let result: TestNestedModel? = Decoder.decode("nestedModel")(testJSON!)
        
        XCTAssertTrue((result?.id == 123), "Decode nested model should return correct value")
        XCTAssertTrue((result?.name == "nestedModel1"), "Decode nested model should return correct value")
    }
    
    func testDecodeEnumValue() {
        let result: TestModel.EnumValue? = Decoder.decodeEnum("enumValue")(testJSON!)
        
        XCTAssertTrue((result == TestModel.EnumValue.A), "Decode enum value should return correct value")
    }
    
    func testDecodeEnumArray() {
        let result: [TestModel.EnumValue]? = Decoder.decodeArray("enumValueArray")(testJSON!)
        let element1: TestModel.EnumValue = result![0]
        let element2: TestModel.EnumValue = result![1]
        let element3: TestModel.EnumValue = result![2]
        
        XCTAssertTrue((element1 == TestModel.EnumValue.A), "Decode enum value array should return correct value")
        XCTAssertTrue((element2 == TestModel.EnumValue.B), "Decode enum value array should return correct value")
        XCTAssertTrue((element3 == TestModel.EnumValue.C), "Decode enum value array should return correct value")
    }
    
    func testDecodeDate() {
        let result: NSDate? = Decoder.decodeDate("date", dateFormatter: TestModel.dateFormatter)(testJSON!)
        
        let year: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: result!).year
        let month: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: result!).month
        let day: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: result!).day
        let hour: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: result!).hour
        let minute: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Minute, fromDate: result!).minute
        let second: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: result!).second
        let nanosecond: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Nanosecond, fromDate: result!).nanosecond
        
        XCTAssertTrue((year == 2015), "Decode NSDate should return correct value")
        XCTAssertTrue((month == 8), "Decode NSDate should return correct value")
        XCTAssertTrue((day == 16), "Decode NSDate should return correct value")
        XCTAssertTrue((hour == 20), "Decode NSDate should return correct value")
        XCTAssertTrue((minute == 51), "Decode NSDate should return correct value")
        XCTAssertTrue((second == 46), "Decode NSDate should return correct value")
        XCTAssertTrue((nanosecond/1000000 == 599), "Decode NSDate should return correct value")
    }
    
    func testDecodeDateISO8601() {
        let result: NSDate? = Decoder.decodeDateISO8601("dateISO8601")(testJSON!)
        
        let year: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: result!).year
        let month: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: result!).month
        let day: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: result!).day
        let hour: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: result!).hour
        let minute: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Minute, fromDate: result!).minute
        let second: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: result!).second
        
        XCTAssertTrue((year == 2015), "Decode NSDate should return correct value")
        XCTAssertTrue((month == 8), "Decode NSDate should return correct value")
        XCTAssertTrue((day == 8), "Decode NSDate should return correct value")
        XCTAssertTrue((hour == 14), "Decode NSDate should return correct value")
        XCTAssertTrue((minute == 57), "Decode NSDate should return correct value")
        XCTAssertTrue((second == 13), "Decode NSDate should return correct value")
    }
    
    func testDecodeURL() {
        let result: NSURL? = Decoder.decodeURL("url")(testJSON!)
        
        XCTAssertTrue((result?.absoluteString == "http://github.com"), "Decode NSURL should return correct value")
    }
    
    func testForceDecodeBool() {
        let result: Bool = Decoder.forceDecode("bool")(testJSON!)
        
        XCTAssertTrue((result == true), "Force decode Bool should return correct value")
    }
    
    func testForceDecodeBoolArray() {
        let result: [Bool] = Decoder.forceDecode("boolArray")(testJSON!)
        let element1: Bool = result[0]
        let element2: Bool = result[1]
        let element3: Bool = result[2]
        
        XCTAssertTrue((element1 == true), "Decode Bool array should return correct value")
        XCTAssertTrue((element2 == false), "Decode Bool array should return correct value")
        XCTAssertTrue((element3 == true), "Decode Bool array should return correct value")
    }
    
    func testForceDecodeInt() {
        let result: Int = Decoder.forceDecode("integer")(testJSON!)
        
        XCTAssertTrue((result == 1), "Decode Int should return correct value")
    }
    
    func testForceDecodeIntArray() {
        let result: [Int] = Decoder.forceDecode("integerArray")(testJSON!)
        let element1: Int = result[0]
        let element2: Int = result[1]
        let element3: Int = result[2]
        
        XCTAssertTrue((element1 == 1), "Decode Int array should return correct value")
        XCTAssertTrue((element2 == 2), "Decode Int array should return correct value")
        XCTAssertTrue((element3 == 3), "Decode Int array should return correct value")
    }
    
    func testForceDecodeFloat() {
        let result: Float = Decoder.forceDecode("float")(testJSON!)
        
        XCTAssertTrue((result == 2.0), "Decode Float should return correct value")
    }
    
    func testForceDecodeFloatArray() {
        let result: [Float] = Decoder.forceDecode("floatArray")(testJSON!)
        let element1: Float = result[0]
        let element2: Float = result[1]
        let element3: Float = result[2]
        
        XCTAssertTrue((element1 == 1.0), "Decode Float array should return correct value")
        XCTAssertTrue((element2 == 2.0), "Decode Float array should return correct value")
        XCTAssertTrue((element3 == 3.0), "Decode Float array should return correct value")
    }
    
    func testForceDecodeDouble() {
        let result: Double = Decoder.forceDecode("double")(testJSON!)
        
        XCTAssertTrue((result == 6.0), "Decode Double should return correct value")
    }
    
    func testForceDecodeDoubleArray() {
        let result: [Double] = Decoder.forceDecode("doubleArray")(testJSON!)
        let element1: Double = result[0]
        let element2: Double = result[1]
        let element3: Double = result[2]
        
        XCTAssertTrue((element1 == 4.0), "Decode Double array should return correct value")
        XCTAssertTrue((element2 == 5.0), "Decode Double array should return correct value")
        XCTAssertTrue((element3 == 6.0), "Decode Double array should return correct value")
    }
    
    func testForceDecodeString() {
        let result: String = Decoder.forceDecode("string")(testJSON!)
        
        XCTAssertTrue((result == "abc"), "Decode String should return correct value")
    }
    
    func testForceDecodeStringArray() {
        let result: [String] = Decoder.forceDecode("stringArray")(testJSON!)
        let element1: String = result[0]
        let element2: String = result[1]
        let element3: String = result[2]
        
        XCTAssertTrue((element1 == "def"), "Decode String array should return correct value")
        XCTAssertTrue((element2 == "ghi"), "Decode String array should return correct value")
        XCTAssertTrue((element3 == "jkl"), "Decode String array should return correct value")
    }
    
    func testForceDecodeNestedModel() {
        let result: TestNestedModel = Decoder.forceDecode("nestedModel")(testJSON!)
        
        XCTAssertTrue((result.id == 123), "Decode nested model should return correct value")
        XCTAssertTrue((result.name == "nestedModel1"), "Decode nested model should return correct value")
    }
    
    func testForceDecodeNestedModelArray() {
        let result: [TestNestedModel] = Decoder.forceDecodeArray("nestedModelArray")(testJSON!)
        let element1: TestNestedModel = result[0]
        let element2: TestNestedModel = result[1]
        
        XCTAssertTrue((element1.id == 456), "Decode nested model array should return correct value")
        XCTAssertTrue((element1.name == "nestedModel2"), "Decode nested model array should return correct value")
        XCTAssertTrue((element2.id == 789), "Decode nested model array should return correct value")
        XCTAssertTrue((element2.name == "nestedModel3"), "Decode nested model array should return correct value")
    }
    
    func testForceDecodeEnumValue() {
        let result: TestModel.EnumValue = Decoder.forceDecodeEnum("enumValue")(testJSON!)
        
        XCTAssertTrue((result == TestModel.EnumValue.A), "Decode enum value should return correct value")
    }
    
    func testForceDecodeEnumArray() {
        let result: [TestModel.EnumValue] = Decoder.forceDecodeArray("enumValueArray")(testJSON!)
        let element1: TestModel.EnumValue = result[0]
        let element2: TestModel.EnumValue = result[1]
        let element3: TestModel.EnumValue = result[2]
        
        XCTAssertTrue((element1 == TestModel.EnumValue.A), "Decode enum value array should return correct value")
        XCTAssertTrue((element2 == TestModel.EnumValue.B), "Decode enum value array should return correct value")
        XCTAssertTrue((element3 == TestModel.EnumValue.C), "Decode enum value array should return correct value")
    }
    
    func testForceDecodeDate() {
        let result: NSDate = Decoder.forceDecodeDate("date", dateFormatter: TestModel.dateFormatter)(testJSON!)
        
        let year: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: result).year
        let month: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: result).month
        let day: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: result).day
        let hour: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: result).hour
        let minute: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Minute, fromDate: result).minute
        let second: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: result).second
        let nanosecond: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Nanosecond, fromDate: result).nanosecond
        
        XCTAssertTrue((year == 2015), "Decode NSDate should return correct value")
        XCTAssertTrue((month == 8), "Decode NSDate should return correct value")
        XCTAssertTrue((day == 16), "Decode NSDate should return correct value")
        XCTAssertTrue((hour == 20), "Decode NSDate should return correct value")
        XCTAssertTrue((minute == 51), "Decode NSDate should return correct value")
        XCTAssertTrue((second == 46), "Decode NSDate should return correct value")
        XCTAssertTrue((nanosecond/1000000 == 599), "Decode NSDate should return correct value")
    }
    
    func testForceDecodeDateISO8601() {
        let result: NSDate = Decoder.forceDecodeDateISO8601("dateISO8601")(testJSON!)
        
        let year: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: result).year
        let month: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: result).month
        let day: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: result).day
        let hour: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: result).hour
        let minute: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Minute, fromDate: result).minute
        let second: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: result).second
        
        XCTAssertTrue((year == 2015), "Decode NSDate should return correct value")
        XCTAssertTrue((month == 8), "Decode NSDate should return correct value")
        XCTAssertTrue((day == 8), "Decode NSDate should return correct value")
        XCTAssertTrue((hour == 14), "Decode NSDate should return correct value")
        XCTAssertTrue((minute == 57), "Decode NSDate should return correct value")
        XCTAssertTrue((second == 13), "Decode NSDate should return correct value")
    }
    
    func testForceDecodeURL() {
        let result: NSURL = Decoder.forceDecodeURL("url")(testJSON!)
        
        XCTAssertTrue((result.absoluteString == "http://github.com"), "Decode NSURL should return correct value")
    }
    
}
