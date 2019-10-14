//
//  TestModel.swift
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

struct TestModel: Glossy {
    
    let bool: Bool
    let boolArray: [Bool]?
    let integer: Int?
    let integerArray: [Int]?
    let float: Float?
    let floatArray: [Float]?
    let dictionary: [String : TestNestedModel]?
    let dictionaryWithArray: [String : [TestNestedModel]]?
    let double: Double?
    let doubleArray: [Double]?
    let string: String?
    let stringArray: [String]?
    let nestedModel: TestNestedModel?
    let nestedModelArray: [TestNestedModel]?
    let enumValue: EnumValue?
    let enumValueArray: [EnumValue]?
    let date: Date?
    let dateArray: [Date]?
    let dateISO8601: Date?
    let dateISO8601Array: [Date]?
    let int32: Int32?
    let int32Array: [Int32]?
	let uInt32: UInt32?
	let uInt32Array: [UInt32]?
	let int64: Int64?
    let int64Array: [Int64]?
	let uInt64: UInt64?
	let uInt64Array: [UInt64]?
	let url: URL?
    let urlArray: [URL]?
    let uuid: UUID?
    let uuidArray: [UUID]?
    let decimal: Decimal?
    let decimalArray: [Decimal]?
    
    enum EnumValue: String {
        case A = "A"
        case B = "B"
        case C = "C"
    }
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        guard
            let bool: Bool = "bool" <~~ json
            else { return nil }
        
        self.bool = bool
        self.boolArray = "boolArray" <~~ json
        self.integer = "integer" <~~ json
        self.integerArray = "integerArray" <~~ json
        self.float = "float" <~~ json
        self.floatArray = "floatArray" <~~ json
        self.double = "double" <~~ json
        self.doubleArray = "doubleArray" <~~ json
        self.dictionary = "dictionary" <~~ json
        self.dictionaryWithArray = "dictionaryWithArray" <~~ json
        self.string = "string" <~~ json
        self.stringArray = "stringArray" <~~ json
        self.nestedModel = "nestedModel" <~~ json
        self.nestedModelArray = "nestedModelArray" <~~ json
        self.enumValue = "enumValue" <~~ json
        self.enumValueArray = "enumValueArray" <~~ json
        self.date = Decoder.decode(dateForKey: "date", dateFormatter: TestModel.dateFormatter)(json)
        self.dateArray = Decoder.decode(dateArrayForKey: "dateArray", dateFormatter: TestModel.dateFormatter)(json)
        self.dateISO8601 = Decoder.decode(dateISO8601ForKey: "dateISO8601")(json)
        self.dateISO8601Array = Decoder.decode(dateISO8601ArrayForKey: "dateISO8601Array")(json)
        self.int32 = "int32" <~~ json
        self.int32Array = "int32Array" <~~ json
		self.uInt32 = "uInt32" <~~ json
		self.uInt32Array = "uInt32Array" <~~ json
        self.int64 = "int64" <~~ json
        self.int64Array = "int64Array" <~~ json
		self.uInt64 = "uInt64" <~~ json
		self.uInt64Array = "uInt64Array" <~~ json
        self.url = "url" <~~ json
        self.urlArray = "urlArray" <~~ json
        self.uuid = "uuid" <~~ json
        self.uuidArray = "uuidArray" <~~ json
        self.decimal = "decimal" <~~ json
        self.decimalArray = "decimalArray" <~~ json
    }

    // MARK: - Serialization

    func toJSON() -> JSON? {
        return jsonify([
            "bool" ~~> self.bool,
            "boolArray" ~~> self.boolArray,
            "integer" ~~> self.integer,
            "integerArray" ~~> self.integerArray,
            "float" ~~> self.float,
            "floatArray" ~~> self.floatArray,
            "double" ~~> self.double,
            "doubleArray" ~~> self.doubleArray,
            "dictionary" ~~> self.dictionary,
            "dictionaryWithArray" ~~> self.dictionaryWithArray,
            "string" ~~> self.string,
            "stringArray" ~~> self.stringArray,
            "nestedModel" ~~> self.nestedModel,
            "nestedModelArray" ~~> self.nestedModelArray,
            "enumValue" ~~> self.enumValue,
            "enumValueArray" ~~> self.enumValueArray,
            Encoder.encode(dateForKey: "date", dateFormatter: TestModel.dateFormatter)(self.date),
            Encoder.encode(dateArrayForKey: "dateArray", dateFormatter: TestModel.dateFormatter)(self.dateArray),
            Encoder.encode(dateISO8601ForKey: "dateISO8601")(self.dateISO8601),
            Encoder.encode(dateISO8601ArrayForKey: "dateISO8601Array")(self.dateISO8601Array),
            "int32" ~~> self.int32,
            "int32Array" ~~> self.int32Array,
			"uInt32" ~~> self.uInt32,
			"uInt32Array" ~~> self.uInt32Array,
			"int64" ~~> self.int64,
            "int64Array" ~~> self.int64Array,
			"uInt64" ~~> self.uInt64,
			"uInt64Array" ~~> self.uInt64Array,
			"url" ~~> self.url,
            "urlArray" ~~> self.urlArray,
            "uuid" ~~> self.uuid,
            "uuidArray" ~~> self.uuidArray,
            "decimal" ~~> self.decimal,
            "decimalArray" ~~> self.decimalArray
            ])
    }
    
    static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        return dateFormatter
        }()
    
}

// Since Swift Package Manager doesn't support fixtures (i.e. stored JSON), we have to access the JSON using this method rather than reading file from Bundle.
#if SWIFT_PACKAGE
extension TestModel {
    static var testJSON: JSON {
        return [
            "bool" : true,
            "boolArray" : [true, false, true],
            "integer" : 1,
            "integerArray" : [1, 2, 3],
            "float" : Float(2.0),
            "floatArray" : [Float(1.0), Float(2.0), Float(3.0)],
            "double" : Double(6.0),
            "doubleArray" : [Double(4.0), Double(5), Double(6.0)],
            "dictionary" : [
                "otherModel" : [
                    "id" : 789,
                    "name" : "otherModel1"
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
                "name" : "nestedModel1",
                "uuid" : "BA34F5F0-E5AA-4ECE-B25C-90195D7AF0D0",
                "url" : "http://github.com"
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
            "int32Array" : [100000000, -2147483648, 2147483647],
            "uInt32" : 4294967295,
            "uInt32Array" : [100000000, 2147483648, 4294967295],
            "int64" : 300000000,
            "int64Array" : [300000000, -9223372036854775808, 9223372036854775807],
            "uInt64" : 18446744073709551615 as UInt64,
            "uInt64Array" : [300000000, 9223372036854775808 as UInt64, 18446744073709551615 as UInt64],
            "url" : "http://github.com",
            "urlArray" : ["http://github.com", "http://github.com", "http://github.com"],
            "uuid" : "964F2FE2-0F78-4C2D-A291-03058C0B98AB",
            "uuidArray" : ["572099C2-B9AA-42AA-8A25-66E3F3056271", "54DB8DCF-F68D-4B55-A3FC-EB8CF4C36B06", "982CED72-743A-45F8-87CF-278386D32EBF"],
            "decimal": 3.14159,
            "decimalArray": [3.14159, 1.618, -2.7182]
        ]
    }
}
#endif
