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

// MARK: JSON

public typealias JSON = [String : Any]

// MARK: - Protocols

/**
Convenience protocol for objects that can be translated from and to JSON.
*/
public protocol Glossy: JSONDecodable, JSONEncodable { }

/**
Enables an object to be decoded from JSON.
*/
public protocol JSONDecodable {

    /**
     Returns new instance created from provided JSON.

     - parameter json: JSON representation of object.
     
     - returns: New instance when JSON parsing successful, false otherwise.
     */
    init?(json: JSON)
    
}

/**
Enables an object to be encoded to JSON.
*/
public protocol JSONEncodable {
    
    /**
    Encodes and object as JSON.
     
     - returns: JSON when encoding was successful, nil otherwise.
    */
    func toJSON() -> JSON?
    
}

// MARK: - Global

// MARK: DateFormatter

/**
Date formatter used for ISO8601 dates.
 
 - returns: Date formatter.
 */
public private(set) var GlossDateFormatterISO8601: DateFormatter = {

    let dateFormatterISO8601 = DateFormatter()
    
    // WORKAROUND to ignore device configuration regarding AM/PM http://openradar.appspot.com/radar?id=1110403
    dateFormatterISO8601.locale = Locale(identifier: "en_US_POSIX")
    dateFormatterISO8601.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

    // translate to Gregorian calendar if other calendar is selected in system settings
    var gregorian = Calendar(identifier: Calendar.Identifier.gregorian)
    
    gregorian.timeZone = TimeZone(abbreviation: "GMT")!
    dateFormatterISO8601.calendar = gregorian

    return dateFormatterISO8601
    
}()

// MARK: JSONSerializer

/// Creates JSON from data.
public protocol JSONSerializer {
    
    /**
     Creates JSON from provided data.
     
     - parameter data:    Data to create JSON from.
     - parameter options: Options for reading the JSON data.
     
     - returns: JSON if created successfully, nil otherwise.
     */
    func json(from data: Data, options: JSONSerialization.ReadingOptions) -> JSON?
    
    /**
     Creates JSON array from provided data.
     
     - parameter data:    Data to create JSON array from.
     - parameter options: Options for reading the JSON data.
     
     - returns: JSON array if created successfully, nil otherwise.
     */
    func jsonArray(from data: Data, options: JSONSerialization.ReadingOptions) -> [JSON]?
    
}

/// Gloss JSON Serializer.
public struct GlossJSONSerializer: JSONSerializer {
    
    /// Creates a new instance.
    public init() { }

    public func json(from data: Data, options: JSONSerialization.ReadingOptions) -> JSON? {
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: options)) as? JSON else {
            return nil
        }
        
        return json
    }
    
    public func jsonArray(from data: Data, options: JSONSerialization.ReadingOptions) -> [JSON]? {
        guard let jsonArray = (try? JSONSerialization.jsonObject(with: data, options: options)) as? [JSON] else {
            return nil
        }
        
        return jsonArray
    }

}

// MARK: Logger

/// Logs messages about unexpected behavior.
public protocol Logger {
    
    /// Logs provided message.
    ///
    /// - Parameter message: Message.
    func log(message: String)
    
}

/// Gloss Logger.
public struct GlossLogger: Logger {

    /// Creates a new instance.
    public init() { }
    
    public func log(message: String) {
        print("[Gloss] \(message)")
    }
    
}

// MARK: GlossKeyPathDelimiter

/**
 Default delimiter used for nested key paths.
 
 - returns: Default key path delimiter.
 */
public private(set) var GlossKeyPathDelimiter: String = {
    return "."
}()

// MARK: jsonify

/**
 Transforms an array of JSON optionals to a single optional JSON dictionary.
 
 - parameter array:            Array of JSON to transform.
 
 - returns: JSON when successful, nil otherwise.
 */
public func jsonify(_ array: [JSON?], keyPathDelimiter: String = GlossKeyPathDelimiter) -> JSON? {
    var json: JSON = [:]
    
    for j in array {
        if(j != nil) {
            for (key,value) in j! {
                setValue(inJSON: &json, value: value, forKeyPath: key, withDelimiter: keyPathDelimiter)
            }
        }
    }
    
    return json
}

// MARK: Private

/**
 Sets value for provided key path delimited by provided delimiter.
 
 Keypath can be delimited to represent a value present in nested JSON -
 e.g. given a delimiter of '.', a valid keypath might be "owner.profile.id"
 
 - parameter valueToSet:    Value to set
 - parameter keyPath:       Key path.
 - parameter withDelimiter: Delimiter for key path.
 */
private func setValue(inJSON json: inout JSON, value: Any, forKeyPath keyPath: String, withDelimiter delimiter: String = GlossKeyPathDelimiter) {
    var keyComponents = keyPath.components(separatedBy:delimiter)
    
    guard let firstKey = keyComponents.first else {
        return
    }
    
    keyComponents.remove(at: 0)
    
    if keyComponents.isEmpty {
        json[firstKey] = value
    } else {
        let rejoined = keyComponents.joined(separator: delimiter)
        var subJSON: JSON = [:]
        
        if let existingSubJSON = json[firstKey] as? JSON {
            subJSON = existingSubJSON
        }
        
        setValue(inJSON: &subJSON, value:value, forKeyPath: rejoined, withDelimiter: delimiter)
        json[firstKey] = subJSON
    }
    
}
