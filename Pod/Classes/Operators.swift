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

// MARK: - Operator <~~  (Decode)

infix operator <~~ { associativity left precedence 150 }

public func <~~ <T>(key: String, json: JSON) -> T? {
    return Decoder.decode(key)(json)
}

public func <~~ <T: Decodable>(key: String, json: JSON) -> T? {
    return Decoder.decode(key)(json)
}

public func <~~ <T>(key: String, json: JSON) -> [ [String : T] ]? {
    return Decoder.decodeArray(key)(json)
}

public func <~~ <T: Decodable>(key: String, json: JSON) -> [T]? {
    return Decoder.decodeArray(key)(json)
}

public func <~~ <T: RawRepresentable>(key: String, json: JSON) -> T? {
    return Decoder.decodeEnum(key)(json)
}

public func <~~ (key: String, json: JSON) -> NSURL? {
    return Decoder.decodeURL(key)(json)
}

// MARK: - Operator ~~> (Encode)

infix operator ~~> { associativity left precedence 150 }

public func ~~> <T>(key: String, property: T?) -> JSON? {
    return Encoder.encode(key)(property)
}

public func ~~> <T: Encodable>(key: String, property: T?) -> JSON? {
    return Encoder.encode(key)(property)
}

public func ~~> <T>(key: String, property: [T]?) -> JSON? {
    return Encoder.encodeArray(key)(property)
}

public func ~~> <T: Encodable>(key: String, property: [T]?) -> JSON? {
    return Encoder.encodeArray(key)(property)
}

public func ~~> <T: RawRepresentable>(key: String, property: T?) -> JSON? {
    return Encoder.encodeEnum(key)(property)
}

public func ~~> (key: String, property: NSURL?) -> JSON? {
    return Encoder.encodeURL(key)(property)
}
