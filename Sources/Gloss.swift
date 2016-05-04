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
public private(set) var GlossDateFormatterISO8601: NSDateFormatter = {
    let dateFormatterISO8601 = NSDateFormatter()
    
    // WORKAROUND to ignore device configuration regarding AM/PM http://openradar.appspot.com/radar?id=1110403
    dateFormatterISO8601.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    dateFormatterISO8601.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

    // translate to Gregorian calendar if other calendar is selected in system settings
    let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    
    gregorian.timeZone = NSTimeZone(abbreviation: "GMT")!
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
 - parameter keyPathDelimiter: Delimiter used for nested key paths.
 
 - returns: JSON when successful, nil otherwise.
 */
public func jsonify(array: [JSON?], keyPathDelimiter: String = GlossKeyPathDelimiter) -> JSON? {
    var json: JSON = [:]
    
    for j in array {
        if(j != nil) {
            json.add(j!, delimiter: keyPathDelimiter)
        }
    }
    
    return json
}
