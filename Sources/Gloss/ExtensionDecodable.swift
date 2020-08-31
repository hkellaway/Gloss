//
//  ExtensionJSONDecodable.swift
//  Gloss
//
// Copyright © 2017 kampro
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

import Foundation

public extension JSONDecodable {
    
    /**
     Initializes array of model objects from provided data.
     
     - parameter data:       Raw JSON data.
     - parameter serializer: Serializer to use when creating JSON from data.
     - parameter options:    Options for reading the JSON data.
     
     - returns: Object or nil.
     */
    init?(data: Data, serializer: JSONSerializer = GlossJSONSerializer(), options: JSONSerialization.ReadingOptions = .mutableContainers) {
        if let json = serializer.json(from: data, options: options) {
            self.init(json: json)
            return
        }
        
        return nil
    }
    
    // MARK: - Migration to Swift.Decodable
    
    /**
     Attempts to create a Gloss model using `Swift.Decodable`.
     Will fallback to Gloss initialization in case of error.
     
     - parameter data:          Raw JSON data.
     - parameter jsonDecoder:   A `Swift.JSONDecoder`.
     - parameter serializer:    Serializes JSON to data and vice versa.
     - parameter options:       Options for reading the JSON data.
     - parameter logger:        Logs issues with `Swift.Decodable`.
     
     - returns: Object or nil.
     */
    static func from<T: Decodable & JSONDecodable>(decodableData data: Data, jsonDecoder: JSONDecoder = JSONDecoder(), serializer: JSONSerializer = GlossJSONSerializer(), options: JSONSerialization.ReadingOptions = .mutableContainers, logger: Logger = GlossLogger()) -> T? {
        do {
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
            logger.log(message: "Swift.Decodable error: \(error)")
            return T(data: data, serializer: serializer, options: options)
        }
    }
    
    /**
     Attempts to create a Gloss model using `Swift.Decodable`.
     Will fallback to Gloss initialization in case of error.
     
     - parameter json:          JSON to create model from.
     - parameter jsonDecoder:   A `Swift.JSONDecoder`.
     - parameter serializer:    Serializes JSON to data and vice versa.
     - parameter options:       Options for writing the JSON data.
     - parameter logger:        Logs issues with `Swift.Decodable`.
     
     - returns: Object or nil.
     */
    static func from<T: Decodable & JSONDecodable>(decodableJSON json: JSON, jsonDecoder: JSONDecoder = JSONDecoder(), serializer: JSONSerializer = GlossJSONSerializer(), options: JSONSerialization.WritingOptions? = nil, logger: Logger = GlossLogger()) -> T? {
        do {
            if let data = serializer.data(from: json, options: options) {
                return try jsonDecoder.decode(T.self, from: data)
            } else {
                return T(json: json)
            }
        } catch {
            logger.log(message: "Swift.Decodable error: \(error)")
            return T(json: json)
        }
    }
    
}
