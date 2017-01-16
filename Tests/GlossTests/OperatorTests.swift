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

import Foundation
import Gloss
import XCTest

class OperatorTests: XCTestCase {

    static var allTests : [(String, (OperatorTests) -> () throws -> Void)] {        
#if !os(Linux)
        return [
            ("testDecodeOperatorForInvalidReturnsDecoderDecode", testDecodeOperatorForInvalidReturnsDecoderDecode),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForBool", testDecodeOperatorGenericReturnsDecoderDecodeForBool),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForBoolArray", testDecodeOperatorGenericReturnsDecoderDecodeForBoolArray),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForInt", testDecodeOperatorGenericReturnsDecoderDecodeForInt),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForIntArray", testDecodeOperatorGenericReturnsDecoderDecodeForIntArray),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForFloat", testDecodeOperatorGenericReturnsDecoderDecodeForFloat),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForFloatArray", testDecodeOperatorGenericReturnsDecoderDecodeForFloatArray),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForDouble", testDecodeOperatorGenericReturnsDecoderDecodeForDouble),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForDoubleArray", testDecodeOperatorGenericReturnsDecoderDecodeForDoubleArray),
            ("testDecodeOperatorGenericReturnsDecoderDecodableDictionary", testDecodeOperatorGenericReturnsDecoderDecodableDictionary),
            ("testDecodeOperatorGenericReturnsDecoderDecodableDictionaryWithArray", testDecodeOperatorGenericReturnsDecoderDecodableDictionaryWithArray),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForString", testDecodeOperatorGenericReturnsDecoderDecodeForString),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForStringArray", testDecodeOperatorGenericReturnsDecoderDecodeForStringArray),
            ("testDecodeOperatorDecodableReturnsDecoderDecode", testDecodeOperatorDecodableReturnsDecoderDecode),
            ("testDecodeOperatorDecodableArrayReturnsDecoderDecodeArray", testDecodeOperatorDecodableArrayReturnsDecoderDecodeArray),
            ("testDecodeOperatorEnumValueReturnsDecoderDecodeEnum", testDecodeOperatorEnumValueReturnsDecoderDecodeEnum),
            ("testDecodeOperatorEnumArrayReturnsDecoderDecodeArray", testDecodeOperatorEnumArrayReturnsDecoderDecodeArray),
            ("testDecodeOperatorInt32ReturnsDecoderInt32", testDecodeOperatorInt32ReturnsDecoderInt32),
            ("testDecodeOperatorInt32ArrayReturnsDecoderInt32Array", testDecodeOperatorInt32ArrayReturnsDecoderInt32Array),
            ("testDecodeOperatorUInt32ReturnsDecoderUInt32", testDecodeOperatorUInt32ReturnsDecoderUInt32),
            ("testDecodeOperatorUInt32ArrayReturnsDecoderUInt32Array", testDecodeOperatorUInt32ArrayReturnsDecoderUInt32Array),
            ("testDecodeOperatorInt64ReturnsDecoderInt64", testDecodeOperatorInt64ReturnsDecoderInt64),
            ("testDecodeOperatorInt64ArrayReturnsDecoderInt64Array", testDecodeOperatorInt64ArrayReturnsDecoderInt64Array),
            ("testDecodeOperatorUInt64ReturnsDecoderUInt64", testDecodeOperatorUInt64ReturnsDecoderUInt64),
            ("testDecodeOperatorUInt64ArrayReturnsDecoderUInt64Array", testDecodeOperatorUInt64ArrayReturnsDecoderUInt64Array),
            ("testDecodeOperatorURLReturnsDecoderDecodeURL", testDecodeOperatorURLReturnsDecoderDecodeURL),
            ("testDecodeOperatorURLArrayReturnsDecoderDecodeURLArray", testDecodeOperatorURLArrayReturnsDecoderDecodeURLArray),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForBool", testEncodeOperatorGenericReturnsEncoderEncodeForBool),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForBoolArray", testEncodeOperatorGenericReturnsEncoderEncodeForBoolArray),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForInt", testEncodeOperatorGenericReturnsEncoderEncodeForInt),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForIntArray", testEncodeOperatorGenericReturnsEncoderEncodeForIntArray),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForFloat", testEncodeOperatorGenericReturnsEncoderEncodeForFloat),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForFloatArray", testEncodeOperatorGenericReturnsEncoderEncodeForFloatArray),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForDouble", testEncodeOperatorGenericReturnsEncoderEncodeForDouble),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForDoubleArray", testEncodeOperatorGenericReturnsEncoderEncodeForDoubleArray),
            ("testEncodeOperatorGenericReturnsEncoderEncodeEncodableDictionary", testEncodeOperatorGenericReturnsEncoderEncodeEncodableDictionary),
            ("testEncodeOperatorGenericReturnsEncoderEncodeEncodableDictionaryWithArray", testEncodeOperatorGenericReturnsEncoderEncodeEncodableDictionaryWithArray),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForString", testEncodeOperatorGenericReturnsEncoderEncodeForString),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForStringArray", testEncodeOperatorGenericReturnsEncoderEncodeForStringArray),
            ("testEncodeOperatorEncodableReturnsEncoderEncode", testEncodeOperatorEncodableReturnsEncoderEncode),
            ("testEncodeOperatorEncodableArrayReturnsEncoderEncodeArray", testEncodeOperatorEncodableArrayReturnsEncoderEncodeArray),
            ("testEncodeOperatorEnumValueReturnsEncoderEncode", testEncodeOperatorEnumValueReturnsEncoderEncode),
            ("testEncodeOperatorEnumArrayReturnsEncoderEncodeArray", testEncodeOperatorEnumArrayReturnsEncoderEncodeArray),
            ("testEncodeOperatorInt32ReturnsEncoderEncodeInt32", testEncodeOperatorInt32ReturnsEncoderEncodeInt32),
            ("testEncodeOperatorInt32ArrayReturnsEncoderEncodeInt32Array", testEncodeOperatorInt32ArrayReturnsEncoderEncodeInt32Array),
            ("testEncodeOperatorUInt32ReturnsEncoderEncodeUInt32", testEncodeOperatorUInt32ReturnsEncoderEncodeUInt32),
            ("testEncodeOperatorUInt32ArrayReturnsEncoderEncodeUInt32Array", testEncodeOperatorUInt32ArrayReturnsEncoderEncodeUInt32Array),
            ("testEncodeOperatorInt64ReturnsEncoderEncodeInt64", testEncodeOperatorInt64ReturnsEncoderEncodeInt64),
            ("testEncodeOperatorInt64ArrayReturnsEncoderEncodeInt64Array", testEncodeOperatorInt64ArrayReturnsEncoderEncodeInt64Array),
            ("testEncodeOperatorUInt64ReturnsEncoderEncodeUInt64", testEncodeOperatorUInt64ReturnsEncoderEncodeUInt64),
            ("testEncodeOperatorUInt64ArrayReturnsEncoderEncodeUInt64Array", testEncodeOperatorUInt64ArrayReturnsEncoderEncodeUInt64Array),
            ("testEncodeOperatorURLReturnsEncoderEncodeURL", testEncodeOperatorURLReturnsEncoderEncodeURL),
            ("testEncodeOperatorURLArrayReturnsEncoderEncodeURLArray", testEncodeOperatorURLArrayReturnsEncoderEncodeURLArray),
            ("testEncodeOperatorUUIDReturnsEncoderEncodeUUID", testEncodeOperatorUUIDReturnsEncoderEncodeUUID),
            ("testEncodeOperatorUUIDArrayReturnsEncoderEncodeUUIDArray", testEncodeOperatorUUIDArrayReturnsEncoderEncodeUUIDArray),
            ("testEncodeOperatorDecimalReturnsEncoderEncodeDecimal", testEncodeOperatorDecimalReturnsEncoderEncodeDecimal),
            ("testEncodeOperatorDecimalReturnsEncoderEncodeDecimalArray", testEncodeOperatorDecimalReturnsEncoderEncodeDecimalArray)
        ]
    
#else
        return [
            ("testDecodeOperatorForInvalidReturnsDecoderDecode", testDecodeOperatorForInvalidReturnsDecoderDecode),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForBool", testDecodeOperatorGenericReturnsDecoderDecodeForBool),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForBoolArray", testDecodeOperatorGenericReturnsDecoderDecodeForBoolArray),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForInt", testDecodeOperatorGenericReturnsDecoderDecodeForInt),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForIntArray", testDecodeOperatorGenericReturnsDecoderDecodeForIntArray),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForFloat", testDecodeOperatorGenericReturnsDecoderDecodeForFloat),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForFloatArray", testDecodeOperatorGenericReturnsDecoderDecodeForFloatArray),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForDouble", testDecodeOperatorGenericReturnsDecoderDecodeForDouble),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForDoubleArray", testDecodeOperatorGenericReturnsDecoderDecodeForDoubleArray),
            ("testDecodeOperatorGenericReturnsDecoderDecodableDictionary", testDecodeOperatorGenericReturnsDecoderDecodableDictionary),
            ("testDecodeOperatorGenericReturnsDecoderDecodableDictionaryWithArray", testDecodeOperatorGenericReturnsDecoderDecodableDictionaryWithArray),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForString", testDecodeOperatorGenericReturnsDecoderDecodeForString),
            ("testDecodeOperatorGenericReturnsDecoderDecodeForStringArray", testDecodeOperatorGenericReturnsDecoderDecodeForStringArray),
            ("testDecodeOperatorDecodableReturnsDecoderDecode", testDecodeOperatorDecodableReturnsDecoderDecode),
            ("testDecodeOperatorDecodableArrayReturnsDecoderDecodeArray", testDecodeOperatorDecodableArrayReturnsDecoderDecodeArray),
            ("testDecodeOperatorEnumValueReturnsDecoderDecodeEnum", testDecodeOperatorEnumValueReturnsDecoderDecodeEnum),
            ("testDecodeOperatorEnumArrayReturnsDecoderDecodeArray", testDecodeOperatorEnumArrayReturnsDecoderDecodeArray),
            ("testDecodeOperatorURLReturnsDecoderDecodeURL", testDecodeOperatorURLReturnsDecoderDecodeURL),
            ("testDecodeOperatorURLArrayReturnsDecoderDecodeURLArray", testDecodeOperatorURLArrayReturnsDecoderDecodeURLArray),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForBool", testEncodeOperatorGenericReturnsEncoderEncodeForBool),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForBoolArray", testEncodeOperatorGenericReturnsEncoderEncodeForBoolArray),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForInt", testEncodeOperatorGenericReturnsEncoderEncodeForInt),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForIntArray", testEncodeOperatorGenericReturnsEncoderEncodeForIntArray),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForFloat", testEncodeOperatorGenericReturnsEncoderEncodeForFloat),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForFloatArray", testEncodeOperatorGenericReturnsEncoderEncodeForFloatArray),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForDouble", testEncodeOperatorGenericReturnsEncoderEncodeForDouble),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForDoubleArray", testEncodeOperatorGenericReturnsEncoderEncodeForDoubleArray),
            ("testEncodeOperatorGenericReturnsEncoderEncodeEncodableDictionary", testEncodeOperatorGenericReturnsEncoderEncodeEncodableDictionary),
            ("testEncodeOperatorGenericReturnsEncoderEncodeEncodableDictionaryWithArray", testEncodeOperatorGenericReturnsEncoderEncodeEncodableDictionaryWithArray),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForString", testEncodeOperatorGenericReturnsEncoderEncodeForString),
            ("testEncodeOperatorGenericReturnsEncoderEncodeForStringArray", testEncodeOperatorGenericReturnsEncoderEncodeForStringArray),
            ("testEncodeOperatorEncodableReturnsEncoderEncode", testEncodeOperatorEncodableReturnsEncoderEncode),
            ("testEncodeOperatorEncodableArrayReturnsEncoderEncodeArray", testEncodeOperatorEncodableArrayReturnsEncoderEncodeArray),
            ("testEncodeOperatorEnumValueReturnsEncoderEncode", testEncodeOperatorEnumValueReturnsEncoderEncode),
            ("testEncodeOperatorEnumArrayReturnsEncoderEncodeArray", testEncodeOperatorEnumArrayReturnsEncoderEncodeArray),
            ("testEncodeOperatorInt32ReturnsEncoderEncodeInt32", testEncodeOperatorInt32ReturnsEncoderEncodeInt32),
            ("testEncodeOperatorInt32ArrayReturnsEncoderEncodeInt32Array", testEncodeOperatorInt32ArrayReturnsEncoderEncodeInt32Array),
            ("testEncodeOperatorUInt32ReturnsEncoderEncodeUInt32", testEncodeOperatorUInt32ReturnsEncoderEncodeUInt32),
            ("testEncodeOperatorUInt32ArrayReturnsEncoderEncodeUInt32Array", testEncodeOperatorUInt32ArrayReturnsEncoderEncodeUInt32Array),
            ("testEncodeOperatorInt64ReturnsEncoderEncodeInt64", testEncodeOperatorInt64ReturnsEncoderEncodeInt64),
            ("testEncodeOperatorInt64ArrayReturnsEncoderEncodeInt64Array", testEncodeOperatorInt64ArrayReturnsEncoderEncodeInt64Array),
            ("testEncodeOperatorUInt64ReturnsEncoderEncodeUInt64", testEncodeOperatorUInt64ReturnsEncoderEncodeUInt64),
            ("testEncodeOperatorUInt64ArrayReturnsEncoderEncodeUInt64Array", testEncodeOperatorUInt64ArrayReturnsEncoderEncodeUInt64Array),
            ("testEncodeOperatorURLReturnsEncoderEncodeURL", testEncodeOperatorURLReturnsEncoderEncodeURL),
            ("testEncodeOperatorURLArrayReturnsEncoderEncodeURLArray", testEncodeOperatorURLArrayReturnsEncoderEncodeURLArray),
            ("testEncodeOperatorUUIDReturnsEncoderEncodeUUID", testEncodeOperatorUUIDReturnsEncoderEncodeUUID),
            ("testEncodeOperatorUUIDArrayReturnsEncoderEncodeUUIDArray", testEncodeOperatorUUIDArrayReturnsEncoderEncodeUUIDArray),
            ("testEncodeOperatorDecimalReturnsEncoderEncodeDecimal", testEncodeOperatorDecimalReturnsEncoderEncodeDecimal),
            ("testEncodeOperatorDecimalReturnsEncoderEncodeDecimalArray", testEncodeOperatorDecimalReturnsEncoderEncodeDecimalArray)
        ]
#endif
        
	}
    
    var testJSON: JSON? = [:]
    var testNestedModel1: TestNestedModel? = nil
    var testNestedModel2: TestNestedModel? = nil
    
    override func setUp() {
        super.setUp()
        
#if SWIFT_PACKAGE
            
        testJSON = TestModel.testJSON
    
#else
    
        let testJSONPath: String = Bundle(for: type(of: self)).path(forResource: "TestModel", ofType: "json")!
        let testJSONData: Data = try! Data(contentsOf: URL(fileURLWithPath: testJSONPath as String))
        
        do {
            try testJSON = JSONSerialization.jsonObject(with: testJSONData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? JSON
        } catch {
            print(error)
        }
    
#endif
        
        testNestedModel1 = TestNestedModel(json: [ "id" : 1, "name" : "nestedModel1"])
        testNestedModel2 = TestNestedModel(json: ["id" : 2, "name" : "nestedModel2"])
    }
    
    override func tearDown() {
        testJSON = nil
        testNestedModel1 = nil
        testNestedModel2 = nil
        
        super.tearDown()
    }
    
    // MARK: - Operator <~~
    
    func testDecodeOperatorForInvalidReturnsDecoderDecode() {
        let resultInvalid: String? = "invalid" <~~ testJSON!
        let decoderResultInvalid: String? = Decoder.decode(key: "invalid")(testJSON!)
        
        XCTAssertTrue((resultInvalid == decoderResultInvalid), "<~~ for invalid value should return same as Decoder.decode")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForBool() {
        let resultBool: Bool? = "bool" <~~ testJSON!
        let decoderResultBool: Bool? = Decoder.decode(key: "bool")(testJSON!)
        
        XCTAssertTrue((resultBool == decoderResultBool), "<~~ for generic value should return same as Decoder.decode for Bool")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForBoolArray() {
        let resultBoolArray: [Bool]? = "boolArray" <~~ testJSON!
        let decoderResultBoolArray: [Bool]? = Decoder.decode(key: "boolArray")(testJSON!)
        
        XCTAssertTrue((resultBoolArray! == decoderResultBoolArray!), "<~~ for generic value should return same as Decoder.decode for Bool array")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForInt() {
        let resultInt: Int? = "integer" <~~ testJSON!
        let decoderResultInt: Int? = Decoder.decode(key: "integer")(testJSON!)
        
        XCTAssertTrue((resultInt == decoderResultInt), "<~~ for generic value should return same as Decoder.decode for Int")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForIntArray() {
        let resultIntArray: [Int]? = "integerArray" <~~ testJSON!
        let decoderResultIntArray: [Int]? = Decoder.decode(key: "integerArray")(testJSON!)
        
        XCTAssertTrue((resultIntArray! == decoderResultIntArray!), "<~~ for generic value should return same as Decoder.decode for Int array")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForFloat() {
        let resultFloat: Float? = "float" <~~ testJSON!
        let decoderResultFloat: Float? = Decoder.decode(key: "float")(testJSON!)
        
        XCTAssertTrue((resultFloat == decoderResultFloat), "<~~ for generic value should return same as Decoder.decode for Float")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForFloatArray() {
        let resultFloatArray: [Float]? = "floatArray" <~~ testJSON!
        let decoderResultFloatArray: [Float]? = Decoder.decode(key: "floatArray")(testJSON!)
        
        XCTAssertTrue((resultFloatArray! == decoderResultFloatArray!), "<~~ for generic value should return same as Decoder.decode for Float array")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForDouble() {
        let resultDouble: Double? = "double" <~~ testJSON!
        let decoderResultDouble: Double? = Decoder.decode(key: "double")(testJSON!)
        
        XCTAssertTrue((resultDouble == decoderResultDouble), "<~~ for generic value should return same as Decoder.decode for Double")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForDoubleArray() {
        let resultDoubleArray: [Double]? = "doubleArray" <~~ testJSON!
        let decoderResultDoubleArray: [Double]? = Decoder.decode(key: "doubleArray")(testJSON!)
        
        XCTAssertTrue((resultDoubleArray! == decoderResultDoubleArray!), "<~~ for generic value should return same as Decoder.decode for Double array")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodableDictionary() {
        let resultDictionary: [String : TestNestedModel]? = "dictionary" <~~ testJSON!
        let decoderDictionary: [String : TestNestedModel]? = Decoder.decode(decodableDictionaryForKey: "dictionary")(testJSON!)
        
        XCTAssertTrue(resultDictionary!["otherModel"]! == decoderDictionary!["otherModel"]!, "<~~ for generic value should result same as Decoder.decodeDecodableDictionary for dictionary")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodableDictionaryWithArray() {
        let resultDictionary: [String : [TestNestedModel]]? = "dictionaryWithArray" <~~ testJSON!
        let decoderDictionary: [String : [TestNestedModel]]? = Decoder.decode(decodableDictionaryForKey: "dictionaryWithArray")(testJSON!)
        
        XCTAssertTrue(resultDictionary!["otherModels"]! == decoderDictionary!["otherModels"]!, "<~~ for generic value should result same as Decoder.decodeDecodableDictionary for dictionary")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForString() {
        let resultString: String? = "string" <~~ testJSON!
        let decoderResultString: String? = Decoder.decode(key: "string")(testJSON!)
        
        XCTAssertTrue((resultString == decoderResultString), "<~~ for generic value should return same as Decoder.decode for String")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForStringArray() {
        let resultStringArray: [String]? = "stringArray" <~~ testJSON!
        let decoderResultStringArray: [String]? = Decoder.decode(key: "stringArray")(testJSON!)
        
        XCTAssertTrue((resultStringArray! == decoderResultStringArray!), "<~~ for generic value should return same as Decoder.decode for String array")
    }
    
    func testDecodeOperatorDecodableReturnsDecoderDecode() {
        let resultNestedModel: TestNestedModel? = "nestedModel" <~~ testJSON!
        let decoderResultNestedModel: TestNestedModel? = Decoder.decode(decodableForKey: "nestedModel")(testJSON!)
        
        XCTAssertTrue((resultNestedModel!.id == decoderResultNestedModel!.id), "<~~ for Decodable models should return same as Decoder.decode")
        XCTAssertTrue((resultNestedModel!.name == decoderResultNestedModel!.name), "<~~ for Decodable models should return same as Decoder.decode")
    }
    
    func testDecodeOperatorDecodableArrayReturnsDecoderDecodeArray() {
        let result: [TestNestedModel]? = "nestedModelArray" <~~ testJSON!
        let resultElement1: TestNestedModel = result![0]
        let resultElement2: TestNestedModel = result![1]
        let decoderResult: [TestNestedModel]? = Decoder.decode(decodableArrayForKey: "nestedModelArray")(testJSON!)
        let decoderResultElement1: TestNestedModel = decoderResult![0]
        let decoderResultElement2: TestNestedModel = decoderResult![1]
        
        XCTAssertTrue((resultElement1.id == decoderResultElement1.id), "<~~ for Decodable models array should return same as Decoder.decodeArray")
        XCTAssertTrue((resultElement1.name == decoderResultElement1.name), "<~~ for Decodable models array should return same as Decoder.decodeArray")
        XCTAssertTrue((resultElement2.id == decoderResultElement2.id), "<~~ for Decodable models array should return same as Decoder.decodeArray")
        XCTAssertTrue((resultElement2.name == decoderResultElement2.name), "<~~ for Decodable models array should return same as Decoder.decodeArray")
    }
    
    func testDecodeOperatorEnumValueReturnsDecoderDecodeEnum() {
        let result: TestModel.EnumValue? = "enumValue" <~~ testJSON!
        let decoderResult: TestModel.EnumValue? = Decoder.decode(enumForKey: "enumValue")(testJSON!)
        
        XCTAssertTrue((result == decoderResult), "<~~ for enum value should return same as Decoder.decodeEnum")
    }
    
    func testDecodeOperatorEnumArrayReturnsDecoderDecodeArray() {
        let result: [TestModel.EnumValue]? = "enumValueArray" <~~ testJSON!
        let resultElement1: TestModel.EnumValue = result![0]
        let resultElement2: TestModel.EnumValue = result![1]
        let resultElement3: TestModel.EnumValue = result![2]
        let decoderResult: [TestModel.EnumValue]? = Decoder.decode(enumArrayForKey: "enumValueArray")(testJSON!)
        let decoderResultElement1: TestModel.EnumValue = decoderResult![0]
        let decoderResultElement2: TestModel.EnumValue = decoderResult![1]
        let decoderResultElement3: TestModel.EnumValue = decoderResult![2]
        
        XCTAssertTrue((resultElement1 == decoderResultElement1), "<~~ for enum value array should return same as Decoder.decodeArray")
        XCTAssertTrue((resultElement2 == decoderResultElement2), "<~~ for enum value array should return same as Decoder.decodeArray")
        XCTAssertTrue((resultElement3 == decoderResultElement3), "<~~ for enum value array should return same as Decoder.decodeArray")
    }
    
    func testDecodeOperatorInt32ReturnsDecoderInt32() {
        let result: Int32? = "int32" <~~ testJSON!
        let decoderResult: Int32? = Decoder.decode(int32ForKey: "int32")(testJSON!)
        
        XCTAssertTrue((result == decoderResult), "<~~ for Int32 should return same as Decoder.decodeInt32")
    }

	func testDecodeOperatorInt32ArrayReturnsDecoderInt32Array() {
		let result: [Int32]? = "int32Array" <~~ testJSON!
        let decoderResult: [Int32]? = Decoder.decode(int32ArrayForKey: "int32Array")(testJSON!)

		XCTAssertTrue((result! == decoderResult!), "<~~ for [Int32] should return same as Decoder.decodeInt32Array")
	}

	func testDecodeOperatorUInt32ReturnsDecoderUInt32() {
		let result: UInt32? = "uInt32" <~~ testJSON!
        let decoderResult: UInt32? = Decoder.decode(uint32ForKey: "uInt32")(testJSON!)

		XCTAssertTrue((result == decoderResult), "<~~ for UInt32 should return same as Decoder.decodeUInt32")
	}

	func testDecodeOperatorUInt32ArrayReturnsDecoderUInt32Array() {
		let result: [UInt32]? = "uInt32Array" <~~ testJSON!
        let decoderResult: [UInt32]? = Decoder.decode(uint32ArrayForKey: "uInt32Array")(testJSON!)

		XCTAssertTrue((result! == decoderResult!), "<~~ for [UInt32] should return same as Decoder.decodeUInt32Array")
	}

    func testDecodeOperatorInt64ReturnsDecoderInt64() {
        let result: Int64? = "int64" <~~ testJSON!
        let decoderResult: Int64? = Decoder.decode(int64ForKey: "int64")(testJSON!)
        
        XCTAssertTrue((result == decoderResult), "<~~ for Int64 should return same as Decoder.decodeInt64")
    }

	func testDecodeOperatorInt64ArrayReturnsDecoderInt64Array() {
		let result: [Int64]? = "int64Array" <~~ testJSON!
        let decoderResult: [Int64]? = Decoder.decode(int64ArrayForKey: "int64Array")(testJSON!)

		XCTAssertTrue((result! == decoderResult!), "<~~ for [Int64] should return same as Decoder.decodeInt64Array")
	}

	func testDecodeOperatorUInt64ReturnsDecoderUInt64() {
		let result: UInt64? = "uInt64" <~~ testJSON!
        let decoderResult: UInt64? = Decoder.decode(uint64ForKey: "uInt64")(testJSON!)

		XCTAssertTrue((result == decoderResult), "<~~ for UInt64 should return same as Decoder.decodeUInt64")
	}

	func testDecodeOperatorUInt64ArrayReturnsDecoderUInt64Array() {
		let result: [UInt64]? = "uInt64Array" <~~ testJSON!
        let decoderResult: [UInt64]? = Decoder.decode(uint64ArrayForKey: "uInt64Array")(testJSON!)

		XCTAssertTrue((result! == decoderResult!), "<~~ for [UInt64] should return same as Decoder.decodeUInt64Array")
	}

    func testDecodeOperatorURLReturnsDecoderDecodeURL() {
        let result: URL? = "url" <~~ testJSON!
        let decoderResult: URL? = Decoder.decode(urlForKey: "url")(testJSON!)
        
        XCTAssertTrue((result == decoderResult), "<~~ for url should return same as Decoder.decodeURL")
    }
    
    func testDecodeOperatorURLArrayReturnsDecoderDecodeURLArray() {
        let result: [URL]? = "urlArray" <~~ testJSON!
        let decoderResult: [URL]? = Decoder.decode(urlArrayForKey: "urlArray")(testJSON!)
        
        XCTAssertTrue((result! == decoderResult!), "<~~ for url array should return same as Decoder.decodeURLArray")
    }
    
    func testDecodeOperatorDecimalReturnsDecoderDecimal() {
        let result: Decimal? = "decimal" <~~ testJSON!
        let decoderResult: Decimal? = Decoder.decode(decimalForKey: "decimal")(testJSON!)
        
        XCTAssertTrue((result == decoderResult), "<~~ for Decimal should return same as Decoder.decodeDecimal")
    }
    
    func testDecodeOperatorDecimalArrayReturnsDecoderDecimalArray() {
        let result: [Decimal]? = "decimalArray" <~~ testJSON!
        let decoderResult: [Decimal]? = Decoder.decode(decimalArrayForKey: "decimalArray")(testJSON!)
        
        XCTAssertTrue((result! == decoderResult!), "<~~ for [Decimal] should return same as Decoder.decodeDecimalArray")
    }
    
    // MARK: - Operator ~~>
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForBool() {
        let bool: Bool? = true
        let resultBool: JSON? = "bool" ~~> bool
        let encoderResultBool: JSON? = Encoder.encode(key: "bool")(bool)
        
        XCTAssertTrue(((resultBool!["bool"] as! Bool) == (encoderResultBool!["bool"] as! Bool)), "~~> for generic value should return same as Encoder.encode for Bool")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForBoolArray() {
        let boolArray: [Bool]? = [true, false, true]
        let resultBoolArray: JSON? = "boolArray" ~~> boolArray
        let encoderResultBoolArray: JSON? = Encoder.encode(key: "boolArray")(boolArray)
        
        XCTAssertTrue(((resultBoolArray!["boolArray"] as! [Bool]) == (encoderResultBoolArray!["boolArray"] as! [Bool])), "~~> for generic value should return same as Encoder.encode for Bool array")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForInt() {
        let integer: Int? = 1
        let resultInteger: JSON? = "integer" ~~> integer
        let encoderResultInteger: JSON? = Encoder.encode(key: "integer")(integer)
        
        XCTAssertTrue(((resultInteger!["integer"] as! Int) == (encoderResultInteger!["integer"] as! Int)), "~~> for generic value should return same as Encoder.encode for Int array")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForIntArray() {
        let integerArray: [Int]? = [1, 2, 3]
        let resultIntegerArray: JSON? = "integerArray" ~~> integerArray
        let encoderResultIntegerArray: JSON? = Encoder.encode(key: "integerArray")(integerArray)
        
        XCTAssertTrue(((resultIntegerArray!["integerArray"] as! [Int]) == (encoderResultIntegerArray!["integerArray"] as! [Int])), "~~> for generic value should return same as Encoder.encode for Int")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForFloat() {
        let float: Float? = 1.0
        let resultFloat: JSON? = "float" ~~> float
        let encoderResultFloat: JSON? = Encoder.encode(key: "float")(float)
        
        XCTAssertTrue(((resultFloat!["float"] as! Float) == (encoderResultFloat!["float"] as! Float)), "~~> for generic value should return same as Encoder.encode for Float")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForFloatArray() {
        let floatArray: [Float]? = [1.0, 2.0, 3.0]
        let resultFloatArray: JSON? = "floatArray" ~~> floatArray
        let encoderResultFloatArray: JSON? = Encoder.encode(key: "floatArray")(floatArray)
        
        XCTAssertTrue(((resultFloatArray!["floatArray"] as! [Float]) == (encoderResultFloatArray!["floatArray"] as! [Float])), "~~> for generic value should return same as Encoder.encode for Float array")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForDouble() {
        let double: Double? = 1.0
        let resultDouble: JSON? = "double" ~~> double
        let encoderResultDouble: JSON? = Encoder.encode(key: "double")(double)
        
        XCTAssertTrue(((resultDouble!["double"] as! Double) == (encoderResultDouble!["double"] as! Double)), "~~> for generic value should return same as Encoder.encode for Double")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForDoubleArray() {
        let doubleArray: [Double]? = [1.0, 2.0, 3.0]
        let resultDoubleArray: JSON? = "doubleArray" ~~> doubleArray
        let encoderResultDoubleArray: JSON? = Encoder.encode(key: "doubleArray")(doubleArray)
        
        XCTAssertTrue(((resultDoubleArray!["doubleArray"] as! [Double]) == (encoderResultDoubleArray!["doubleArray"] as! [Double])), "~~> for generic value should return same as Encoder.encode for Double array")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeEncodableDictionary() {
        let dictionary: [String : TestNestedModel]? = ["otherModel" : testNestedModel1!]
        let result: JSON? = "dictionary" ~~> dictionary
        let encoderResult: JSON? = Encoder.encode(encodableDictionaryForKey: "dictionary")(dictionary)
        
        let dict = (result!["dictionary"] as! JSON)["otherModel"] as! JSON
        let encDict = (encoderResult!["dictionary"] as! JSON)["otherModel"] as! JSON
        
        XCTAssertTrue(dict["id"] as! Int == encDict["id"] as! Int, "~~> for [String:Encodable] value should return same as Encoder.encodeEncodableDictionary for dictionary")
        XCTAssertTrue(dict["name"] as! String == encDict["name"] as! String, "~~> for [String:Encodable] value should return same as Encoder.encodeEncodableDictionary for dictionary")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeEncodableDictionaryWithArray() {
        let dictionaryWithArray: [String : [TestNestedModel]]? = ["otherModels" : [testNestedModel1!, testNestedModel2!]]
        let result: JSON? = "dictionaryWithArray" ~~> dictionaryWithArray
        let encoderResult: JSON? = Encoder.encode(encodableDictionaryForKey: "dictionaryWithArray")(dictionaryWithArray)
        let dictArray = (result!["dictionaryWithArray"] as! JSON)["otherModels"] as! [JSON]
        let encDictArray = (encoderResult!["dictionaryWithArray"] as! JSON)["otherModels"] as! [JSON]
        
        XCTAssertTrue(dictArray[0]["id"] as! Int == encDictArray[0]["id"] as! Int, "~~> for [String:Encodable] value should return same as Encoder.encodeEncodableDictionary for dictionary")
        XCTAssertTrue(dictArray[0]["name"] as! String == encDictArray[0]["name"] as! String, "~~> for [String:Encodable] value should return same as Encoder.encodeEncodableDictionary for dictionary")
        XCTAssertTrue(dictArray[1]["id"] as! Int == encDictArray[1]["id"] as! Int, "~~> for [String:Encodable] value should return same as Encoder.encodeEncodableDictionary for dictionary")
        XCTAssertTrue(dictArray[1]["name"] as! String == encDictArray[1]["name"] as! String, "~~> for [String:Encodable] value should return same as Encoder.encodeEncodableDictionary for dictionary")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForString() {
        let string: String? = "abc"
        let resultString: JSON? = "string" ~~> string
        let encoderResultString: JSON? = Encoder.encode(key: "string")(string)
        
        XCTAssertTrue(((resultString!["string"] as! String) == (encoderResultString!["string"] as! String)), "~~> for generic value should return same as Encoder.encode for String")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForStringArray() {
        let stringArray: [String]? = ["def", "ghi", "jkl"]
        let resultStringArray: JSON? = "stringArray" ~~> stringArray
        let encoderResultStringArray: JSON? = Encoder.encode(key: "stringArray")(stringArray)
        
        XCTAssertTrue(((resultStringArray!["stringArray"] as! [String]) == (encoderResultStringArray!["stringArray"] as! [String])), "~~> for generic value should return same as Encoder.encode for String array")
    }
    
    func testEncodeOperatorEncodableReturnsEncoderEncode() {
        let result: JSON? = "nestedModel" ~~> testNestedModel1
        let modelJSON: JSON = result!["nestedModel"] as! JSON
        let encoderResult: JSON? = Encoder.encode(encodableForKey: "nestedModel")(testNestedModel1)
        let encoderModelJSON: JSON = encoderResult!["nestedModel"] as! JSON
        
        XCTAssertTrue((modelJSON["id"] as! Int == encoderModelJSON["id"] as! Int), "~~> for nested model should return same as Encoder.encode")
        XCTAssertTrue((modelJSON["name"] as! String == encoderModelJSON["name"] as! String), "~~> for nested model should return same as Encoder.encode")
    }
    
    func testEncodeOperatorEncodableArrayReturnsEncoderEncodeArray() {
        let model1: TestNestedModel = testNestedModel1!
        let model2: TestNestedModel = testNestedModel2!
        let result: JSON? = "nestedModelArray" ~~> ([model1, model2])
        let modelsJSON: [JSON] = result!["nestedModelArray"] as! [JSON]
        let model1JSON: JSON = modelsJSON[0]
        let model2JSON: JSON = modelsJSON[1]
        let encoderResult: JSON? = Encoder.encode(encodableArrayForKey: "nestedModelArray")([model1, model2])
        let encoderModelsJSON: [JSON] = encoderResult!["nestedModelArray"] as! [JSON]
        let encoderModel1JSON: JSON = encoderModelsJSON[0]
        let encoderModel2JSON: JSON = encoderModelsJSON[1]
        
        XCTAssertTrue((model1JSON["id"] as! Int == encoderModel1JSON["id"] as! Int), "~~> for nested model array should return same as Encoder.encodeArray")
        XCTAssertTrue((model1JSON["name"] as! String == encoderModel1JSON["name"] as! String), "~~> for nested model array should return same as Encoder.encodeArray")
        XCTAssertTrue((model2JSON["id"] as! Int == encoderModel2JSON["id"] as! Int), "~~> for nested model array should return same as Encoder.encodeArray")
        XCTAssertTrue((model2JSON["name"] as! String == encoderModel2JSON["name"] as! String), "~~> for nested model array should return same as Encoder.encodeArray")
    }
    
    func testEncodeOperatorEnumValueReturnsEncoderEncode() {
        let enumValue: TestModel.EnumValue? = TestModel.EnumValue.A
        let result: JSON? = "enumValue" ~~> enumValue
        let encoderResult: JSON? = Encoder.encode(enumForKey: "enumValue")(enumValue)
        
        XCTAssertTrue(((result!["enumValue"] as! TestModel.EnumValue.RawValue) == (encoderResult!["enumValue"] as! TestModel.EnumValue.RawValue)), "~~> for enum value should return same as Encoder.encodeEnum")
    }
    
    func testEncodeOperatorEnumArrayReturnsEncoderEncodeArray() {
        let enumArray: [TestModel.EnumValue]? = [TestModel.EnumValue.A, TestModel.EnumValue.B, TestModel.EnumValue.C]
        let result: JSON? = "enumValueArray" ~~> enumArray
        let encoderResult: JSON? = Encoder.encode(enumArrayForKey: "enumValueArray")(enumArray)
        
        XCTAssertTrue(((result!["enumValueArray"] as! [TestModel.EnumValue.RawValue]) == (encoderResult!["enumValueArray"] as! [TestModel.EnumValue.RawValue])), "~~> for enum value array should return same as Encoder.encodeArray")
    }
    
    func testEncodeOperatorInt32ReturnsEncoderEncodeInt32() {
        let int32: Int32? = 10000000
        let result: JSON? = "int32" ~~> int32
        let encoderResult: JSON? = Encoder.encode(int32ForKey: "int32")(int32)
        
        XCTAssertTrue((((result!["int32"] as! NSNumber)).int32Value == ((encoderResult!["int32"] as! NSNumber)).int32Value), "~~> for Int32 should return same as Encoder.encodeInt32")
    }
    
    func testEncodeOperatorInt32ArrayReturnsEncoderEncodeInt32Array() {
        let int32Array: [Int32]? = [10000000, -2147483648, 2147483647]
        let result: JSON? = "int32Array" ~~> int32Array
        let encoderResult: JSON? = Encoder.encode(int32ArrayForKey: "int32Array")(int32Array)
        let resultValue = result!["int32Array"] as! [NSNumber]
        let encoderResultValue = encoderResult!["int32Array"] as! [NSNumber]
        
        XCTAssertTrue(resultValue == encoderResultValue, "~~> for [Int32] should return same as Encoder.encodeInt32Array")
    }

	func testEncodeOperatorUInt32ReturnsEncoderEncodeUInt32() {
		let uInt32: UInt32? = 4294967295
		let result: JSON? = "uInt32" ~~> uInt32
		let encoderResult: JSON? = Encoder.encode(uint32ForKey: "uInt32")(uInt32)

		XCTAssertTrue((((result!["uInt32"] as! NSNumber)).uint32Value == ((encoderResult!["uInt32"] as! NSNumber)).uint32Value), "~~> for UInt32 should return same as Encoder.encodeUInt32")
	}

	func testEncodeOperatorUInt32ArrayReturnsEncoderEncodeUInt32Array() {
		let uInt32Array: [UInt32]? = [10000000, 2147483648, 4294967295]
		let result: JSON? = "uInt32Array" ~~> uInt32Array
		let encoderResult: JSON? = Encoder.encode(uint32ArrayForKey: "uInt32Array")(uInt32Array)
		let resultValue = result!["uInt32Array"] as! [NSNumber]
		let encoderResultValue = encoderResult!["uInt32Array"] as! [NSNumber]

		XCTAssertTrue(resultValue == encoderResultValue, "~~> for [UInt32] should return same as Encoder.encodeUInt32Array")
	}

    func testEncodeOperatorInt64ReturnsEncoderEncodeInt64() {
        let int64: Int64? = 30000000
        let result: JSON? = "int64" ~~> int64
        let encoderResult: JSON? = Encoder.encode(int64ForKey: "int64")(int64)
        
        XCTAssertTrue((((result!["int64"] as! NSNumber)).int64Value == ((encoderResult!["int64"] as! NSNumber)).int64Value), "~~> for Int64 should return same as Encoder.encodeInt64")
    }
    
    func testEncodeOperatorInt64ArrayReturnsEncoderEncodeInt64Array() {
        let int64Array: [Int64]? = [30000000, -9223372036854775808, 9223372036854775807]
        let result: JSON? = "int64Array" ~~> int64Array
        let encoderResult: JSON? = Encoder.encode(int64ArrayForKey: "int64Array")(int64Array)
        let resultValue = result!["int64Array"] as! [NSNumber]
        let encoderResultValue = encoderResult!["int64Array"] as! [NSNumber]
        
        XCTAssertTrue(resultValue == encoderResultValue, "~~> for [Int64] should return same as Encoder.encodeInt64Array")
    }

	func testEncodeOperatorUInt64ReturnsEncoderEncodeUInt64() {
		let uInt64: UInt64? = 18446744073709551615
		let result: JSON? = "uInt64" ~~> uInt64
        let encoderResult: JSON? = Encoder.encode(uint64ForKey: "uInt64")(uInt64)

		XCTAssertTrue((((result!["uInt64"] as! NSNumber)).uint64Value == ((encoderResult!["uInt64"] as! NSNumber)).uint64Value), "~~> for UInt64 should return same as Encoder.encodeUInt64")
	}

	func testEncodeOperatorUInt64ArrayReturnsEncoderEncodeUInt64Array() {
		let uInt64Array: [UInt64]? = [30000000, 9223372036854775808, 18446744073709551615]
		let result: JSON? = "uInt64Array" ~~> uInt64Array
        let encoderResult: JSON? = Encoder.encode(uint64ArrayForKey: "uInt64Array")(uInt64Array)
		let resultValue = result!["uInt64Array"] as! [NSNumber]
		let encoderResultValue = encoderResult!["uInt64Array"] as! [NSNumber]

		XCTAssertTrue(resultValue == encoderResultValue, "~~> for [UInt64] should return same as Encoder.encodeUInt64Array")
	}

    func testEncodeOperatorURLReturnsEncoderEncodeURL() {
        let url: URL? = URL(string: "http://github.com")
        let result: JSON? = "url" ~~> url
        let encoderResult: JSON? = Encoder.encode(urlForKey: "url")(url)
        
        XCTAssertTrue(((result!["url"] as! String) == (encoderResult!["url"] as! String)), "~~> for url should return same as Encoder.encodeURL")
    }
    
    func testEncodeOperatorURLArrayReturnsEncoderEncodeURLArray() {
        let urls: [URL]? = [URL(string: "http://github.com")!, URL(string: "http://github.com")!]
        let result: JSON? = "urlArray" ~~> urls
        let encoderResult: JSON? = Encoder.encode(arrayForKey: "urlArray")(urls)
        
        XCTAssertTrue(((result!["urlArray"] as! [URL]) == (encoderResult!["urlArray"] as! [URL])), "~~> for url array should return same as Encoder.encodeArray")
    }
    
    func testEncodeOperatorUUIDReturnsEncoderEncodeUUID() {
        let uuid: UUID? = UUID(uuidString: "964F2FE2-0F78-4C2D-A291-03058C0B98AB")
        let result: JSON? = "uuid" ~~> uuid
        let encoderResult: JSON? = Encoder.encode(uuidForKey: "uuid")(uuid)
        
        XCTAssertTrue(((result!["uuid"] as! String) == (encoderResult!["uuid"] as! String)), "~~> for uuid should return same as Encoder.encodeURL")
    }
    
    func testEncodeOperatorUUIDArrayReturnsEncoderEncodeUUIDArray() {
        let uuids: [UUID]? = [UUID(uuidString: "572099C2-B9AA-42AA-8A25-66E3F3056271")!, UUID(uuidString: "54DB8DCF-F68D-4B55-A3FC-EB8CF4C36B06")!]
        let result: JSON? = "uuidArray" ~~> uuids
        let encoderResult: JSON? = Encoder.encode(arrayForKey: "uuidArray")(uuids)
        
        XCTAssertTrue(((result!["uuidArray"] as! [UUID]) == (encoderResult!["uuidArray"] as! [UUID])), "~~> for uuid array should return same as Encoder.encodeArray")
    }
    
    func testEncodeOperatorDecimalReturnsEncoderEncodeDecimal() {
        let decimal: Decimal? = 3.14159
        let result: JSON? = "decimal" ~~> decimal
        let encoderResult: JSON? = Encoder.encode(decimalForKey: "decimal")(decimal)
        
        XCTAssertTrue((((result!["decimal"] as! NSNumber)).decimalValue == ((encoderResult!["decimal"] as! NSNumber)).decimalValue), "~~> for Decimal should return same as Encoder.encodeDecimal")
    }
    
    func testEncodeOperatorDecimalReturnsEncoderEncodeDecimalArray() {
        let decimalArray: [Decimal]? = [3.14159, 1.618, -2.7182]
        let result: JSON? = "decimalArray" ~~> decimalArray
        let encoderResult: JSON? = Encoder.encode(decimalArrayForKey: "decimalArray")(decimalArray)
        let resultValue = result!["decimalArray"] as! [NSNumber]
        let encoderResultValue = encoderResult!["decimalArray"] as! [NSNumber]
        
        XCTAssertTrue(resultValue == encoderResultValue, "~~> for [Decimal] should return same as Encoder.encodeDecimalArray")
    }
    
}
