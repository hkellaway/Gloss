//
//  Operators.swift
//  Gloss
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

// MARK: - Operator <~~ (Decode)

/**
Decode custom operator
*/
infix operator <~~ { associativity left precedence 150 }

/**
Convenience operator for decoding JSON to generic value
*/
public func <~~ <T>(key: String, json: JSON) -> T? {
    return Decoder.decode(key)(json)
}

/**
Convenience operator for decoding JSON to Decodable object
*/
public func <~~ <T: Decodable>(key: String, json: JSON) -> T? {
    return Decoder.decodeDecodable(key)(json)
}

/**
Convenience operator for decoding JSON to enum value
*/
public func <~~ <T: RawRepresentable>(key: String, json: JSON) -> T? {
    return Decoder.decodeEnum(key)(json)
}

/**
Convenience operator for decoding JSON to NSURL
*/
public func <~~ (key: String, json: JSON) -> NSURL? {
    return Decoder.decodeURL(key)(json)
}

/**
Convenience operator for decoding JSON to array of enum values
*/
public func <~~ <T: RawRepresentable>(key: String, json: JSON) -> [T]? {
    return Decoder.decodeEnumArray(key)(json)
}

/**
Convenience operator for decoding JSON to array of Decodable objects
*/
public func <~~ <T: Decodable>(key: String, json: JSON) -> [T]? {
    return Decoder.decodeDecodableArray(key)(json)
}

/**
 Convenience operator for decoding JSON to array of URLs
 */
public func <~~ (key: String, json: JSON) -> [NSURL]? {
    return Decoder.decodeURLArray(key)(json)
}

/**
 Convenience operator for decoding JSON to Dictionary of String, Decodable objects
 */
public func <~~ <T: Decodable>(key: String, json: JSON) -> [String : T]? {
    return Decoder.decodeDecodableDictionary(key)(json)
}

// MARK: - Operator ~~> (Encode)

/**
Encode custom operator
*/
infix operator ~~> { associativity left precedence 150 }

/**
Convenience operator for encoding generic value to JSON
*/
public func ~~> <T>(key: String, property: T?) -> JSON? {
    return Encoder.encode(key)(property)
}

/**
Convenience operator for encoding Encodable object to JSON
*/
public func ~~> <T: Encodable>(key: String, property: T?) -> JSON? {
    return Encoder.encodeEncodable(key)(property)
}

/**
Convenience operator for encoding enum value to JSON
*/
public func ~~> <T: RawRepresentable>(key: String, property: T?) -> JSON? {
    return Encoder.encodeEnum(key)(property)
}

/**
Convenience operator for encoding NSURL to JSON
*/
public func ~~> (key: String, property: NSURL?) -> JSON? {
    return Encoder.encodeURL(key)(property)
}

/**
Convenience operator for encoding array of generic objects to JSON
*/
public func ~~> <T>(key: String, property: [T]?) -> JSON? {
    return Encoder.encodeArray(key)(property)
}

/**
Convenience operator for encoding array of Encodable objects to JSON
*/
public func ~~> <T: Encodable>(key: String, property: [T]?) -> JSON? {
    return Encoder.encodeEncodableArray(key)(property)
}

/**
Convenience operator for encoding array of enum values to JSON
*/
public func ~~> <T: RawRepresentable>(key: String, property: [T]?) -> JSON? {
    return Encoder.encodeEnumArray(key)(property)
}

/**
 Convenience operator for encoding dictionary of Encodable objects to JSON
 */
public func ~~> <T: Encodable>(key: String, property: [String : T]?) -> JSON? {
    return Encoder.encodeEncodableDictionary(key)(property)
}
