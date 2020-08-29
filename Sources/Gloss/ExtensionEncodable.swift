//
//  ExtensionEncodable.swift
//  Gloss
//
// Copyright (c) 2020 Harlan Kellaway
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

// MARK: - Migration to Swift.Encodable

public extension JSONEncodable where Self:Encodable {
    
    /**
     Encodes provided model as JSON.
     
     - parameter model:      Model to encode as JSon.
     - parameter serializer: Serializer to use when creating JSON from data.
     - parameter options:    Options for reading the JSON data.
     - parameter logger:     Logs issues with `Swift.Encodable`.
     
     - returns: Object or nil.
     */
    func toEncodableJSON(jsonEncoder: JSONEncoder = JSONEncoder(), serializer: JSONSerializer = GlossJSONSerializer(), options: JSONSerialization.ReadingOptions = .mutableContainers, logger: Logger = GlossLogger()) -> JSON? {
        do {
            let data = try jsonEncoder.encode(self)
            return serializer.json(from: data, options: options)
        } catch {
            logger.log(message: "Swift.Encodable error: \(error)")
            return self.toJSON()
        }
    }
    
}
