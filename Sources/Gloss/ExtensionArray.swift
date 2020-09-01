//
//  ExtensionArray.swift
//  Gloss
//
// Copyright (c) 2016 Rahul Katariya
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

// MARK: - Migration to Codable

public extension Array where Element: JSONDecodable & Decodable {
    
    /**
     Returns array of new objects created from provided JSON array.
     If any decodings fail, nil is returned.
     
     - parameter jsonArray: Array of JSON representations of objects.
     
     - returns: Array of objects created from JSON.
     */
    static func from(decodableJSONArray jsonArray: [JSON], jsonDecoder: JSONDecoder = JSONDecoder(), serializer: JSONSerializer = GlossJSONSerializer(), options: JSONSerialization.WritingOptions? = nil, logger: Logger = GlossLogger()) -> [Element]? {
        var models: [Element] = []
        
        for json in jsonArray {
            let model: Element? = .from(decodableJSON: json, jsonDecoder: jsonDecoder, serializer: serializer, options: options, logger: logger)
            
            if let model = model {
                models.append(model)
            } else {
                return nil
            }
        }
        
        return models
    }
    
    /**
     Returns array of new objects created from provided data.
     If creation of JSON or any decodings fail, nil is returned.
     
     - parameter data:        Raw JSON data.
     - parameter jsonDecoder: A `Swift.JSONDecoder`.
     - parameter serializer:  Serializer to use when creating JSON from data.
     - parameter ooptions:    Options for reading the JSON data.
     - parameter logger:        Logs issues with `Swift.Decodable`.
     
     - returns: Object or nil.
     */
    static func from(decodableData data: Data, jsonDecoder: JSONDecoder = JSONDecoder(), serializer: JSONSerializer = GlossJSONSerializer(), options: JSONSerialization.ReadingOptions = .mutableContainers, logger: GlossLogger = GlossLogger()) -> [Element]? {
        do {
            let jsonArray = try jsonDecoder.decode([Element].self, from: data)
            return jsonArray
        } catch {
            logger.log(message: "Swift.Decodable error: \(error)")
            
            guard
                let jsonArray = serializer.jsonArray(from: data, options: options),
                let models = [Element].from(jsonArray: jsonArray) else {
                    return nil
            }

            return models
        }
    }
    
}

public extension Array where Element: JSONEncodable & Encodable {
    
    /**
     Encodes array of objects as JSON array.
     If any encodings fail, nil is returned.
     
     - returns: Array of JSON created from objects.
     */
    func toEncodableJSONArray(jsonEncoder: JSONEncoder = JSONEncoder(), serializer: JSONSerializer = GlossJSONSerializer(), options: JSONSerialization.ReadingOptions = .mutableContainers, logger: Logger = GlossLogger()) -> [JSON]? {
        var jsonArray: [JSON] = []
        
        for json in self {
            if let json = json.toEncodableJSON(jsonEncoder: jsonEncoder, serializer: serializer, options: options, logger: logger) {
                jsonArray.append(json)
            } else {
                return nil
            }
        }
        
        return jsonArray
    }
    
}

// MARK: - JSONDecodable

public extension Array where Element: JSONDecodable {
    
    // MARK: Public functions
    
    /**
     Returns array of new objects created from provided JSON array.
     If any decodings fail, nil is returned.
     
     - parameter jsonArray: Array of JSON representations of objects.
     
     - returns: Array of objects created from JSON.
     */
    static func from(jsonArray: [JSON]) -> [Element]? {
        var models: [Element] = []
        
        for json in jsonArray {
            let model = Element(json: json)
            
            if let model = model {
                models.append(model)
            } else {
                return nil
            }
        }
        
        return models
    }

    /**
     Initializes array of model objects from provided data.
     
     - parameter data: Raw JSON array data.
     
     - returns: Array with model objects when decoding is successful, empty otherwise.
     */
    
    /**
     Returns array of new objects created from provided data.
     If creation of JSON or any decodings fail, nil is returned.
     
     - parameter data:       Raw JSON data.
     - parameter serializer: Serializer to use when creating JSON from data.
     - parameter ooptions:   Options for reading the JSON data.
     
     - returns: Object or nil.
     */
    static func from(data: Data, serializer: JSONSerializer = GlossJSONSerializer(), options: JSONSerialization.ReadingOptions = .mutableContainers) -> [Element]? {
        guard
            let jsonArray = serializer.jsonArray(from: data, options: options),
            let models = [Element].from(jsonArray: jsonArray) else {
                return nil
        }
        
        return models
    }
    
}

// MARK: - JSONEncodable

public extension Array where Element: JSONEncodable {
    
    // MARK: Public functions
    
    /**
     Encodes array of objects as JSON array.
     If any encodings fail, nil is returned.
     
     - returns: Array of JSON created from objects.
     */
    func toJSONArray() -> [JSON]? {
        var jsonArray: [JSON] = []
        
        for json in self {
            if let json = json.toJSON() {
                jsonArray.append(json)
            } else {
                return nil
            }
        }
        
        return jsonArray
    }
}

