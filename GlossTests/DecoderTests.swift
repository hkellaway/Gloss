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
        
        var testJSONPath: NSString = Bundle(for: type(of: self)).path(forResource: "TestModel", ofType: "json")! as NSString
        var testJSONData: Data = try! Data(contentsOf: URL(fileURLWithPath: testJSONPath as String))
        
        do {
            try testJSON = JSONSerialization.jsonObject(with: testJSONData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? JSON
        } catch {
            print(error)
        }
        
        testJSONPath  = Bundle(for: type(of: self)).path(forResource: "TestFailableModelValid", ofType: "json")! as NSString
        testJSONData = try! Data(contentsOf: URL(fileURLWithPath: testJSONPath as String))
        
        do {
            try testFailableModelJSONValid = JSONSerialization.jsonObject(with: testJSONData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? JSON
        } catch {
            print(error)
        }
        
        testJSONPath  = Bundle(for: type(of: self)).path(forResource: "TestFailableModelInvalid", ofType: "json")! as NSString
        testJSONData = try! Data(contentsOf: URL(fileURLWithPath: testJSONPath as String))
        
        do {
            try testFailableModelJSONInvalid = JSONSerialization.jsonObject(with: testJSONData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? JSON
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
        let result: String? = Decoder.decode(key: "invalid")(testJSON!)
        
        XCTAssertTrue((result == nil), "Decode should return nil for invalid value");
    }
    
    func testDecodeBoolArray() {
        let result: [Bool]? = Decoder.decode(key: "boolArray")(testJSON!)
        let element1: Bool = result![0]
        let element2: Bool = result![1]
        let element3: Bool = result![2]
        
        XCTAssertTrue((element1 == true), "Decode Bool array should return correct value")
        XCTAssertTrue((element2 == false), "Decode Bool array should return correct value")
        XCTAssertTrue((element3 == true), "Decode Bool array should return correct value")
    }
    
    func testDecodeBoolArrayReturnsNilIfJSONInvalid() {
        let invalidJSON = [ "array" : ["1", "2", "3"] ]
        let result: [Bool]? = Decoder.decode(key: "array")(invalidJSON as JSON)
        
        XCTAssertNil(result, "Decode bool array should return nil if JSON is invalid")
    }
    
    func testDecodeInt() {
        let result: Int? = Decoder.decode(key: "integer")(testJSON!)
        
        XCTAssertTrue((result == 1), "Decode Int should return correct value")
    }
    
    func testDecodeIntArray() {
        let result: [Int]? = Decoder.decode(key: "integerArray")(testJSON!)
        let element1: Int = result![0]
        let element2: Int = result![1]
        let element3: Int = result![2]
        
        XCTAssertTrue((element1 == 1), "Decode Int array should return correct value")
        XCTAssertTrue((element2 == 2), "Decode Int array should return correct value")
        XCTAssertTrue((element3 == 3), "Decode Int array should return correct value")
    }
    
    func testDecodeIntArrayReturnsNilIfJSONInvalid() {
        let invalidJSON = [ "array" : ["1", "2", "3"] ]
        let result: [Int]? = Decoder.decode(key: "array")(invalidJSON as JSON)
        
        XCTAssertNil(result, "Decode int array should return nil if JSON is invalid")
    }
    
    func testDecodeFloat() {
        let result: Float? = Decoder.decode(key: "float")(testJSON!)
        
        XCTAssertTrue((result == 2.0), "Decode Float should return correct value")
    }
    
    func testDecodeFloatArray() {
        let result: [Float]? = Decoder.decode(key: "floatArray")(testJSON!)
        let element1: Float = result![0]
        let element2: Float = result![1]
        let element3: Float = result![2]
        
        XCTAssertTrue((element1 == 1.0), "Decode Float array should return correct value")
        XCTAssertTrue((element2 == 2.0), "Decode Float array should return correct value")
        XCTAssertTrue((element3 == 3.0), "Decode Float array should return correct value")
    }
    
    func testDecodeFloatArrayReturnsNilIfJSONInvalid() {
        let invalidJSON = [ "array" : ["1", "2", "3"] ]
        let result: [Float]? = Decoder.decode(key: "array")(invalidJSON as JSON)
        
        XCTAssertNil(result, "Decode float array should return nil if JSON is invalid")
    }
    
    func testDecodeDouble() {
        let result: Double? = Decoder.decode(key: "double")(testJSON!)
        
        XCTAssertTrue((result == 6.0), "Decode Double should return correct value")
    }
    
    func testDecodeDoubleArray() {
        let result: [Double]? = Decoder.decode(key: "doubleArray")(testJSON!)
        let element1: Double = result![0]
        let element2: Double = result![1]
        let element3: Double = result![2]
        
        XCTAssertTrue((element1 == 4.0), "Decode Double array should return correct value")
        XCTAssertTrue((element2 == 5.0), "Decode Double array should return correct value")
        XCTAssertTrue((element3 == 6.0), "Decode Double array should return correct value")
    }
    
    func testDecodeDoubleArrayReturnsNilIfJSONInvalid() {
        let invalidJSON = [ "array" : ["1", "2", "3"] ]
        let result: [Double]? = Decoder.decode(key: "array")(invalidJSON as JSON)
        
        XCTAssertNil(result, "Decode double array should return nil if JSON is invalid")
    }
    
    func testDecodeDictionary() {
        let result: [String : TestNestedModel]? = Decoder.decode(decodableDictionaryForKey: "dictionary")(testJSON!)
        let model: TestNestedModel? = result!["otherModel"]

        let id = model!.id
        let name = model!.name
        
        XCTAssertTrue((id == 789), "Decode Dictionary should return correct value")
        XCTAssertTrue((name == "otherModel1"), "Decode Dictionary should return correct value")
    }
    
    func testDecodeDictionaryWithArray() {
        let result: [String : [TestNestedModel]]? = Decoder.decode(decodableDictionaryForKey: "dictionaryWithArray")(testJSON!)
        let model1: TestNestedModel? = result!["otherModels"]![0]
        let model2: TestNestedModel? = result!["otherModels"]![1]
        
        let id1 = model1!.id
        let name1 = model1!.name
        let id2 = model2!.id
        let name2 = model2!.name
        
        XCTAssertTrue((id1 == 123), "Decode Dictionary should return correct value")
        XCTAssertTrue((name1 == "otherModel1"), "Decode Dictionary should return correct value")
        XCTAssertTrue((id2 == 456), "Decode Dictionary should return correct value")
        XCTAssertTrue((name2 == "otherModel2"), "Decode Dictionary should return correct value")
    }
    
    func testDecodeString() {
        let result: String? = Decoder.decode(key: "string")(testJSON!)
        
        XCTAssertTrue((result == "abc"), "Decode String should return correct value")
    }
    
    func testDecodeStringArray() {
        let result: [String]? = Decoder.decode(key: "stringArray")(testJSON!)
        let element1: String = result![0]
        let element2: String = result![1]
        let element3: String = result![2]
        
        XCTAssertTrue((element1 == "def"), "Decode String array should return correct value")
        XCTAssertTrue((element2 == "ghi"), "Decode String array should return correct value")
        XCTAssertTrue((element3 == "jkl"), "Decode String array should return correct value")
    }
    
    func testDecodeStringArrayReturnsNilIfJSONInvalid() {
        let invalidJSON = [ "array" : [1, 2, 3] ]
        let result: [String]? = Decoder.decode(key: "array")(invalidJSON as JSON)
        
        XCTAssertNil(result, "Decode string array should return nil if JSON is invalid")
    }
    
    func testDecodeNestedModel() {
        let result: TestNestedModel? = Decoder.decode(decodableForKey: "nestedModel")(testJSON!)
        
        XCTAssertTrue((result?.id == 123), "Decode nested model should return correct value")
        XCTAssertTrue((result?.name == "nestedModel1"), "Decode nested model should return correct value")
    }
    
    func testDecodeEnumValue() {
        let result: TestModel.EnumValue? = Decoder.decode(enumForKey: "enumValue")(testJSON!)
        
        XCTAssertTrue((result == TestModel.EnumValue.A), "Decode enum value should return correct value")
    }
    
    func testDecodeEnumArray() {
        let result: [TestModel.EnumValue]? = Decoder.decode(enumArrayForKey: "enumValueArray")(testJSON!)
        let element1: TestModel.EnumValue = result![0]
        let element2: TestModel.EnumValue = result![1]
        let element3: TestModel.EnumValue = result![2]
        
        XCTAssertTrue((element1 == TestModel.EnumValue.A), "Decode enum value array should return correct value")
        XCTAssertTrue((element2 == TestModel.EnumValue.B), "Decode enum value array should return correct value")
        XCTAssertTrue((element3 == TestModel.EnumValue.C), "Decode enum value array should return correct value")
    }
    
    func testDecodeEnumArrayReturnsNilIfJSONInvalid() {
        let invalidJSON = [ "array" : ["1", "2", "3"] ]
        let result: [TestModel.EnumValue]? = Decoder.decode(enumArrayForKey: "array")(invalidJSON as JSON)
        
        XCTAssertNil(result, "Decode enum array should return nil if JSON is invalid")
    }
    
    func testDecodeDate() {
        let result: Date? = Decoder.decode(dateForKey: "date", dateFormatter: TestModel.dateFormatter)(testJSON!)
        
        let year: Int = (Calendar.current as NSCalendar).components(.year, from: result!).year!
        let month: Int = (Calendar.current as NSCalendar).components(.month, from: result!).month!
        let day: Int = (Calendar.current as NSCalendar).components(.day, from: result!).day!
        let hour: Int = (Calendar.current as NSCalendar).components(.hour, from: result!).hour!
        let minute: Int = (Calendar.current as NSCalendar).components(.minute, from: result!).minute!
        let second: Int = (Calendar.current as NSCalendar).components(.second, from: result!).second!
        let nanosecond: Int = (Calendar.current as NSCalendar).components(.nanosecond, from: result!).nanosecond!
        
        XCTAssertTrue((year == 2015), "Decode NSDate should return correct value")
        XCTAssertTrue((month == 8), "Decode NSDate should return correct value")
        XCTAssertTrue((day == 16), "Decode NSDate should return correct value")
        XCTAssertTrue((hour == 20), "Decode NSDate should return correct value")
        XCTAssertTrue((minute == 51), "Decode NSDate should return correct value")
        XCTAssertTrue((second == 46), "Decode NSDate should return correct value")
        XCTAssertTrue((nanosecond/1000000 == 599), "Decode NSDate should return correct value")
    }
    
    func testDecodeDateArray() {
        let result: [Date]? = Decoder.decode(dateArrayForKey: "dateArray", dateFormatter: TestModel.dateFormatter)(testJSON!)
        let element1: Date = result![0]
        let element2: Date = result![1]
        
        let year1: Int = (Calendar.current as NSCalendar).components(.year, from: element1).year!
        let month1: Int = (Calendar.current as NSCalendar).components(.month, from: element1).month!
        let day1: Int = (Calendar.current as NSCalendar).components(.day, from: element1).day!
        let hour1: Int = (Calendar.current as NSCalendar).components(.hour, from: element1).hour!
        let minute1: Int = (Calendar.current as NSCalendar).components(.minute, from: element1).minute!
        let second1: Int = (Calendar.current as NSCalendar).components(.second, from: element1).second!
        let nanosecond1: Int = (Calendar.current as NSCalendar).components(.nanosecond, from: element1).nanosecond!
        
        let year2: Int = (Calendar.current as NSCalendar).components(.year, from: element2).year!
        let month2: Int = (Calendar.current as NSCalendar).components(.month, from: element2).month!
        let day2: Int = (Calendar.current as NSCalendar).components(.day, from: element2).day!
        let hour2: Int = (Calendar.current as NSCalendar).components(.hour, from: element2).hour!
        let minute2: Int = (Calendar.current as NSCalendar).components(.minute, from: element2).minute!
        let second2: Int = (Calendar.current as NSCalendar).components(.second, from: element2).second!
        let nanosecond2: Int = (Calendar.current as NSCalendar).components(.nanosecond, from: element2).nanosecond!
        
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
    
    func testDecodeDateArrayReturnsNilIfJSONInvalid() {
        let invalidJSON = [ "array" : ["1", "2", "3"] ]
        let result: [Date]? = Decoder.decode(dateArrayForKey: "array", dateFormatter: TestModel.dateFormatter)(invalidJSON as JSON)
        
        XCTAssertNil(result, "Decode date array should return nil if JSON is invalid")
    }
    
    func testDecodeDateISO8601() {
        let result: Date? = Decoder.decode(dateISO8601ForKey: "dateISO8601")(testJSON!)
        
        let timeInterval = result!.timeIntervalSince1970
        
        XCTAssertTrue(timeInterval == 1439071033, "Decode NSDate should return correct value")
    }
    
    func testDecodeDateISO8601Array() {
        let result: [Date]? = Decoder.decode(dateISO8601ArrayForKey: "dateISO8601Array")(testJSON!)
        
        let timeInterval1 = result![0].timeIntervalSince1970
        let timeInterval2 = result![1].timeIntervalSince1970
        
        XCTAssertTrue(timeInterval1 == 1439071033, "Decode NSDate array should return correct value")
        XCTAssertTrue(timeInterval2 == 1439071033, "Decode NSDate array should return correct value")
    }

    func testDecodeDateISO8601ArrayArrayReturnsNilIfJSONInvalid() {
        let invalidJSON = [ "array" : ["1", "2", "3"] ]
        let result: [Date]? = Decoder.decode(dateISO8601ArrayForKey: "array")(invalidJSON as JSON)
        
        XCTAssertNil(result, "Decode NSDate array should return nil if JSON is invalid")
    }
    
    func testDecodeInt32() {
        let result: Int32? = Decoder.decode(int32ForKey: "int32")(testJSON!)
        
        XCTAssertTrue((result == 100000000), "Decode Int32 should return correct value")
    }
    
    func testDecodeInt32Array() {
        let result: [Int32]? = Decoder.decode(int32ArrayForKey: "int32Array")(testJSON!)
        
        XCTAssertTrue((result! == [100000000, -2147483648, 2147483647]), "Decode Int32 array should return correct value")
    }
    
    func testDecodeInt32ArrayReturnsNilIfJSONInvalid() {
        let invalidJSON = [ "array" : ["1", "2", "3"] ]
        let result: [Int32]? = Decoder.decode(int32ArrayForKey: "array")(invalidJSON as JSON)
        
        XCTAssertNil(result, "Decode Int32 array should return nil if JSON is invalid")
    }

	func testDecodeUInt32() {
        let result: UInt32? = Decoder.decode(uint32ForKey: "uInt32")(testJSON!)

		XCTAssertTrue((result == 4294967295), "Decode UInt32 should return correct value")
	}

	func testDecodeUInt32Array() {
        let result: [UInt32]? = Decoder.decode(uint32ArrayForKey: "uInt32Array")(testJSON!)

		XCTAssertTrue((result! == [100000000, 2147483648, 4294967295]), "Decode UInt32 array should return correct value")
	}
    
    func testDecodeUInt32ArrayReturnsNilIfJSONInvalid() {
        let invalidJSON = [ "array" : ["1", "2", "3"] ]
        let result: [UInt32]? = Decoder.decode(uint32ArrayForKey: "array")(invalidJSON as JSON)
        
        XCTAssertNil(result, "Decode UInt32 array should return nil if JSON is invalid")
    }

    func testDecodeInt64() {
        let result: Int64? = Decoder.decode(int64ForKey: "int64")(testJSON!)
        
        XCTAssertTrue((result == 300000000), "Decode Int64 should return correct value")
    }
    
    func testDecodeInt64Array() {
        let result: [Int64]? = Decoder.decode(int64ArrayForKey: "int64Array")(testJSON!)
        
        XCTAssertTrue((result! == [300000000, -9223372036854775808, 9223372036854775807]), "Decode Int64 array should return correct value")
    }
    
    func testDecodeInt64ArrayReturnsNilIfJSONInvalid() {
        let invalidJSON = [ "array" : ["1", "2", "3"] ]
        let result: [Int64]? = Decoder.decode(int64ArrayForKey: "array")(invalidJSON as JSON)
        
        XCTAssertNil(result, "Decode Int64 array should return nil if JSON is invalid")
    }

	func testDecodeUInt64() {
        let result: UInt64? = Decoder.decode(uint64ForKey: "uInt64")(testJSON!)

		XCTAssertTrue((result == 18446744073709551615), "Decode UInt64 should return correct value")
	}

	func testDecodeUInt64Array() {
        let result: [UInt64]? = Decoder.decode(uint64ArrayForKey: "uInt64Array")(testJSON!)

		XCTAssertTrue((result! == [300000000, 9223372036854775808, 18446744073709551615]), "Decode UInt64 array should return correct value")
	}
    
    func testDecodeUInt64ArrayReturnsNilIfJSONInvalid() {
        let invalidJSON = [ "array" : ["1", "2", "3"] ]
        let result: [UInt64]? = Decoder.decode(uint64ArrayForKey: "array")(invalidJSON as JSON)
        
        XCTAssertNil(result, "Decode UInt64 array should return nil if JSON is invalid")
    }

    func testDecodeURL() {
        let result: URL? = Decoder.decode(urlForKey: "url")(testJSON!)
        
        XCTAssertTrue((result?.absoluteString == "http://github.com"), "Decode NSURL should return correct value")
    }
    
    func testDecodeURLArray() {
        let result: [URL]? = Decoder.decode(urlArrayForKey: "urlArray")(testJSON!)
        let element1: URL = result![0]
        let element2: URL = result![1]
        let element3: URL = result![2]
        
        XCTAssertTrue((element1.absoluteString == "http://github.com"), "Decode NSURL array should return correct value")
        XCTAssertTrue((element2.absoluteString == "http://github.com"), "Decode NSURL array should return correct value")
        XCTAssertTrue((element3.absoluteString == "http://github.com"), "Decode NSURL array should return correct value")
    }
    
    func testDecodeURLArrayReturnsNilIfJSONInvalid() {
        let invalidJSON = [ "array" : [1, 1, 1] ]
        let result: [URL]? = Decoder.decode(urlArrayForKey: "array")(invalidJSON as JSON)
        
        XCTAssertNil(result, "Decode url array should return nil if JSON is invalid")
    }
    
}
