//
//  OperatorTests.swift
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

class OperatorTests: XCTestCase {
    
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
    
    func testDecodeOperatorForInvalidReturnsDecoderDecode() {
        let resultInvalid: String? = "invalid" <~~ testJSON!
        let decoderResultInvalid: String? = Decoder.decode("invalid")(testJSON!)
        
        XCTAssertTrue((resultInvalid == decoderResultInvalid), "<~~ for invalid value should return same as Decoder.decode")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecode() {
        let resultBool: Bool? = "bool" <~~ testJSON!
        let decoderResultBool: Bool? = Decoder.decode("bool")(testJSON!)
        let resultBoolArray: [Bool]? = "boolArray" <~~ testJSON!
        let decoderResultBoolArray: [Bool]? = Decoder.decode("boolArray")(testJSON!)
        let resultInt: Int? = "integer" <~~ testJSON!
        let decoderResultInt: Int? = Decoder.decode("integer")(testJSON!)
        let resultIntArray: [Int]? = "integerArray" <~~ testJSON!
        let decoderResultIntArray: [Int]? = Decoder.decode("integerArray")(testJSON!)
        let resultFloat: Float? = "float" <~~ testJSON!
        let decoderResultFloat: Float? = Decoder.decode("float")(testJSON!)
        let resultFloatArray: [Float]? = "floatArray" <~~ testJSON!
        let decoderResultFloatArray: [Float]? = Decoder.decode("floatArray")(testJSON!)
        let resultDouble: Double? = "double" <~~ testJSON!
        let decoderResultDouble: Double? = Decoder.decode("double")(testJSON!)
        let resultDoubleArray: [Double]? = "doubleArray" <~~ testJSON!
        let decoderResultDoubleArray: [Double]? = Decoder.decode("doubleArray")(testJSON!)
        let resultString: String? = "string" <~~ testJSON!
        let decoderResultString: String? = Decoder.decode("string")(testJSON!)
        let resultStringArray: [String]? = "stringArray" <~~ testJSON!
        let decoderResultStringArray: [String]? = Decoder.decode("stringArray")(testJSON!)
        
        XCTAssertTrue((resultBool == decoderResultBool), "<~~ for generic value should return same as Decoder.decode")
        XCTAssertTrue((resultBoolArray! == decoderResultBoolArray!), "<~~ for generic value should return same as Decoder.decode")
        XCTAssertTrue((resultInt == decoderResultInt), "<~~ for generic value should return same as Decoder.decode")
        XCTAssertTrue((resultIntArray! == decoderResultIntArray!), "<~~ for generic value should return same as Decoder.decode")
        XCTAssertTrue((resultFloat == decoderResultFloat), "<~~ for generic value should return same as Decoder.decode")
        XCTAssertTrue((resultFloatArray! == decoderResultFloatArray!), "<~~ for generic value should return same as Decoder.decode")
        XCTAssertTrue((resultDouble == decoderResultDouble), "<~~ for generic value should return same as Decoder.decode")
        XCTAssertTrue((resultDoubleArray! == decoderResultDoubleArray!), "<~~ for generic value should return same as Decoder.decode")
        XCTAssertTrue((resultString == decoderResultString), "<~~ for generic value should return same as Decoder.decode")
        XCTAssertTrue((resultStringArray! == decoderResultStringArray!), "<~~ for generic value should return same as Decoder.decode")
    }
    
    func testDecodeOperatorDecodableReturnsDecoderDecode() {
        let resultNestedModel: TestNestedModel? = "nestedModel" <~~ testJSON!
        let decoderResultNestedModel: TestNestedModel? = Decoder.decode("nestedModel")(testJSON!)
        
        XCTAssertTrue((resultNestedModel!.id == decoderResultNestedModel!.id), "<~~ for Decodable models should return same as Decoder.decode")
        XCTAssertTrue((resultNestedModel!.name == decoderResultNestedModel!.name), "<~~ for Decodable models should return same as Decoder.decode")
    }
    
    func testDecodeOperatorDecodableArrayReturnsDecoderDecodeArray() {
        let result: [TestNestedModel]? = "nestedModelArray" <~~ testJSON!
        let resultElement1: TestNestedModel = result![0]
        let resultElement2: TestNestedModel = result![1]
        let decoderResult: [TestNestedModel]? = Decoder.decodeArray("nestedModelArray")(testJSON!)
        let decoderResultElement1: TestNestedModel = decoderResult![0]
        let decoderResultElement2: TestNestedModel = decoderResult![1]
        
        XCTAssertTrue((resultElement1.id == decoderResultElement1.id), "<~~ for Decodable models array should return same as Decoder.decodeArray")
        XCTAssertTrue((resultElement1.name == decoderResultElement1.name), "<~~ for Decodable models array should return same as Decoder.decodeArray")
        XCTAssertTrue((resultElement2.id == decoderResultElement2.id), "<~~ for Decodable models array should return same as Decoder.decodeArray")
        XCTAssertTrue((resultElement2.name == decoderResultElement2.name), "<~~ for Decodable models array should return same as Decoder.decodeArray")
    }
    
    func testDecodeOperatorEnumValueReturnsDecoderDecodeEnum() {
        let result: TestModel.EnumValue? = "enumValue" <~~ testJSON!
        let decoderResult: TestModel.EnumValue? = Decoder.decodeEnum("enumValue")(testJSON!)
        
        XCTAssertTrue((result == decoderResult), "<~~ for enum value should return same as Decoder.decodeEnum")
    }
    
    func testDecodeOperatorEnumValueArrayReturnsDecoderDecodeArray() {
        let result: [TestModel.EnumValue]? = "enumValueArray" <~~ testJSON!
        let resultElement1: TestModel.EnumValue = result![0]
        let resultElement2: TestModel.EnumValue = result![1]
        let resultElement3: TestModel.EnumValue = result![2]
        let decoderResult: [TestModel.EnumValue]? = Decoder.decodeArray("enumValueArray")(testJSON!)
        let decoderResultElement1: TestModel.EnumValue = decoderResult![0]
        let decoderResultElement2: TestModel.EnumValue = decoderResult![1]
        let decoderResultElement3: TestModel.EnumValue = decoderResult![2]
        
        XCTAssertTrue((resultElement1 == decoderResultElement1), "<~~ for enum value array should return same as Decoder.decodeArray")
        XCTAssertTrue((resultElement2 == decoderResultElement2), "<~~ for enum value array should return same as Decoder.decodeArray")
        XCTAssertTrue((resultElement3 == decoderResultElement3), "<~~ for enum value array should return same as Decoder.decodeArray")
    }
    
    func testDecodeOperatorURLReturnsDecoderDecodeURL() {
        let result: NSURL? = "url" <~~ testJSON!
        let decoderResult: NSURL? = Decoder.decodeURL("url")(testJSON!)
        
        XCTAssertTrue((result == decoderResult), "<~~ for url should return same as Decoder.decodeURL")
    }
    
}
