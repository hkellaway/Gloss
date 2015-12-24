//
//  Gloss.swift
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

// MARK: - Types

public typealias JSON = [String : AnyObject]

// MARK: - Protocols

/**
Convenience protocol for objects that can be
translated from and to JSON
*/
public protocol Glossy: Decodable, Encodable { }

/**
Enables an object to be decoded from JSON
*/
public protocol Decodable {
    
    /**
    Returns new instance created from provided JSON
    
    :parameter: json JSON representation of object
    */
    init?(json: JSON)
    
    /**
    Returns array of new instances created from provided JSON array
    
    :parameter: jsonArray Array of JSON representations of object
    */
    static func modelsFromJSONArray(jsonArray: [JSON]) -> [Self]?
    
}

/**
Extension of Decodable protocol with default implementations
*/
public extension Decodable {
    
    /**
    Returns array of new instances created from provided JSON array
    
    Note: The returned array will have only models that successfully
    decoded
    
    :parameter: jsonArray Array of JSON representations of object
    */
    static func modelsFromJSONArray(jsonArray: [JSON]) -> [Self]? {
        var models: [Self] = []
        
        for json in jsonArray {
            let model = Self(json: json)
            if let model = model {
                models.append(model)
            }
        }
        
        return models
    }
    
}

/**
Enables an object to be encoded to JSON
*/
public protocol Encodable {
    
    /**
    Object encoded as JSON
    */
    func toJSON() -> JSON?
    
    /**
    Returns an array of provided objects encoded as a JSON array
    
    :parameter: models Array of models to be encoded as JSON
    */
    static func toJSONArray(models:[Self]) -> [JSON]?
}

/**
Extension of Encodable protocol with default implementations
*/
public extension Encodable {
    
    /**
    Returns an array of provided objects encoded as a JSON array
    
    Note: The returned array will have only JSON that successfully
    encoded
    
    :parameter: models Array of models to be encoded as JSON
    */
    static func toJSONArray(models:[Self]) -> [JSON]? {
        var jsonArray: [JSON] = []
        
        for model in models {
            let json = model.toJSON()
            
            if let json = json {
                jsonArray.append(json)
            }
        }
        
        return jsonArray
    }
    
}

// MARK: - Global functions

/**
Transforms an array of JSON optionals
to a single optional JSON dictionary
*/
public func jsonify(array: [JSON?]) -> JSON? {
    var json: JSON = [:]
    
    for j in array {
        if(j != nil) {
            json.add(j!)
        }
    }
    
    return json
}
