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
    var testNestedModel1: TestNestedModel? = nil
    var testNestedModel2: TestNestedModel? = nil
    
    override func setUp() {
        super.setUp()
        
        let testJSONPath: NSString = NSBundle(forClass: self.dynamicType).pathForResource("TestModel", ofType: "json")!
        let testJSONData: NSData = NSData(contentsOfFile: testJSONPath as String)!
        
        do {
            try testJSON = NSJSONSerialization.JSONObjectWithData(testJSONData, options: NSJSONReadingOptions(rawValue: 0)) as? JSON
        } catch {
            print(error)
        }
        
        testNestedModel1 = TestNestedModel(json: [ "id" : 1, "name" : "nestedModel1" ])
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
        let decoderResultInvalid: String? = Decoder.decode("invalid")(testJSON!)
        
        XCTAssertTrue((resultInvalid == decoderResultInvalid), "<~~ for invalid value should return same as Decoder.decode")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForBool() {
        let resultBool: Bool? = "bool" <~~ testJSON!
        let decoderResultBool: Bool? = Decoder.decode("bool")(testJSON!)
        
        XCTAssertTrue((resultBool == decoderResultBool), "<~~ for generic value should return same as Decoder.decode for Bool")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForBoolArray() {
        let resultBoolArray: [Bool]? = "boolArray" <~~ testJSON!
        let decoderResultBoolArray: [Bool]? = Decoder.decode("boolArray")(testJSON!)
        
        XCTAssertTrue((resultBoolArray! == decoderResultBoolArray!), "<~~ for generic value should return same as Decoder.decode for Bool array")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForInt() {
        let resultInt: Int? = "integer" <~~ testJSON!
        let decoderResultInt: Int? = Decoder.decode("integer")(testJSON!)
        
        XCTAssertTrue((resultInt == decoderResultInt), "<~~ for generic value should return same as Decoder.decode for Int")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForIntArray() {
        let resultIntArray: [Int]? = "integerArray" <~~ testJSON!
        let decoderResultIntArray: [Int]? = Decoder.decode("integerArray")(testJSON!)
        
        XCTAssertTrue((resultIntArray! == decoderResultIntArray!), "<~~ for generic value should return same as Decoder.decode for Int array")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForFloat() {
        let resultFloat: Float? = "float" <~~ testJSON!
        let decoderResultFloat: Float? = Decoder.decode("float")(testJSON!)
        
        XCTAssertTrue((resultFloat == decoderResultFloat), "<~~ for generic value should return same as Decoder.decode for Float")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForFloatArray() {
        let resultFloatArray: [Float]? = "floatArray" <~~ testJSON!
        let decoderResultFloatArray: [Float]? = Decoder.decode("floatArray")(testJSON!)
        
        XCTAssertTrue((resultFloatArray! == decoderResultFloatArray!), "<~~ for generic value should return same as Decoder.decode for Float array")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForDouble() {
        let resultDouble: Double? = "double" <~~ testJSON!
        let decoderResultDouble: Double? = Decoder.decode("double")(testJSON!)
        
        XCTAssertTrue((resultDouble == decoderResultDouble), "<~~ for generic value should return same as Decoder.decode for Double")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForDoubleArray() {
        let resultDoubleArray: [Double]? = "doubleArray" <~~ testJSON!
        let decoderResultDoubleArray: [Double]? = Decoder.decode("doubleArray")(testJSON!)
        
        XCTAssertTrue((resultDoubleArray! == decoderResultDoubleArray!), "<~~ for generic value should return same as Decoder.decode for Double array")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodableDictionary() {
        let resultDictionary: [String : TestNestedModel]? = "dictionary" <~~ testJSON!
        let decoderDictionary: [String : TestNestedModel]? = Decoder.decodeDecodableDictionary("dictionary")(testJSON!)
        
        XCTAssertTrue(resultDictionary!["otherModel"]! == decoderDictionary!["otherModel"]!, "<~~ for generic value should result same as Decoder.decodeDecodableDictionary for dictionary")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForString() {
        let resultString: String? = "string" <~~ testJSON!
        let decoderResultString: String? = Decoder.decode("string")(testJSON!)
        
        XCTAssertTrue((resultString == decoderResultString), "<~~ for generic value should return same as Decoder.decode for String")
    }
    
    func testDecodeOperatorGenericReturnsDecoderDecodeForStringArray() {
        let resultStringArray: [String]? = "stringArray" <~~ testJSON!
        let decoderResultStringArray: [String]? = Decoder.decode("stringArray")(testJSON!)
        
        XCTAssertTrue((resultStringArray! == decoderResultStringArray!), "<~~ for generic value should return same as Decoder.decode for String array")
    }
    
    func testDecodeOperatorDecodableReturnsDecoderDecode() {
        let resultNestedModel: TestNestedModel? = "nestedModel" <~~ testJSON!
        let decoderResultNestedModel: TestNestedModel? = Decoder.decodeDecodable("nestedModel")(testJSON!)
        
        XCTAssertTrue((resultNestedModel!.id == decoderResultNestedModel!.id), "<~~ for Decodable models should return same as Decoder.decode")
        XCTAssertTrue((resultNestedModel!.name == decoderResultNestedModel!.name), "<~~ for Decodable models should return same as Decoder.decode")
    }
    
    func testDecodeOperatorDecodableArrayReturnsDecoderDecodeArray() {
        let result: [TestNestedModel]? = "nestedModelArray" <~~ testJSON!
        let resultElement1: TestNestedModel = result![0]
        let resultElement2: TestNestedModel = result![1]
        let decoderResult: [TestNestedModel]? = Decoder.decodeDecodableArray("nestedModelArray")(testJSON!)
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
    
    func testDecodeOperatorEnumArrayReturnsDecoderDecodeArray() {
        let result: [TestModel.EnumValue]? = "enumValueArray" <~~ testJSON!
        let resultElement1: TestModel.EnumValue = result![0]
        let resultElement2: TestModel.EnumValue = result![1]
        let resultElement3: TestModel.EnumValue = result![2]
        let decoderResult: [TestModel.EnumValue]? = Decoder.decodeEnumArray("enumValueArray")(testJSON!)
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
    
    func testDecodeOperatorURLArrayReturnsDecoderDecodeURLArray() {
        let result: [NSURL]? = "urlArray" <~~ testJSON!
        let decoderResult: [NSURL]? = Decoder.decodeURLArray("urlArray")(testJSON!)
        
        XCTAssertTrue((result! == decoderResult!), "<~~ for url array should return same as Decoder.decodeURLArray")
    }
    
    // MARK: - Operator ~~>
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForBool() {
        let bool: Bool? = true
        let resultBool: JSON? = "bool" ~~> bool
        let encoderResultBool: JSON? = Encoder.encode("bool")(bool)
        
        XCTAssertTrue(((resultBool!["bool"] as! Bool) == (encoderResultBool!["bool"] as! Bool)), "~~> for generic value should return same as Encoder.encode for Bool")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForBoolArray() {
        let boolArray: [Bool]? = [true, false, true]
        let resultBoolArray: JSON? = "boolArray" ~~> boolArray
        let encoderResultBoolArray: JSON? = Encoder.encode("boolArray")(boolArray)
        
        XCTAssertTrue(((resultBoolArray!["boolArray"] as! [Bool]) == (encoderResultBoolArray!["boolArray"] as! [Bool])), "~~> for generic value should return same as Encoder.encode for Bool array")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForInt() {
        let integer: Int? = 1
        let resultInteger: JSON? = "integer" ~~> integer
        let encoderResultInteger: JSON? = Encoder.encode("integer")(integer)
        
        XCTAssertTrue(((resultInteger!["integer"] as! Int) == (encoderResultInteger!["integer"] as! Int)), "~~> for generic value should return same as Encoder.encode for Int array")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForIntArray() {
        let integerArray: [Int]? = [1, 2, 3]
        let resultIntegerArray: JSON? = "integerArray" ~~> integerArray
        let encoderResultIntegerArray: JSON? = Encoder.encode("integerArray")(integerArray)
        
        XCTAssertTrue(((resultIntegerArray!["integerArray"] as! [Int]) == (encoderResultIntegerArray!["integerArray"] as! [Int])), "~~> for generic value should return same as Encoder.encode for Int")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForFloat() {
        let float: Float? = 1.0
        let resultFloat: JSON? = "float" ~~> float
        let encoderResultFloat: JSON? = Encoder.encode("float")(float)
        
        XCTAssertTrue(((resultFloat!["float"] as! Float) == (encoderResultFloat!["float"] as! Float)), "~~> for generic value should return same as Encoder.encode for Float")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForFloatArray() {
        let floatArray: [Float]? = [1.0, 2.0, 3.0]
        let resultFloatArray: JSON? = "floatArray" ~~> floatArray
        let encoderResultFloatArray: JSON? = Encoder.encode("floatArray")(floatArray)
        
        XCTAssertTrue(((resultFloatArray!["floatArray"] as! [Float]) == (encoderResultFloatArray!["floatArray"] as! [Float])), "~~> for generic value should return same as Encoder.encode for Float array")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForDouble() {
        let double: Double? = 1.0
        let resultDouble: JSON? = "double" ~~> double
        let encoderResultDouble: JSON? = Encoder.encode("double")(double)
        
        XCTAssertTrue(((resultDouble!["double"] as! Double) == (encoderResultDouble!["double"] as! Double)), "~~> for generic value should return same as Encoder.encode for Double")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForDoubleArray() {
        let doubleArray: [Double]? = [1.0, 2.0, 3.0]
        let resultDoubleArray: JSON? = "doubleArray" ~~> doubleArray
        let encoderResultDoubleArray: JSON? = Encoder.encode("doubleArray")(doubleArray)
        
        XCTAssertTrue(((resultDoubleArray!["doubleArray"] as! [Double]) == (encoderResultDoubleArray!["doubleArray"] as! [Double])), "~~> for generic value should return same as Encoder.encode for Double array")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeEncodableDictionary() {
        let dictionary: [String : TestNestedModel]? = ["otherModel" : testNestedModel1!]
        let result: JSON? = "dictionary" ~~> dictionary
        let encoderResult: JSON? = Encoder.encodeEncodableDictionary("dictionary")(dictionary)
        
        XCTAssertTrue((result!["otherModel"]!["id"]) == (encoderResult!["otherModel"]!["id"]), "~~> for generic value should return same as Encoder.encodeEncodableDictionary for dictionary")
        XCTAssertTrue((result!["otherModel"]!["name"]) == (encoderResult!["otherModel"]!["name"]), "~~> for generic value should return same as Encoder.encodeEncodableDictionary for dictionary")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForString() {
        let string: String? = "abc"
        let resultString: JSON? = "string" ~~> string
        let encoderResultString: JSON? = Encoder.encode("string")(string)
        
        XCTAssertTrue(((resultString!["string"] as! String) == (encoderResultString!["string"] as! String)), "~~> for generic value should return same as Encoder.encode for String")
    }
    
    func testEncodeOperatorGenericReturnsEncoderEncodeForStringArray() {
        let stringArray: [String]? = ["def", "ghi", "jkl"]
        let resultStringArray: JSON? = "stringArray" ~~> stringArray
        let encoderResultStringArray: JSON? = Encoder.encode("stringArray")(stringArray)
        
        XCTAssertTrue(((resultStringArray!["stringArray"] as! [String]) == (encoderResultStringArray!["stringArray"] as! [String])), "~~> for generic value should return same as Encoder.encode for String array")
    }
    
    func testEncodeOperatorEncodableReturnsEncoderEncode() {
        let result: JSON? = "nestedModel" ~~> testNestedModel1
        let modelJSON: JSON = result!["nestedModel"] as! JSON
        let encoderResult: JSON? = Encoder.encodeEncodable("nestedModel")(testNestedModel1)
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
        let encoderResult: JSON? = Encoder.encodeEncodableArray("nestedModelArray")([model1, model2])
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
        let encoderResult: JSON? = Encoder.encodeEnum("enumValue")(enumValue)
        
        XCTAssertTrue(((result!["enumValue"] as! TestModel.EnumValue.RawValue) == (encoderResult!["enumValue"] as! TestModel.EnumValue.RawValue)), "~~> for enum value should return same as Encoder.encodeEnum")
    }
    
    func testEncodeOperatorEnumArrayReturnsEncoderEncodeArray() {
        let enumArray: [TestModel.EnumValue]? = [TestModel.EnumValue.A, TestModel.EnumValue.B, TestModel.EnumValue.C]
        let result: JSON? = "enumValueArray" ~~> enumArray
        let encoderResult: JSON? = Encoder.encodeEnumArray("enumValueArray")(enumArray)
        
        XCTAssertTrue(((result!["enumValueArray"] as! [TestModel.EnumValue.RawValue]) == (encoderResult!["enumValueArray"] as! [TestModel.EnumValue.RawValue])), "~~> for enum value array should return same as Encoder.encodeArray")
    }
    
    func testEncodeOperatorURLReturnsEncoderEncodeURL() {
        let url: NSURL? = NSURL(string: "http://github.com")
        let result: JSON? = "url" ~~> url
        let encoderResult: JSON? = Encoder.encodeURL("url")(url)
        
        XCTAssertTrue(((result!["url"] as! String) == (encoderResult!["url"] as! String)), "~~> for url should return same as Encoder.encodeURL")
    }
    
    func testEncodeOperatorURLArrayReturnsEncoderEncodeURLArray() {
        let urls: [NSURL]? = [NSURL(string: "http://github.com")!, NSURL(string: "http://github.com")!]
        let result: JSON? = "urlArray" ~~> urls
        let encoderResult: JSON? = Encoder.encodeArray("urlArray")(urls)
        
        XCTAssertTrue(((result!["urlArray"] as! [NSURL]) == (encoderResult!["urlArray"] as! [NSURL])), "~~> for url array should return same as Encoder.encodeArray")
    }
    
}
