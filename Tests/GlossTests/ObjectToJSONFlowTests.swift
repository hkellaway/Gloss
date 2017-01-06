//
//  ObjectToJSONFlowTests.swift
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

import Foundation
import Gloss
import XCTest

class ObjectToJSONFlowTests: XCTestCase {
    
    static var allTests : [(String, (ObjectToJSONFlowTests) -> () throws -> Void)] {
        return [
            ("testObjectEncodedToJSONHasCorrectProperties", testObjectEncodedToJSONHasCorrectProperties)
        ]
    }

    var testModel: TestModel?
    
    override func setUp() {
        super.setUp()
        
        let json: JSON = [
            "bool" : true,
            "boolArray" : [true, false, true],
            "integer" : 1,
            "integerArray" : [1, 2, 3],
            "float" : Float(2.0),
            "floatArray" : [Float(1.0), Float(2.0), Float(3.0)],
            "double" : 6.0,
            "doubleArray" : [4.0, 5.0, 6.0],
            "dictionary" : [
                "otherModel" : [
                    "id" : 1,
                    "name" : "nestedModel1"
                ]
            ],
            "dictionaryWithArray" : [
                "otherModels" : [
                    [
                        "id" : 123,
                        "name" : "otherModel1"
                    ],
                    [
                        "id" : 456,
                        "name" : "otherModel2"
                    ]
                ]
            ],
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
            "dateArray" : ["2015-08-16T20:51:46.600Z", "2015-08-16T20:51:46.600Z"],
            "dateISO8601" : "2015-08-08T21:57:13Z",
            "dateISO8601Array" : ["2015-08-08T21:57:13Z", "2015-08-08T21:57:13Z"],
            "int32" : 100000000,
            "int32Array" : [100000000, 100000000, 100000000],
            "int64" : 300000000,
            "int64Array" : [300000000, 300000000, 300000000],
            "url" : "http://github.com",
            "urlArray" : ["http://github.com", "http://github.com"],
            "uuid" : "964F2FE2-0F78-4C2D-A291-03058C0B98AB",
            "uuidArray" : ["572099C2-B9AA-42AA-8A25-66E3F3056271", "54DB8DCF-F68D-4B55-A3FC-EB8CF4C36B06", "982CED72-743A-45F8-87CF-278386D32EBF"]
        ]
        
        testModel = TestModel(json: json)
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
        #if !os(Linux)
        XCTAssertTrue(((result!["int32Array"] as! [NSNumber]) == [100000000, 100000000, 100000000]), "JSON created from model should have correct values")
        XCTAssertTrue(((result!["int32"] as! NSNumber).int32Value == 100000000), "JSON created from model should have correct values")
        XCTAssertTrue(((result!["int64"] as! NSNumber).int64Value == 300000000), "JSON created from model should have correct values")
        XCTAssertTrue(((result!["int64Array"] as! [NSNumber]) == [300000000, 300000000, 300000000]), "JSON created from model should have correct values")
        #endif
        XCTAssertTrue(((result!["date"] as! String) == "2015-08-16T20:51:46.600Z"), "JSON created from model should have correct values")
        XCTAssertTrue(result!["dateArray"] as! [String] == ["2015-08-16T20:51:46.600Z", "2015-08-16T20:51:46.600Z"], "JSON created from model should have correct values")
        
        let dateISO8601 = result!["dateISO8601"] as! String
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let resultDate = dateFormatter.date(from: dateISO8601)
        
        XCTAssertTrue(resultDate?.timeIntervalSince1970 == 1439071033, "JSON created from model should have correct values")
        
        let dateISO8601Array = result!["dateISO8601Array"] as! [String]
        let resultDate8601Array = dateISO8601Array.map { date in dateFormatter.date(from: date)!.timeIntervalSince1970 }
        
        XCTAssertTrue(resultDate8601Array == [1439071033, 1439071033], "JSON created from model should have correct values")
        
        XCTAssertTrue((result!["url"] as! String == "http://github.com"), "JSON created from model should have correct values")
        XCTAssertTrue(((result!["urlArray"] as! [URL]).map { url in url.absoluteString } == ["http://github.com", "http://github.com"]), "JSON created from model should have correct values")
        
        XCTAssertTrue((result!["uuid"] as! String == "964F2FE2-0F78-4C2D-A291-03058C0B98AB"), "JSON created from model should have correct values")
        XCTAssertTrue(((result!["uuidArray"] as! [UUID]).map { uuid in uuid.uuidString } == ["572099C2-B9AA-42AA-8A25-66E3F3056271", "54DB8DCF-F68D-4B55-A3FC-EB8CF4C36B06", "982CED72-743A-45F8-87CF-278386D32EBF"]), "JSON created from model should have correct values")

        let otherModel = (result!["dictionary"] as! [String : JSON])["otherModel"]!
        
        XCTAssertTrue(otherModel["id"] as! Int == 1, "Encode encodable dictionary should return correct value")
        XCTAssertTrue(otherModel["name"] as! String == "nestedModel1", "Encode encodable dictionary should return correct value")
        
        let anotherModel1 = (result!["dictionaryWithArray"] as! [String : [JSON]])["otherModels"]![0]
        let anotherModel2 = (result!["dictionaryWithArray"] as! [String : [JSON]])["otherModels"]![1]
        
        XCTAssertTrue(anotherModel1["id"] as! Int == 123, "Encode encodable dictionary should return correct value")
        XCTAssertTrue(anotherModel1["name"] as! String == "otherModel1", "Encode encodable dictionary should return correct value")
        XCTAssertTrue(anotherModel2["id"] as! Int == 456, "Encode encodable dictionary should return correct value")
        XCTAssertTrue(anotherModel2["name"] as! String == "otherModel2", "Encode encodable dictionary should return correct value")
        
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
