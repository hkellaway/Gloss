//
//  GlossTests.swift
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

class GlossTests: XCTestCase {
    
    var testJSONArray: [JSON]? = []
    var testModels: [TestModel]? = nil
    var testModelsJSON: JSON? = nil
    
    override func setUp() {
        super.setUp()
        
        var testJSON: JSON? = [:]
        let testJSONPath: NSString = NSBundle(forClass: self.dynamicType).pathForResource("TestModel", ofType: "json")!
        let testJSONData: NSData = NSData(contentsOfFile: testJSONPath as String)!
        
        do {
            try testJSON = NSJSONSerialization.JSONObjectWithData(testJSONData, options: NSJSONReadingOptions(rawValue: 0)) as? JSON
        } catch {
            print(error)
        }
        
        testJSONArray = [testJSON!, testJSON!]
        
        testModelsJSON = [
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
        ]
        
        let model = TestModel(json: testModelsJSON!)
        testModels = [model!, model!]
    }
    
    override func tearDown() {
        testJSONArray = nil
        testModels = nil
        testModelsJSON = nil
        
        super.tearDown()
    }
    
    func testDateFormatterISO8601HasCorrectSetup() {
        let dateFormatterISO8601 = GlossDateFormatterISO8601()
        
        XCTAssertTrue(dateFormatterISO8601.locale.localeIdentifier == "en_US_POSIX", "Date formatter ISO8601 should have correct locale.")
        XCTAssertTrue(dateFormatterISO8601.dateFormat == "yyyy-MM-dd'T'HH:mm:ssZZZZZ", "Date formatter ISO8601 should have correct date format.")
    }
    
    func testJsonifyTurnsArrayOfJsonDictsToSingleJsonDict() {
        let jsonDict1: JSON? = ["a" : true, "b" : false]
        let jsonDict2: JSON? = ["d" : "e", "f" : "g"]
        let jsonDict3: JSON? = ["j" : 1, "k" : 2]
        
        let result = jsonify([jsonDict1, jsonDict2, jsonDict3])
        
        XCTAssertTrue((result!.count == 6), "jsonify should turn array of JSON dictionaries to a single JSON dictionary")
        XCTAssertTrue((result!["a"] as! Bool == true), "jsonify should turn array of JSON dictionaries to a single JSON dictionary")
        XCTAssertTrue((result!["b"] as! Bool == false), "jsonify should turn array of JSON dictionaries to a single JSON dictionary")
        XCTAssertTrue((result!["d"] as! String == "e"), "jsonify should turn array of JSON dictionaries to a single JSON dictionary")
        XCTAssertTrue((result!["f"] as! String == "g"), "jsonify should turn array of JSON dictionaries to a single JSON dictionary")
        XCTAssertTrue((result!["j"] as! Int == 1), "jsonify should turn array of JSON dictionaries to a single JSON dictionary")
        XCTAssertTrue((result!["k"] as! Int == 2), "jsonify should turn array of JSON dictionaries to a single JSON dictionary")
    }
    
    func testModelsFromJSONArrayProducesValidModels() {
        let result = [TestModel].fromJSONArray(testJSONArray!)
        let model1: TestModel = result[0]
        let model2: TestModel = result[1]
        
        XCTAssertTrue((model1.bool == true), "Model created from JSON should have correct property values")
        XCTAssertTrue((model1.boolArray! == [true, false, true]), "Model created from JSON should have correct property values")
        XCTAssertTrue((model1.integer == 1), "Model created from JSON should have correct property values")
        XCTAssertTrue((model1.integerArray! == [1, 2, 3]), "Model created from JSON should have correct property values")
        XCTAssertTrue((model1.float == 2.0), "Model created from JSON should have correct property values")
        XCTAssertTrue((model1.floatArray! == [1.0, 2.0, 3.0]), "Model created from JSON should have correct property values")
        XCTAssertTrue((model1.double == 6.0), "Model created from JSON should have correct property values")
        XCTAssertTrue((model1.doubleArray! == [4.0, 5.0, 6.0]), "Model created from JSON should have correct property values")
        XCTAssertTrue((model1.string == "abc"), "Model created from JSON should have correct property values")
        XCTAssertTrue((model1.stringArray! == ["def", "ghi", "jkl"]), "Model created from JSON should have correct property values")
        XCTAssertTrue((model1.enumValue == TestModel.EnumValue.A), "Model created from JSON should have correct property values")
        XCTAssertTrue((model1.enumValueArray! == [TestModel.EnumValue.A, TestModel.EnumValue.B, TestModel.EnumValue.C]), "Model created from JSON should have correct property values")
        XCTAssertTrue((TestModel.dateFormatter.stringFromDate(model1.date!) == "2015-08-16T20:51:46.600Z"), "Model created from JSON should have correct property values")
        XCTAssertTrue((model1.dateISO8601 == NSDate(timeIntervalSince1970: 1439071033)), "Model created from JSON should have correct property values")
        XCTAssertTrue((model1.url?.absoluteString == "http://github.com"), "Model created from JSON should have correct property values")
        
        XCTAssertTrue((model1.nestedModel?.id == 123), "Model created from JSON should have correct property values")
        XCTAssertTrue((model1.nestedModel?.name == "nestedModel1"), "Model created from JSON should have correct property values")
        
        let nestedModel2: TestNestedModel = model1.nestedModelArray![0]
        let nestedModel3: TestNestedModel = model1.nestedModelArray![1]
        XCTAssertTrue((nestedModel2.id == 456), "Model created from JSON should have correct property values")
        XCTAssertTrue((nestedModel2.name == "nestedModel2"), "Model created from JSON should have correct property values")
        XCTAssertTrue((nestedModel3.id == 789), "Model created from JSON should have correct property values")
        XCTAssertTrue((nestedModel3.name == "nestedModel3"), "Model created from JSON should have correct property values")
        
        
        XCTAssertTrue((model2.bool == true), "Model created from JSON should have correct property values")
        XCTAssertTrue((model2.boolArray! == [true, false, true]), "Model created from JSON should have correct property values")
        XCTAssertTrue((model2.integer == 1), "Model created from JSON should have correct property values")
        XCTAssertTrue((model2.integerArray! == [1, 2, 3]), "Model created from JSON should have correct property values")
        XCTAssertTrue((model2.float == 2.0), "Model created from JSON should have correct property values")
        XCTAssertTrue((model2.floatArray! == [1.0, 2.0, 3.0]), "Model created from JSON should have correct property values")
        XCTAssertTrue((model2.double == 6.0), "Model created from JSON should have correct property values")
        XCTAssertTrue((model2.doubleArray! == [4.0, 5.0, 6.0]), "Model created from JSON should have correct property values")
        XCTAssertTrue((model2.string == "abc"), "Model created from JSON should have correct property values")
        XCTAssertTrue((model2.stringArray! == ["def", "ghi", "jkl"]), "Model created from JSON should have correct property values")
        XCTAssertTrue((model2.enumValue == TestModel.EnumValue.A), "Model created from JSON should have correct property values")
        XCTAssertTrue((model2.enumValueArray! == [TestModel.EnumValue.A, TestModel.EnumValue.B, TestModel.EnumValue.C]), "Model created from JSON should have correct property values")
        XCTAssertTrue((TestModel.dateFormatter.stringFromDate(model1.date!) == "2015-08-16T20:51:46.600Z"), "Model created from JSON should have correct property values")
        XCTAssertTrue((model2.dateISO8601 == NSDate(timeIntervalSince1970: 1439071033)), "Model created from JSON should have correct property values")
        XCTAssertTrue((model2.url?.absoluteString == "http://github.com"), "Model created from JSON should have correct property values")
        
        XCTAssertTrue((model2.nestedModel?.id == 123), "Model created from JSON should have correct property values")
        XCTAssertTrue((model2.nestedModel?.name == "nestedModel1"), "Model created from JSON should have correct property values")
        
        let nestedModel4: TestNestedModel = model2.nestedModelArray![0]
        let nestedModel5: TestNestedModel = model2.nestedModelArray![1]
        XCTAssertTrue((nestedModel4.id == 456), "Model created from JSON should have correct property values")
        XCTAssertTrue((nestedModel4.name == "nestedModel2"), "Model created from JSON should have correct property values")
        XCTAssertTrue((nestedModel5.id == 789), "Model created from JSON should have correct property values")
        XCTAssertTrue((nestedModel5.name == "nestedModel3"), "Model created from JSON should have correct property values")
    }
    
    func testModelsFromJSONArrayOnlyIncludesValidModels() {
        testJSONArray![0].removeValueForKey("bool")
        
        let result = [TestModel].fromJSONArray(testJSONArray!)
        
        XCTAssertTrue(result.count == 1, "Model array from JSON array should only include valid models")
    }
    
    func testJSONArrayFromModelsProducesValidJSON() {
        let result = testModels!.toJSONArray()
        let json1 = result![0]
        let json2 = result![1]
        
        XCTAssertTrue((json1["bool"] as! Bool == true), "JSON created from model should have correct values")
        XCTAssertTrue((json1["boolArray"] as! [Bool] == [true, false, true]), "JSON created from model should have correct values")
        XCTAssertTrue((json1["integer"] as! Int == 1), "JSON created from model should have correct values")
        XCTAssertTrue((json1["integerArray"] as! [Int] == [1, 2, 3]), "JSON created from model should have correct values")
        XCTAssertTrue((json1["float"] as! Float == 2.0), "JSON created from model should have correct values")
        XCTAssertTrue((json1["floatArray"] as! [Float] == [1.0, 2.0, 3.0]), "JSON created from model should have correct values")
        XCTAssertTrue((json1["double"] as! Double == 6.0), "JSON created from model should have correct values")
        XCTAssertTrue((json1["doubleArray"] as! [Double] == [4.0, 5.0, 6.0]), "JSON created from model should have correct values")
        XCTAssertTrue((json1["string"] as! String == "abc"), "JSON created from model should have correct values")
        XCTAssertTrue((json1["stringArray"] as! [String] == ["def", "ghi", "jkl"]), "JSON created from model should have correct values")
        XCTAssertTrue((json1["enumValue"] as! String == "A"), "JSON created from model should have correct values")
        XCTAssertTrue((json1["enumValueArray"] as! [String] == ["A", "B", "C"]), "JSON created from model should have correct values")
        XCTAssertTrue(((json1["date"] as! String) == "2015-08-16T20:51:46.600Z"), "JSON created from model should have correct values")
        
        let dateISO8601 = json1["dateISO8601"] as! String
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let resultDate = dateFormatter.dateFromString(dateISO8601)
        
        XCTAssertTrue(resultDate?.timeIntervalSince1970 == 1439071033, "JSON created from model should have correct values")
        
        XCTAssertTrue((json1["url"] as! String == "http://github.com"), "JSON created from model should have correct values")
        
        let nestedModel: JSON = json1["nestedModel"] as! JSON
        
        XCTAssertTrue((nestedModel["id"] as! Int == 123), "Encode nested model should return correct value")
        XCTAssertTrue((nestedModel["name"] as! String == "nestedModel1"), "Encode nested model should return correct value")
        
        let nestedModelsJSON: [JSON] = json1["nestedModelArray"] as! [JSON]
        let nestedModel2JSON: JSON = nestedModelsJSON[0]
        let nestedModel3JSON: JSON = nestedModelsJSON[1]
        
        XCTAssertTrue((nestedModel2JSON["id"] as! Int == 456), "Encode nested model array should return correct value")
        XCTAssertTrue((nestedModel2JSON["name"] as! String == "nestedModel2"), "Encode nested model array should return correct value")
        XCTAssertTrue((nestedModel3JSON["id"] as! Int == 789), "Encode nested model array should return correct value")
        XCTAssertTrue((nestedModel3JSON["name"] as! String == "nestedModel3"), "Encode nested model array should return correct value")
        
        
        XCTAssertTrue((json2["bool"] as! Bool == true), "JSON created from model should have correct values")
        XCTAssertTrue((json2["boolArray"] as! [Bool] == [true, false, true]), "JSON created from model should have correct values")
        XCTAssertTrue((json2["integer"] as! Int == 1), "JSON created from model should have correct values")
        XCTAssertTrue((json2["integerArray"] as! [Int] == [1, 2, 3]), "JSON created from model should have correct values")
        XCTAssertTrue((json2["float"] as! Float == 2.0), "JSON created from model should have correct values")
        XCTAssertTrue((json2["floatArray"] as! [Float] == [1.0, 2.0, 3.0]), "JSON created from model should have correct values")
        XCTAssertTrue((json2["double"] as! Double == 6.0), "JSON created from model should have correct values")
        XCTAssertTrue((json2["doubleArray"] as! [Double] == [4.0, 5.0, 6.0]), "JSON created from model should have correct values")
        XCTAssertTrue((json2["string"] as! String == "abc"), "JSON created from model should have correct values")
        XCTAssertTrue((json2["stringArray"] as! [String] == ["def", "ghi", "jkl"]), "JSON created from model should have correct values")
        XCTAssertTrue((json2["enumValue"] as! String == "A"), "JSON created from model should have correct values")
        XCTAssertTrue((json2["enumValueArray"] as! [String] == ["A", "B", "C"]), "JSON created from model should have correct values")
        XCTAssertTrue(((json2["date"] as! String) == "2015-08-16T20:51:46.600Z"), "JSON created from model should have correct values")
        
        let date2ISO8601 = json2["dateISO8601"] as! String
        let date2Formatter = NSDateFormatter()
        date2Formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        date2Formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let resultDate2 = dateFormatter.dateFromString(date2ISO8601)
        
        XCTAssertTrue(resultDate2?.timeIntervalSince1970 == 1439071033, "JSON created from model should have correct values")
        
        XCTAssertTrue((json2["url"] as! String == "http://github.com"), "JSON created from model should have correct values")
        
        let nestedModel2: JSON = json2["nestedModel"] as! JSON
        
        XCTAssertTrue((nestedModel2["id"] as! Int == 123), "Encode nested model should return correct value")
        XCTAssertTrue((nestedModel2["name"] as! String == "nestedModel1"), "Encode nested model should return correct value")
        
        let nestedModelsJSON2: [JSON] = json2["nestedModelArray"] as! [JSON]
        let nestedModel4JSON: JSON = nestedModelsJSON2[0]
        let nestedModel5JSON: JSON = nestedModelsJSON2[1]
        
        XCTAssertTrue((nestedModel4JSON["id"] as! Int == 456), "Encode nested model array should return correct value")
        XCTAssertTrue((nestedModel4JSON["name"] as! String == "nestedModel2"), "Encode nested model array should return correct value")
        XCTAssertTrue((nestedModel5JSON["id"] as! Int == 789), "Encode nested model array should return correct value")
        XCTAssertTrue((nestedModel5JSON["name"] as! String == "nestedModel3"), "Encode nested model array should return correct value")
        
    }
    
    func testJSONArrayFromModelsOnlyIncludesJSONFromValidModels() {
        var invalidJSON = testModelsJSON!
        invalidJSON.removeValueForKey("bool")
        var jsonArray = testJSONArray!
        jsonArray.append(invalidJSON)
        let result = [TestModel].fromJSONArray(jsonArray)
        
        XCTAssertTrue(result.count == 2, "Model array from JSON array should only include valid models")
    }
    
    func testJsonifyTurnsJSONOptionalArrayToSingleJSONOptional() {
        let json1 = ["test1" : 1 ]
        let json2 = ["test2" : 2 ]
        let result = jsonify([json1, json2])
        
        XCTAssertTrue(result!["test1"] as! Int == 1, "Jsonify should turn JSON optional array to single JSON optional")
        XCTAssertTrue(result!["test2"] as! Int == 2, "Jsonify should turn JSON optional array to single JSON optional")
    }
    
    func testJsonifyReturnsEmptyJSONWhenGivenEmptyArray() {
        let result = jsonify([])
        
        XCTAssertTrue(result!.isEmpty, "Jsonify should return empty JSON when given an empty array")
    }
    
    func testDefaultKeyPathDelimiterIsAPeriod() {
        XCTAssertTrue(GlossKeyPathDelimiter() == ".", "Deafult key path delimiter should be a period")
    }
    
}
