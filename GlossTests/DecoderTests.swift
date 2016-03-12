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
    var testFailableModelJSONValid: JSON? = [:]
    var testFailableModelJSONInvalid: JSON? = [:]

    override func setUp() {
        super.setUp()
        
        var testJSONPath: NSString = NSBundle(forClass: self.dynamicType).pathForResource("TestModel", ofType: "json")!
        var testJSONData: NSData = NSData(contentsOfFile: testJSONPath as String)!
        
        do {
            try testJSON = NSJSONSerialization.JSONObjectWithData(testJSONData, options: NSJSONReadingOptions(rawValue: 0)) as? JSON
        } catch {
            print(error)
        }
        
        testJSONPath  = NSBundle(forClass: self.dynamicType).pathForResource("TestFailableModelValid", ofType: "json")!
        testJSONData = NSData(contentsOfFile: testJSONPath as String)!
        
        do {
            try testFailableModelJSONValid = NSJSONSerialization.JSONObjectWithData(testJSONData, options: NSJSONReadingOptions(rawValue: 0)) as? JSON
        } catch {
            print(error)
        }
        
        testJSONPath  = NSBundle(forClass: self.dynamicType).pathForResource("TestFailableModelInvalid", ofType: "json")!
        testJSONData = NSData(contentsOfFile: testJSONPath as String)!
        
        do {
            try testFailableModelJSONInvalid = NSJSONSerialization.JSONObjectWithData(testJSONData, options: NSJSONReadingOptions(rawValue: 0)) as? JSON
        } catch {
            print(error)
        }
    }
    
    override func tearDown() {
        testJSON = nil
        testFailableModelJSONValid = nil
        testFailableModelJSONInvalid = nil
        
        super.tearDown()
    }
    
    func testInitializingFailableObjectsWithBadDataCanFail() {
        let result = TestFailableModel(json: testFailableModelJSONInvalid!)
        
        XCTAssertTrue(result == nil, "Expected initialization with bad data to fail, instead got \(result)")
    }
    
    func testInitializingFailableObjectsWithValidDataCanSucceed() {
        let result = TestFailableModel(json: testFailableModelJSONValid!)
        
        XCTAssertTrue(result != nil, "Expected initialization with valid data to succeed, instead got \(result)")
    }
    
    func testInvalidValue() {
        let result: String? = Decoder.decode("invalid")(testJSON!)
        
        XCTAssertTrue((result == nil), "Decode should return nil for invalid value");
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
    
    func testDecodeDictionary() {
        let result: [String : TestNestedModel]? = Decoder.decodeDecodableDictionary("dictionary")(testJSON!)
        let model: TestNestedModel? = result!["otherModel"]

        let id = model!.id
        let name = model!.name
        
        XCTAssertTrue((id == 789), "Decode Dictionary should return correct value")
        XCTAssertTrue((name == "otherModel1"), "Decode Dictionar should return correct value")
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
        let result: TestNestedModel? = Decoder.decodeDecodable("nestedModel")(testJSON!)
        
        XCTAssertTrue((result?.id == 123), "Decode nested model should return correct value")
        XCTAssertTrue((result?.name == "nestedModel1"), "Decode nested model should return correct value")
    }
    
    func testDecodeEnumValue() {
        let result: TestModel.EnumValue? = Decoder.decodeEnum("enumValue")(testJSON!)
        
        XCTAssertTrue((result == TestModel.EnumValue.A), "Decode enum value should return correct value")
    }
    
    func testDecodeEnumArray() {
        let result: [TestModel.EnumValue]? = Decoder.decodeEnumArray("enumValueArray")(testJSON!)
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
    
    func testDecodeDateArray() {
        let result: [NSDate]? = Decoder.decodeDateArray("dateArray", dateFormatter: TestModel.dateFormatter)(testJSON!)
        let element1: NSDate = result![0]
        let element2: NSDate = result![1]
        
        let year1: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: element1).year
        let month1: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: element1).month
        let day1: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: element1).day
        let hour1: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: element1).hour
        let minute1: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Minute, fromDate: element1).minute
        let second1: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: element1).second
        let nanosecond1: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Nanosecond, fromDate: element1).nanosecond
        
        let year2: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: element2).year
        let month2: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: element2).month
        let day2: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: element2).day
        let hour2: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: element2).hour
        let minute2: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Minute, fromDate: element2).minute
        let second2: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: element2).second
        let nanosecond2: Int = NSCalendar.currentCalendar().components(NSCalendarUnit.Nanosecond, fromDate: element2).nanosecond
        
        XCTAssertTrue((year1 == 2015), "Decode NSDate array should return correct value")
        XCTAssertTrue((month1 == 8), "Decode NSDate array should return correct value")
        XCTAssertTrue((day1 == 16), "Decode NSDate array should return correct value")
        XCTAssertTrue((hour1 == 20), "Decode NSDate array should return correct value")
        XCTAssertTrue((minute1 == 51), "Decode NSDate array should return correct value")
        XCTAssertTrue((second1 == 46), "Decode NSDate array should return correct value")
        XCTAssertTrue((nanosecond1/1000000 == 599), "Decode NSDate array should return correct value")
        
        XCTAssertTrue((year2 == 2015), "Decode NSDate array should return correct value")
        XCTAssertTrue((month2 == 8), "Decode NSDate array should return correct value")
        XCTAssertTrue((day2 == 16), "Decode NSDate array should return correct value")
        XCTAssertTrue((hour2 == 20), "Decode NSDate array should return correct value")
        XCTAssertTrue((minute2 == 51), "Decode NSDate array should return correct value")
        XCTAssertTrue((second2 == 46), "Decode NSDate array should return correct value")
        XCTAssertTrue((nanosecond2/1000000 == 599), "Decode NSDate array should return correct value")
    }
    
    func testDecodeDateISO8601() {
        let result: NSDate? = Decoder.decodeDateISO8601("dateISO8601")(testJSON!)
        
        let timeInterval = result!.timeIntervalSince1970
        
        XCTAssertTrue(timeInterval == 1439071033, "Decode NSDate should return correct value")
    }
    
    func testDecodeDateISO8601Array() {
        let result: [NSDate]? = Decoder.decodeDateISO8601Array("dateISO8601Array")(testJSON!)
        
        let timeInterval1 = result![0].timeIntervalSince1970
        let timeInterval2 = result![1].timeIntervalSince1970
        
        XCTAssertTrue(timeInterval1 == 1439071033, "Decode NSDate array should return correct value")
        XCTAssertTrue(timeInterval2 == 1439071033, "Decode NSDate array should return correct value")
    }
    
    func testDecodeURL() {
        let result: NSURL? = Decoder.decodeURL("url")(testJSON!)
        
        XCTAssertTrue((result?.absoluteString == "http://github.com"), "Decode NSURL should return correct value")
    }
    
    func testDecodeURLArray() {
        let result: [NSURL]? = Decoder.decodeURLArray("urlArray")(testJSON!)
        let element1: NSURL = result![0]
        let element2: NSURL = result![1]
        let element3: NSURL = result![2]
        
        XCTAssertTrue((element1.absoluteString == "http://github.com"), "Decode NSURL array should return correct value")
        XCTAssertTrue((element2.absoluteString == "http://github.com"), "Decode NSURL array should return correct value")
        XCTAssertTrue((element3.absoluteString == "http://github.com"), "Decode NSURL array should return correct value")
    }
    
}
