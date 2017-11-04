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
    
    func testDecodeOperatorForInvalidReturnsJSONDecoderDecode() {
        let resultInvalid: String? = "invalid" <~~ testJSON!
        let decoderResultInvalid: String? = JSONDecoder.decode(key: "invalid")(testJSON!)
        
        XCTAssertTrue((resultInvalid == decoderResultInvalid), "<~~ for invalid value should return same as JSONDecoder.decode")
    }
    
    func testDecodeOperatorGenericReturnsJSONDecoderDecodeForBool() {
        let resultBool: Bool? = "bool" <~~ testJSON!
        let decoderResultBool: Bool? = JSONDecoder.decode(key: "bool")(testJSON!)
        
        XCTAssertTrue((resultBool == decoderResultBool), "<~~ for generic value should return same as JSONDecoder.decode for Bool")
    }
    
    func testDecodeOperatorGenericReturnsJSONDecoderDecodeForBoolArray() {
        let resultBoolArray: [Bool]? = "boolArray" <~~ testJSON!
        let decoderResultBoolArray: [Bool]? = JSONDecoder.decode(key: "boolArray")(testJSON!)
        
        XCTAssertTrue((resultBoolArray! == decoderResultBoolArray!), "<~~ for generic value should return same as JSONDecoder.decode for Bool array")
    }
    
    func testDecodeOperatorGenericReturnsJSONDecoderDecodeForInt() {
        let resultInt: Int? = "integer" <~~ testJSON!
        let decoderResultInt: Int? = JSONDecoder.decode(key: "integer")(testJSON!)
        
        XCTAssertTrue((resultInt == decoderResultInt), "<~~ for generic value should return same as JSONDecoder.decode for Int")
    }
    
    func testDecodeOperatorGenericReturnsJSONDecoderDecodeForIntArray() {
        let resultIntArray: [Int]? = "integerArray" <~~ testJSON!
        let decoderResultIntArray: [Int]? = JSONDecoder.decode(key: "integerArray")(testJSON!)
        
        XCTAssertTrue((resultIntArray! == decoderResultIntArray!), "<~~ for generic value should return same as JSONDecoder.decode for Int array")
    }
    
    func testDecodeOperatorGenericReturnsJSONDecoderDecodeForFloat() {
        let resultFloat: Float? = "float" <~~ testJSON!
        let decoderResultFloat: Float? = JSONDecoder.decode(key: "float")(testJSON!)
        
        XCTAssertTrue((resultFloat == decoderResultFloat), "<~~ for generic value should return same as JSONDecoder.decode for Float")
    }
    
    func testDecodeOperatorGenericReturnsJSONDecoderDecodeForFloatArray() {
        let resultFloatArray: [Float]? = "floatArray" <~~ testJSON!
        let decoderResultFloatArray: [Float]? = JSONDecoder.decode(key: "floatArray")(testJSON!)
        
        XCTAssertTrue((resultFloatArray! == decoderResultFloatArray!), "<~~ for generic value should return same as JSONDecoder.decode for Float array")
    }
    
    func testDecodeOperatorGenericReturnsJSONDecoderDecodeForDouble() {
        let resultDouble: Double? = "double" <~~ testJSON!
        let decoderResultDouble: Double? = JSONDecoder.decode(key: "double")(testJSON!)
        
        XCTAssertTrue((resultDouble == decoderResultDouble), "<~~ for generic value should return same as JSONDecoder.decode for Double")
    }
    
    func testDecodeOperatorGenericReturnsJSONDecoderDecodeForDoubleArray() {
        let resultDoubleArray: [Double]? = "doubleArray" <~~ testJSON!
        let decoderResultDoubleArray: [Double]? = JSONDecoder.decode(key: "doubleArray")(testJSON!)
        
        XCTAssertTrue((resultDoubleArray! == decoderResultDoubleArray!), "<~~ for generic value should return same as JSONDecoder.decode for Double array")
    }
    
    func testDecodeOperatorGenericReturnsJSONDecoderJSONDecodableDictionary() {
        let resultDictionary: [String : TestNestedModel]? = "dictionary" <~~ testJSON!
        let decoderDictionary: [String : TestNestedModel]? = JSONDecoder.decode(decodableDictionaryForKey: "dictionary")(testJSON!)
        
        XCTAssertTrue(resultDictionary!["otherModel"]! == decoderDictionary!["otherModel"]!, "<~~ for generic value should result same as JSONDecoder.decodeJSONDecodableDictionary for dictionary")
    }
    
    func testDecodeOperatorGenericReturnsJSONDecoderJSONDecodableDictionaryWithArray() {
        let resultDictionary: [String : [TestNestedModel]]? = "dictionaryWithArray" <~~ testJSON!
        let decoderDictionary: [String : [TestNestedModel]]? = JSONDecoder.decode(decodableDictionaryForKey: "dictionaryWithArray")(testJSON!)
        
        XCTAssertTrue(resultDictionary!["otherModels"]! == decoderDictionary!["otherModels"]!, "<~~ for generic value should result same as JSONDecoder.decodeJSONDecodableDictionary for dictionary")
    }
    
    func testDecodeOperatorGenericReturnsJSONDecoderDecodeForString() {
        let resultString: String? = "string" <~~ testJSON!
        let decoderResultString: String? = JSONDecoder.decode(key: "string")(testJSON!)
        
        XCTAssertTrue((resultString == decoderResultString), "<~~ for generic value should return same as JSONDecoder.decode for String")
    }
    
    func testDecodeOperatorGenericReturnsJSONDecoderDecodeForStringArray() {
        let resultStringArray: [String]? = "stringArray" <~~ testJSON!
        let decoderResultStringArray: [String]? = JSONDecoder.decode(key: "stringArray")(testJSON!)
        
        XCTAssertTrue((resultStringArray! == decoderResultStringArray!), "<~~ for generic value should return same as JSONDecoder.decode for String array")
    }
    
    func testDecodeOperatorJSONDecodableReturnsJSONDecoderDecode() {
        let resultNestedModel: TestNestedModel? = "nestedModel" <~~ testJSON!
        let decoderResultNestedModel: TestNestedModel? = JSONDecoder.decode(decodableForKey: "nestedModel")(testJSON!)
        
        XCTAssertTrue((resultNestedModel!.id == decoderResultNestedModel!.id), "<~~ for JSONDecodable models should return same as JSONDecoder.decode")
        XCTAssertTrue((resultNestedModel!.name == decoderResultNestedModel!.name), "<~~ for JSONDecodable models should return same as JSONDecoder.decode")
    }
    
    func testDecodeOperatorJSONDecodableArrayReturnsJSONDecoderDecodeArray() {
        let result: [TestNestedModel]? = "nestedModelArray" <~~ testJSON!
        let resultElement1: TestNestedModel = result![0]
        let resultElement2: TestNestedModel = result![1]
        let decoderResult: [TestNestedModel]? = JSONDecoder.decode(decodableArrayForKey: "nestedModelArray")(testJSON!)
        let decoderResultElement1: TestNestedModel = decoderResult![0]
        let decoderResultElement2: TestNestedModel = decoderResult![1]
        
        XCTAssertTrue((resultElement1.id == decoderResultElement1.id), "<~~ for JSONDecodable models array should return same as JSONDecoder.decodeArray")
        XCTAssertTrue((resultElement1.name == decoderResultElement1.name), "<~~ for JSONDecodable models array should return same as JSONDecoder.decodeArray")
        XCTAssertTrue((resultElement2.id == decoderResultElement2.id), "<~~ for JSONDecodable models array should return same as JSONDecoder.decodeArray")
        XCTAssertTrue((resultElement2.name == decoderResultElement2.name), "<~~ for JSONDecodable models array should return same as JSONDecoder.decodeArray")
    }
    
    func testDecodeOperatorEnumValueReturnsJSONDecoderDecodeEnum() {
        let result: TestModel.EnumValue? = "enumValue" <~~ testJSON!
        let decoderResult: TestModel.EnumValue? = JSONDecoder.decode(enumForKey: "enumValue")(testJSON!)
        
        XCTAssertTrue((result == decoderResult), "<~~ for enum value should return same as JSONDecoder.decodeEnum")
    }
    
    func testDecodeOperatorEnumArrayReturnsJSONDecoderDecodeArray() {
        let result: [TestModel.EnumValue]? = "enumValueArray" <~~ testJSON!
        let resultElement1: TestModel.EnumValue = result![0]
        let resultElement2: TestModel.EnumValue = result![1]
        let resultElement3: TestModel.EnumValue = result![2]
        let decoderResult: [TestModel.EnumValue]? = JSONDecoder.decode(enumArrayForKey: "enumValueArray")(testJSON!)
        let decoderResultElement1: TestModel.EnumValue = decoderResult![0]
        let decoderResultElement2: TestModel.EnumValue = decoderResult![1]
        let decoderResultElement3: TestModel.EnumValue = decoderResult![2]
        
        XCTAssertTrue((resultElement1 == decoderResultElement1), "<~~ for enum value array should return same as JSONDecoder.decodeArray")
        XCTAssertTrue((resultElement2 == decoderResultElement2), "<~~ for enum value array should return same as JSONDecoder.decodeArray")
        XCTAssertTrue((resultElement3 == decoderResultElement3), "<~~ for enum value array should return same as JSONDecoder.decodeArray")
    }
    
    func testDecodeOperatorInt32ReturnsJSONDecoderInt32() {
        let result: Int32? = "int32" <~~ testJSON!
        let decoderResult: Int32? = JSONDecoder.decode(int32ForKey: "int32")(testJSON!)
        
        XCTAssertTrue((result == decoderResult), "<~~ for Int32 should return same as JSONDecoder.decodeInt32")
    }

	func testDecodeOperatorInt32ArrayReturnsJSONDecoderInt32Array() {
		let result: [Int32]? = "int32Array" <~~ testJSON!
        let decoderResult: [Int32]? = JSONDecoder.decode(int32ArrayForKey: "int32Array")(testJSON!)

		XCTAssertTrue((result! == decoderResult!), "<~~ for [Int32] should return same as JSONDecoder.decodeInt32Array")
	}

	func testDecodeOperatorUInt32ReturnsJSONDecoderUInt32() {
		let result: UInt32? = "uInt32" <~~ testJSON!
        let decoderResult: UInt32? = JSONDecoder.decode(uint32ForKey: "uInt32")(testJSON!)

		XCTAssertTrue((result == decoderResult), "<~~ for UInt32 should return same as JSONDecoder.decodeUInt32")
	}

	func testDecodeOperatorUInt32ArrayReturnsJSONDecoderUInt32Array() {
		let result: [UInt32]? = "uInt32Array" <~~ testJSON!
        let decoderResult: [UInt32]? = JSONDecoder.decode(uint32ArrayForKey: "uInt32Array")(testJSON!)

		XCTAssertTrue((result! == decoderResult!), "<~~ for [UInt32] should return same as JSONDecoder.decodeUInt32Array")
	}

    func testDecodeOperatorInt64ReturnsJSONDecoderInt64() {
        let result: Int64? = "int64" <~~ testJSON!
        let decoderResult: Int64? = JSONDecoder.decode(int64ForKey: "int64")(testJSON!)
        
        XCTAssertTrue((result == decoderResult), "<~~ for Int64 should return same as JSONDecoder.decodeInt64")
    }

	func testDecodeOperatorInt64ArrayReturnsJSONDecoderInt64Array() {
		let result: [Int64]? = "int64Array" <~~ testJSON!
        let decoderResult: [Int64]? = JSONDecoder.decode(int64ArrayForKey: "int64Array")(testJSON!)

		XCTAssertTrue((result! == decoderResult!), "<~~ for [Int64] should return same as JSONDecoder.decodeInt64Array")
	}

	func testDecodeOperatorUInt64ReturnsJSONDecoderUInt64() {
		let result: UInt64? = "uInt64" <~~ testJSON!
        let decoderResult: UInt64? = JSONDecoder.decode(uint64ForKey: "uInt64")(testJSON!)

		XCTAssertTrue((result == decoderResult), "<~~ for UInt64 should return same as JSONDecoder.decodeUInt64")
	}

	func testDecodeOperatorUInt64ArrayReturnsJSONDecoderUInt64Array() {
		let result: [UInt64]? = "uInt64Array" <~~ testJSON!
        let decoderResult: [UInt64]? = JSONDecoder.decode(uint64ArrayForKey: "uInt64Array")(testJSON!)

		XCTAssertTrue((result! == decoderResult!), "<~~ for [UInt64] should return same as JSONDecoder.decodeUInt64Array")
	}

    func testDecodeOperatorURLReturnsJSONDecoderDecodeURL() {
        let result: URL? = "url" <~~ testJSON!
        let decoderResult: URL? = JSONDecoder.decode(urlForKey: "url")(testJSON!)
        
        XCTAssertTrue((result == decoderResult), "<~~ for url should return same as JSONDecoder.decodeURL")
    }
    
    func testDecodeOperatorURLArrayReturnsJSONDecoderDecodeURLArray() {
        let result: [URL]? = "urlArray" <~~ testJSON!
        let decoderResult: [URL]? = JSONDecoder.decode(urlArrayForKey: "urlArray")(testJSON!)
        
        XCTAssertTrue((result! == decoderResult!), "<~~ for url array should return same as JSONDecoder.decodeURLArray")
    }
    
    func testDecodeOperatorDecimalReturnsJSONDecoderDecimal() {
        let result: Decimal? = "decimal" <~~ testJSON!
        let decoderResult: Decimal? = JSONDecoder.decode(decimalForKey: "decimal")(testJSON!)
        
        XCTAssertTrue((result == decoderResult), "<~~ for Decimal should return same as JSONDecoder.decodeDecimal")
    }
    
    func testDecodeOperatorDecimalArrayReturnsJSONDecoderDecimalArray() {
        let result: [Decimal]? = "decimalArray" <~~ testJSON!
        let decoderResult: [Decimal]? = JSONDecoder.decode(decimalArrayForKey: "decimalArray")(testJSON!)
        
        XCTAssertTrue((result! == decoderResult!), "<~~ for [Decimal] should return same as JSONDecoder.decodeDecimalArray")
    }
    
    // MARK: - Operator ~~>
    
    func testEncodeOperatorGenericReturnsJSONEncoderEncodeForBool() {
        let bool: Bool? = true
        let resultBool: JSON? = "bool" ~~> bool
        let encoderResultBool: JSON? = JSONEncoder.encode(key: "bool")(bool)
        
        XCTAssertTrue(((resultBool!["bool"] as! Bool) == (encoderResultBool!["bool"] as! Bool)), "~~> for generic value should return same as JSONEncoder.encode for Bool")
    }
    
    func testEncodeOperatorGenericReturnsJSONEncoderEncodeForBoolArray() {
        let boolArray: [Bool]? = [true, false, true]
        let resultBoolArray: JSON? = "boolArray" ~~> boolArray
        let encoderResultBoolArray: JSON? = JSONEncoder.encode(key: "boolArray")(boolArray)
        
        XCTAssertTrue(((resultBoolArray!["boolArray"] as! [Bool]) == (encoderResultBoolArray!["boolArray"] as! [Bool])), "~~> for generic value should return same as JSONEncoder.encode for Bool array")
    }
    
    func testEncodeOperatorGenericReturnsJSONEncoderEncodeForInt() {
        let integer: Int? = 1
        let resultInteger: JSON? = "integer" ~~> integer
        let encoderResultInteger: JSON? = JSONEncoder.encode(key: "integer")(integer)
        
        XCTAssertTrue(((resultInteger!["integer"] as! Int) == (encoderResultInteger!["integer"] as! Int)), "~~> for generic value should return same as JSONEncoder.encode for Int array")
    }
    
    func testEncodeOperatorGenericReturnsJSONEncoderEncodeForIntArray() {
        let integerArray: [Int]? = [1, 2, 3]
        let resultIntegerArray: JSON? = "integerArray" ~~> integerArray
        let encoderResultIntegerArray: JSON? = JSONEncoder.encode(key: "integerArray")(integerArray)
        
        XCTAssertTrue(((resultIntegerArray!["integerArray"] as! [Int]) == (encoderResultIntegerArray!["integerArray"] as! [Int])), "~~> for generic value should return same as JSONEncoder.encode for Int")
    }
    
    func testEncodeOperatorGenericReturnsJSONEncoderEncodeForFloat() {
        let float: Float? = 1.0
        let resultFloat: JSON? = "float" ~~> float
        let encoderResultFloat: JSON? = JSONEncoder.encode(key: "float")(float)
        
        XCTAssertTrue(((resultFloat!["float"] as! Float) == (encoderResultFloat!["float"] as! Float)), "~~> for generic value should return same as JSONEncoder.encode for Float")
    }
    
    func testEncodeOperatorGenericReturnsJSONEncoderEncodeForFloatArray() {
        let floatArray: [Float]? = [1.0, 2.0, 3.0]
        let resultFloatArray: JSON? = "floatArray" ~~> floatArray
        let encoderResultFloatArray: JSON? = JSONEncoder.encode(key: "floatArray")(floatArray)
        
        XCTAssertTrue(((resultFloatArray!["floatArray"] as! [Float]) == (encoderResultFloatArray!["floatArray"] as! [Float])), "~~> for generic value should return same as JSONEncoder.encode for Float array")
    }
    
    func testEncodeOperatorGenericReturnsJSONEncoderEncodeForDouble() {
        let double: Double? = 1.0
        let resultDouble: JSON? = "double" ~~> double
        let encoderResultDouble: JSON? = JSONEncoder.encode(key: "double")(double)
        
        XCTAssertTrue(((resultDouble!["double"] as! Double) == (encoderResultDouble!["double"] as! Double)), "~~> for generic value should return same as JSONEncoder.encode for Double")
    }
    
    func testEncodeOperatorGenericReturnsJSONEncoderEncodeForDoubleArray() {
        let doubleArray: [Double]? = [1.0, 2.0, 3.0]
        let resultDoubleArray: JSON? = "doubleArray" ~~> doubleArray
        let encoderResultDoubleArray: JSON? = JSONEncoder.encode(key: "doubleArray")(doubleArray)
        
        XCTAssertTrue(((resultDoubleArray!["doubleArray"] as! [Double]) == (encoderResultDoubleArray!["doubleArray"] as! [Double])), "~~> for generic value should return same as JSONEncoder.encode for Double array")
    }
    
    func testEncodeOperatorGenericReturnsJSONEncoderEncodeJSONEncodableDictionary() {
        let dictionary: [String : TestNestedModel]? = ["otherModel" : testNestedModel1!]
        let result: JSON? = "dictionary" ~~> dictionary
        let encoderResult: JSON? = JSONEncoder.encode(encodableDictionaryForKey: "dictionary")(dictionary)
        
        let dict = (result!["dictionary"] as! JSON)["otherModel"] as! JSON
        let encDict = (encoderResult!["dictionary"] as! JSON)["otherModel"] as! JSON
        
        XCTAssertTrue(dict["id"] as! Int == encDict["id"] as! Int, "~~> for [String:JSONEncodable] value should return same as JSONEncoder.encodeJSONEncodableDictionary for dictionary")
        XCTAssertTrue(dict["name"] as! String == encDict["name"] as! String, "~~> for [String:JSONEncodable] value should return same as JSONEncoder.encodeJSONEncodableDictionary for dictionary")
    }
    
    func testEncodeOperatorGenericReturnsJSONEncoderEncodeJSONEncodableDictionaryWithArray() {
        let dictionaryWithArray: [String : [TestNestedModel]]? = ["otherModels" : [testNestedModel1!, testNestedModel2!]]
        let result: JSON? = "dictionaryWithArray" ~~> dictionaryWithArray
        let encoderResult: JSON? = JSONEncoder.encode(encodableDictionaryForKey: "dictionaryWithArray")(dictionaryWithArray)
        let dictArray = (result!["dictionaryWithArray"] as! JSON)["otherModels"] as! [JSON]
        let encDictArray = (encoderResult!["dictionaryWithArray"] as! JSON)["otherModels"] as! [JSON]
        
        XCTAssertTrue(dictArray[0]["id"] as! Int == encDictArray[0]["id"] as! Int, "~~> for [String:JSONEncodable] value should return same as JSONEncoder.encodeJSONEncodableDictionary for dictionary")
        XCTAssertTrue(dictArray[0]["name"] as! String == encDictArray[0]["name"] as! String, "~~> for [String:JSONEncodable] value should return same as JSONEncoder.encodeJSONEncodableDictionary for dictionary")
        XCTAssertTrue(dictArray[1]["id"] as! Int == encDictArray[1]["id"] as! Int, "~~> for [String:JSONEncodable] value should return same as JSONEncoder.encodeJSONEncodableDictionary for dictionary")
        XCTAssertTrue(dictArray[1]["name"] as! String == encDictArray[1]["name"] as! String, "~~> for [String:JSONEncodable] value should return same as JSONEncoder.encodeJSONEncodableDictionary for dictionary")
    }
    
    func testEncodeOperatorGenericReturnsJSONEncoderEncodeForString() {
        let string: String? = "abc"
        let resultString: JSON? = "string" ~~> string
        let encoderResultString: JSON? = JSONEncoder.encode(key: "string")(string)
        
        XCTAssertTrue(((resultString!["string"] as! String) == (encoderResultString!["string"] as! String)), "~~> for generic value should return same as JSONEncoder.encode for String")
    }
    
    func testEncodeOperatorGenericReturnsJSONEncoderEncodeForStringArray() {
        let stringArray: [String]? = ["def", "ghi", "jkl"]
        let resultStringArray: JSON? = "stringArray" ~~> stringArray
        let encoderResultStringArray: JSON? = JSONEncoder.encode(key: "stringArray")(stringArray)
        
        XCTAssertTrue(((resultStringArray!["stringArray"] as! [String]) == (encoderResultStringArray!["stringArray"] as! [String])), "~~> for generic value should return same as JSONEncoder.encode for String array")
    }
    
    func testEncodeOperatorJSONEncodableReturnsJSONEncoderEncode() {
        let result: JSON? = "nestedModel" ~~> testNestedModel1
        let modelJSON: JSON = result!["nestedModel"] as! JSON
        let encoderResult: JSON? = JSONEncoder.encode(encodableForKey: "nestedModel")(testNestedModel1)
        let encoderModelJSON: JSON = encoderResult!["nestedModel"] as! JSON
        
        XCTAssertTrue((modelJSON["id"] as! Int == encoderModelJSON["id"] as! Int), "~~> for nested model should return same as JSONEncoder.encode")
        XCTAssertTrue((modelJSON["name"] as! String == encoderModelJSON["name"] as! String), "~~> for nested model should return same as JSONEncoder.encode")
    }
    
    func testEncodeOperatorJSONEncodableArrayReturnsJSONEncoderEncodeArray() {
        let model1: TestNestedModel = testNestedModel1!
        let model2: TestNestedModel = testNestedModel2!
        let result: JSON? = "nestedModelArray" ~~> ([model1, model2])
        let modelsJSON: [JSON] = result!["nestedModelArray"] as! [JSON]
        let model1JSON: JSON = modelsJSON[0]
        let model2JSON: JSON = modelsJSON[1]
        let encoderResult: JSON? = JSONEncoder.encode(encodableArrayForKey: "nestedModelArray")([model1, model2])
        let encoderModelsJSON: [JSON] = encoderResult!["nestedModelArray"] as! [JSON]
        let encoderModel1JSON: JSON = encoderModelsJSON[0]
        let encoderModel2JSON: JSON = encoderModelsJSON[1]
        
        XCTAssertTrue((model1JSON["id"] as! Int == encoderModel1JSON["id"] as! Int), "~~> for nested model array should return same as JSONEncoder.encodeArray")
        XCTAssertTrue((model1JSON["name"] as! String == encoderModel1JSON["name"] as! String), "~~> for nested model array should return same as JSONEncoder.encodeArray")
        XCTAssertTrue((model2JSON["id"] as! Int == encoderModel2JSON["id"] as! Int), "~~> for nested model array should return same as JSONEncoder.encodeArray")
        XCTAssertTrue((model2JSON["name"] as! String == encoderModel2JSON["name"] as! String), "~~> for nested model array should return same as JSONEncoder.encodeArray")
    }
    
    func testEncodeOperatorEnumValueReturnsJSONEncoderEncode() {
        let enumValue: TestModel.EnumValue? = TestModel.EnumValue.A
        let result: JSON? = "enumValue" ~~> enumValue
        let encoderResult: JSON? = JSONEncoder.encode(enumForKey: "enumValue")(enumValue)
        
        XCTAssertTrue(((result!["enumValue"] as! TestModel.EnumValue.RawValue) == (encoderResult!["enumValue"] as! TestModel.EnumValue.RawValue)), "~~> for enum value should return same as JSONEncoder.encodeEnum")
    }
    
    func testEncodeOperatorEnumArrayReturnsJSONEncoderEncodeArray() {
        let enumArray: [TestModel.EnumValue]? = [TestModel.EnumValue.A, TestModel.EnumValue.B, TestModel.EnumValue.C]
        let result: JSON? = "enumValueArray" ~~> enumArray
        let encoderResult: JSON? = JSONEncoder.encode(enumArrayForKey: "enumValueArray")(enumArray)
        
        XCTAssertTrue(((result!["enumValueArray"] as! [TestModel.EnumValue.RawValue]) == (encoderResult!["enumValueArray"] as! [TestModel.EnumValue.RawValue])), "~~> for enum value array should return same as JSONEncoder.encodeArray")
    }
    
    func testEncodeOperatorInt32ReturnsJSONEncoderEncodeInt32() {
        let int32: Int32? = 10000000
        let result: JSON? = "int32" ~~> int32
        let encoderResult: JSON? = JSONEncoder.encode(int32ForKey: "int32")(int32)
        
        XCTAssertTrue((((result!["int32"] as! NSNumber)).int32Value == ((encoderResult!["int32"] as! NSNumber)).int32Value), "~~> for Int32 should return same as JSONEncoder.encodeInt32")
    }
    
    func testEncodeOperatorInt32ArrayReturnsJSONEncoderEncodeInt32Array() {
        let int32Array: [Int32]? = [10000000, -2147483648, 2147483647]
        let result: JSON? = "int32Array" ~~> int32Array
        let encoderResult: JSON? = JSONEncoder.encode(int32ArrayForKey: "int32Array")(int32Array)
        let resultValue = result!["int32Array"] as! [NSNumber]
        let encoderResultValue = encoderResult!["int32Array"] as! [NSNumber]
        
        XCTAssertTrue(resultValue == encoderResultValue, "~~> for [Int32] should return same as JSONEncoder.encodeInt32Array")
    }

	func testEncodeOperatorUInt32ReturnsJSONEncoderEncodeUInt32() {
		let uInt32: UInt32? = 4294967295
		let result: JSON? = "uInt32" ~~> uInt32
		let encoderResult: JSON? = JSONEncoder.encode(uint32ForKey: "uInt32")(uInt32)

		XCTAssertTrue((((result!["uInt32"] as! NSNumber)).uint32Value == ((encoderResult!["uInt32"] as! NSNumber)).uint32Value), "~~> for UInt32 should return same as JSONEncoder.encodeUInt32")
	}

	func testEncodeOperatorUInt32ArrayReturnsJSONEncoderEncodeUInt32Array() {
		let uInt32Array: [UInt32]? = [10000000, 2147483648, 4294967295]
		let result: JSON? = "uInt32Array" ~~> uInt32Array
		let encoderResult: JSON? = JSONEncoder.encode(uint32ArrayForKey: "uInt32Array")(uInt32Array)
		let resultValue = result!["uInt32Array"] as! [NSNumber]
		let encoderResultValue = encoderResult!["uInt32Array"] as! [NSNumber]

		XCTAssertTrue(resultValue == encoderResultValue, "~~> for [UInt32] should return same as JSONEncoder.encodeUInt32Array")
	}

    func testEncodeOperatorInt64ReturnsJSONEncoderEncodeInt64() {
        let int64: Int64? = 30000000
        let result: JSON? = "int64" ~~> int64
        let encoderResult: JSON? = JSONEncoder.encode(int64ForKey: "int64")(int64)
        
        XCTAssertTrue((((result!["int64"] as! NSNumber)).int64Value == ((encoderResult!["int64"] as! NSNumber)).int64Value), "~~> for Int64 should return same as JSONEncoder.encodeInt64")
    }
    
    func testEncodeOperatorInt64ArrayReturnsJSONEncoderEncodeInt64Array() {
        let int64Array: [Int64]? = [30000000, -9223372036854775808, 9223372036854775807]
        let result: JSON? = "int64Array" ~~> int64Array
        let encoderResult: JSON? = JSONEncoder.encode(int64ArrayForKey: "int64Array")(int64Array)
        let resultValue = result!["int64Array"] as! [NSNumber]
        let encoderResultValue = encoderResult!["int64Array"] as! [NSNumber]
        
        XCTAssertTrue(resultValue == encoderResultValue, "~~> for [Int64] should return same as JSONEncoder.encodeInt64Array")
    }

	func testEncodeOperatorUInt64ReturnsJSONEncoderEncodeUInt64() {
		let uInt64: UInt64? = 18446744073709551615
		let result: JSON? = "uInt64" ~~> uInt64
        let encoderResult: JSON? = JSONEncoder.encode(uint64ForKey: "uInt64")(uInt64)

		XCTAssertTrue((((result!["uInt64"] as! NSNumber)).uint64Value == ((encoderResult!["uInt64"] as! NSNumber)).uint64Value), "~~> for UInt64 should return same as JSONEncoder.encodeUInt64")
	}

	func testEncodeOperatorUInt64ArrayReturnsJSONEncoderEncodeUInt64Array() {
		let uInt64Array: [UInt64]? = [30000000, 9223372036854775808, 18446744073709551615]
		let result: JSON? = "uInt64Array" ~~> uInt64Array
        let encoderResult: JSON? = JSONEncoder.encode(uint64ArrayForKey: "uInt64Array")(uInt64Array)
		let resultValue = result!["uInt64Array"] as! [NSNumber]
		let encoderResultValue = encoderResult!["uInt64Array"] as! [NSNumber]

		XCTAssertTrue(resultValue == encoderResultValue, "~~> for [UInt64] should return same as JSONEncoder.encodeUInt64Array")
	}

    func testEncodeOperatorURLReturnsJSONEncoderEncodeURL() {
        let url: URL? = URL(string: "http://github.com")
        let result: JSON? = "url" ~~> url
        let encoderResult: JSON? = JSONEncoder.encode(urlForKey: "url")(url)
        
        XCTAssertTrue(((result!["url"] as! String) == (encoderResult!["url"] as! String)), "~~> for url should return same as JSONEncoder.encodeURL")
    }
    
    func testEncodeOperatorURLArrayReturnsJSONEncoderEncodeURLArray() {
        let urls: [URL]? = [URL(string: "http://github.com")!, URL(string: "http://github.com")!]
        let result: JSON? = "urlArray" ~~> urls
        let encoderResult: JSON? = JSONEncoder.encode(arrayForKey: "urlArray")(urls)
        
        XCTAssertTrue(((result!["urlArray"] as! [URL]) == (encoderResult!["urlArray"] as! [URL])), "~~> for url array should return same as JSONEncoder.encodeArray")
    }
    
    func testEncodeOperatorUUIDReturnsJSONEncoderEncodeUUID() {
        let uuid: UUID? = UUID(uuidString: "964F2FE2-0F78-4C2D-A291-03058C0B98AB")
        let result: JSON? = "uuid" ~~> uuid
        let encoderResult: JSON? = JSONEncoder.encode(uuidForKey: "uuid")(uuid)
        
        XCTAssertTrue(((result!["uuid"] as! String) == (encoderResult!["uuid"] as! String)), "~~> for uuid should return same as JSONEncoder.encodeURL")
    }
    
    func testEncodeOperatorUUIDArrayReturnsJSONEncoderEncodeUUIDArray() {
        let uuids: [UUID]? = [UUID(uuidString: "572099C2-B9AA-42AA-8A25-66E3F3056271")!, UUID(uuidString: "54DB8DCF-F68D-4B55-A3FC-EB8CF4C36B06")!]
        let result: JSON? = "uuidArray" ~~> uuids
        let encoderResult: JSON? = JSONEncoder.encode(arrayForKey: "uuidArray")(uuids)
        
        XCTAssertTrue(((result!["uuidArray"] as! [UUID]) == (encoderResult!["uuidArray"] as! [UUID])), "~~> for uuid array should return same as JSONEncoder.encodeArray")
    }
    
    func testEncodeOperatorDecimalReturnsJSONEncoderEncodeDecimal() {
        let decimal: Decimal? = 3.14159
        let result: JSON? = "decimal" ~~> decimal
        let encoderResult: JSON? = JSONEncoder.encode(decimalForKey: "decimal")(decimal)
        
        XCTAssertTrue((((result!["decimal"] as! NSNumber)).decimalValue == ((encoderResult!["decimal"] as! NSNumber)).decimalValue), "~~> for Decimal should return same as JSONEncoder.encodeDecimal")
    }
    
    func testEncodeOperatorDecimalReturnsJSONEncoderEncodeDecimalArray() {
        let decimalArray: [Decimal]? = [3.14159, 1.618, -2.7182]
        let result: JSON? = "decimalArray" ~~> decimalArray
        let encoderResult: JSON? = JSONEncoder.encode(decimalArrayForKey: "decimalArray")(decimalArray)
        let resultValue = result!["decimalArray"] as! [NSNumber]
        let encoderResultValue = encoderResult!["decimalArray"] as! [NSNumber]
        
        XCTAssertTrue(resultValue == encoderResultValue, "~~> for [Decimal] should return same as JSONEncoder.encodeDecimalArray")
    }
    
}
