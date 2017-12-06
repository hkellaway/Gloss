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

precedencegroup DecodingPrecedence {
    associativity: left
    higherThan: CastingPrecedence
}

/**
Decode custom operator.
*/

infix operator <~~ : DecodingPrecedence

/**
Convenience operator for decoding JSON to generic value.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ <T>(key: String, json: JSON) -> T? {
    return Decoder.decode(key: key)(json)
}

/**
 Convenience operator for decoding JSON to JSONDecodable object.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ <T: JSONDecodable>(key: String, json: JSON) -> T? {
    return Decoder.decode(decodableForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to array of JSONDecodable objects.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ <T: JSONDecodable>(key: String, json: JSON) -> [T]? {
    return Decoder.decode(decodableArrayForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to dictionary of String to JSONDecodable.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ <T: JSONDecodable>(key: String, json: JSON) -> [String : T]? {
    return Decoder.decode(decodableDictionaryForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to dictionary of String to JSONDecodable array.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ <T: JSONDecodable>(key: String, json: JSON) -> [String : [T]]? {
    return Decoder.decode(decodableDictionaryForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to enum value.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ <T: RawRepresentable>(key: String, json: JSON) -> T? {
    return Decoder.decode(enumForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to array of enum values.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ <T: RawRepresentable>(key: String, json: JSON) -> [T]? {
    return Decoder.decode(enumArrayForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to Int32.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) -> Int32? {
    return Decoder.decode(int32ForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to Int32 array.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) -> [Int32]? {
    return Decoder.decode(int32ArrayForKey: key)(json)
}

/**
Convenience operator for decoding JSON to UInt32.

- parameter key:  JSON key for value to decode.
- parameter json: JSON.

- returns: Decoded value when successful, nil otherwise.
*/
public func <~~ (key: String, json: JSON) -> UInt32? {
    return Decoder.decode(uint32ForKey: key)(json)
}

/**
Convenience operator for decoding JSON to UInt32 array.

- parameter key:  JSON key for value to decode.
- parameter json: JSON.

- returns: Decoded value when successful, nil otherwise.
*/
public func <~~ (key: String, json: JSON) -> [UInt32]? {
    return Decoder.decode(uint32ArrayForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to Int64.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) -> Int64? {
    return Decoder.decode(int64ForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to Int64 array.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) -> [Int64]? {
    return Decoder.decode(int64ArrayForKey: key)(json)
}

/**
Convenience operator for decoding JSON to UInt64.

- parameter key:  JSON key for value to decode.
- parameter json: JSON.

- returns: Decoded value when successful, nil otherwise.
*/
public func <~~ (key: String, json: JSON) -> UInt64? {
    return Decoder.decode(uint64ForKey: key)(json)
}

/**
Convenience operator for decoding JSON to UInt64 array.

- parameter key:  JSON key for value to decode.
- parameter json: JSON.

- returns: Decoded value when successful, nil otherwise.
*/
public func <~~ (key: String, json: JSON) -> [UInt64]? {
    return Decoder.decode(uint64ArrayForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to URL.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) -> URL? {
    return Decoder.decode(urlForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to array of URLs.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) -> [URL]? {
    return Decoder.decode(urlArrayForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to UUID.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) -> UUID? {
    return Decoder.decode(uuidForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to array of UUIDs.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) -> [UUID]? {
    return Decoder.decode(uuidArrayForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to Double.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) -> Double? {
    return Decoder.decode(doubleForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to Double array.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) -> [Double]? {
    return Decoder.decode(doubleArrayForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to Decimal.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) -> Decimal? {
    return Decoder.decode(decimalForKey: key)(json)
}

/**
 Convenience operator for decoding JSON to Decimal array.
 
 - parameter key:  JSON key for value to decode.
 - parameter json: JSON.
 
 - returns: Decoded value when successful, nil otherwise.
 */
public func <~~ (key: String, json: JSON) -> [Decimal]? {
    return Decoder.decode(decimalArrayForKey: key)(json)
}

// MARK: - Operator ~~> (Encode)

precedencegroup EncodingPrecedence {
    associativity: left
    higherThan: CastingPrecedence
}

/**
Encode custom operator.
*/
infix operator ~~> : EncodingPrecedence

/**
Convenience operator for encoding generic value to JSON
*/

/**
 Convenience operator for encoding a generic value to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> <T>(key: String, property: T?) -> JSON? {
    return Encoder.encode(key: key)(property)
}

/**
 Convenience operator for encoding an array of generic values to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> <T>(key: String, property: [T]?) -> JSON? {
    return Encoder.encode(arrayForKey: key)(property)
}

/**
 Convenience operator for encoding an JSONEncodable object to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> <T: JSONEncodable>(key: String, property: T?) -> JSON? {
    return Encoder.encode(encodableForKey: key)(property)
}

/**
 Convenience operator for encoding an array of JSONEncodable objects to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> <T: JSONEncodable>(key: String, property: [T]?) -> JSON? {
    return Encoder.encode(encodableArrayForKey: key)(property)
}

/**
 Convenience operator for encoding a dictionary of String to JSONEncodable to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> <T: JSONEncodable>(key: String, property: [String : T]?) -> JSON? {
    return Encoder.encode(encodableDictionaryForKey: key)(property)
}

/**
 Convenience operator for encoding a dictionary of String to JSONEncodable array to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> <T: JSONEncodable>(key: String, property: [String : [T]]?) -> JSON? {
    return Encoder.encode(encodableDictionaryForKey: key)(property)
}

/**
 Convenience operator for encoding an enum value to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> <T: RawRepresentable>(key: String, property: T?) -> JSON? {
    return Encoder.encode(enumForKey: key)(property)
}

/**
 Convenience operator for encoding an array of enum values to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> <T: RawRepresentable>(key: String, property: [T]?) -> JSON? {
    return Encoder.encode(enumArrayForKey: key)(property)
}

/**
 Convenience operator for encoding an Int32 to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: Int32?) -> JSON? {
    return Encoder.encode(int32ForKey: key)(property)
}

/**
 Convenience operator for encoding an Int32 array to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: [Int32]?) -> JSON? {
    return Encoder.encode(int32ArrayForKey: key)(property)
}

/**
Convenience operator for encoding an UInt32 to JSON.

- parameter key:      JSON key for value to encode.
- parameter property: Object to encode to JSON.

- returns: JSON when successful, nil otherwise.
*/
public func ~~> (key: String, property: UInt32?) -> JSON? {
	return Encoder.encode(uint32ForKey: key)(property)
}

/**
Convenience operator for encoding an UInt32 array to JSON.

- parameter key:      JSON key for value to encode.
- parameter property: Object to encode to JSON.

- returns: JSON when successful, nil otherwise.
*/
public func ~~> (key: String, property: [UInt32]?) -> JSON? {
	return Encoder.encode(uint32ArrayForKey: key)(property)
}

/**
 Convenience operator for encoding an Int64 to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: Int64?) -> JSON? {
    return Encoder.encode(int64ForKey: key)(property)
}

/**
 Convenience operator for encoding an Int64 array to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: [Int64]?) -> JSON? {
    return Encoder.encode(int64ArrayForKey: key)(property)
}

/**
Convenience operator for encoding an UInt64 to JSON.

- parameter key:      JSON key for value to encode.
- parameter property: Object to encode to JSON.

- returns: JSON when successful, nil otherwise.
*/
public func ~~> (key: String, property: UInt64?) -> JSON? {
    return Encoder.encode(uint64ForKey: key)(property)
}

/**
Convenience operator for encoding an UInt64 array to JSON.

- parameter key:      JSON key for value to encode.
- parameter property: Object to encode to JSON.

- returns: JSON when successful, nil otherwise.
*/
public func ~~> (key: String, property: [UInt64]?) -> JSON? {
    return Encoder.encode(uint64ArrayForKey: key)(property)
}

/**
 Convenience operator for encoding a URL to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: URL?) -> JSON? {
    return Encoder.encode(urlForKey: key)(property)
}

/**
 Convenience operator for encoding a UUID to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: UUID?) -> JSON? {
    return Encoder.encode(uuidForKey: key)(property)
}

/**
 Convenience operator for encoding a Double to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: Double?) -> JSON? {
    return Encoder.encode(doubleForKey: key)(property)
}

/**
 Convenience operator for encoding a Double array to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: [Double]?) -> JSON? {
    return Encoder.encode(doubleArrayForKey: key)(property)
}

/**
 Convenience operator for encoding a Decimal to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: Decimal?) -> JSON? {
    return Encoder.encode(decimalForKey: key)(property)
}

/**
 Convenience operator for encoding a Decimal array to JSON.
 
 - parameter key:      JSON key for value to encode.
 - parameter property: Object to encode to JSON.
 
 - returns: JSON when successful, nil otherwise.
 */
public func ~~> (key: String, property: [Decimal]?) -> JSON? {
    return Encoder.encode(decimalArrayForKey: key)(property)
}
