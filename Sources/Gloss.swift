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

public typealias JSON = [String : Any]

// MARK: - Protocols

/**
Convenience protocol for objects that can be translated from and to JSON.
*/
public protocol Glossy: Decodable, Encodable { }

/**
Enables an object to be decoded from JSON.
*/
public protocol Decodable {

    /**
     Returns new instance created from provided JSON.

     - parameter: json: JSON representation of object.
     */
    init?(json: JSON)

}

/**
Enables an object to be encoded to JSON.
*/
public protocol Encodable {
    
    /**
    Encodes and object as JSON.
     
     - returns: JSON when encoding was successful, nil otherwise.
    */
    func toJSON() -> JSON?
    
}

// MARK: - Global

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

/**
 Default delimiter used for nested key paths.
 
 - returns: Default key path delimiter.
 */
public private(set) var GlossKeyPathDelimiter: String = {
    return "."
}()

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
                setValue(inDictionary: &json, value: value, forKeyPath: key, withDelimiter: keyPathDelimiter)
            }
        }
    }
    
    return json
}

/**
 Sets value for provided key path delimited by provided delimiter.
 
 - parameter valueToSet:    Value to set
 - parameter keyPath:       Key path.
 - parameter withDelimiter: Delimiter for key path.
 */
public func setValue(inDictionary dict: inout JSON, value: Any, forKeyPath: String, withDelimiter: String = GlossKeyPathDelimiter) {
    
    var keyComponents = forKeyPath.components(separatedBy:withDelimiter)
    
    guard let firstKey = keyComponents.first else {
        return
    }
    
    keyComponents.remove(at: 0)
    
    if keyComponents.isEmpty {
        dict[firstKey] = value
    } else {
        let rejoined = keyComponents.joined(separator: withDelimiter)
        var subdict : JSON = [:]
        
        if let existingSubDict = dict[firstKey] as? JSON {
            subdict = existingSubDict
        }
        
        setValue(inDictionary: &subdict, value:value, forKeyPath: rejoined, withDelimiter: withDelimiter)
        dict[firstKey] = subdict
        
    }
}
