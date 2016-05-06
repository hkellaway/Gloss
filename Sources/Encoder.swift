//
//  Encoder.swift
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

/**
Encodes objects to JSON.
*/
public struct Encoder {
    
    /**
     Encodes a generic value to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encode<T>(key: String) -> T? -> JSON? {
        return {
            property in
            
            if let property = property as? AnyObject {
                return [key : property]
            }
            
            return nil
        }
    }
    
    /**
     Encodes a generic value array to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encodeArray<T>(key: String) -> [T]? -> JSON? {
        return {
            array in
            
            if let array = array as? AnyObject {
                return [key : array]
            }
            
            return nil
        }
    }
    
    /**
     Encodes a date to JSON.
     
     - parameter key:           Key used in JSON for decoded value.
     - parameter dateFormatter: Date formatter used to encode date.
     
     - returns: JSON encoded from value.
     */
    public static func encodeDate(key: String, dateFormatter: NSDateFormatter) -> NSDate? -> JSON? {
        return {
            date in
            
            if let date = date {
                return [key : dateFormatter.stringFromDate(date)]
            }
            
            return nil
        }
    }
    
    /**
     Encodes a date array to JSON.
     
     - parameter key:           Key used in JSON for decoded value.
     - parameter dateFormatter: Date formatter used to encode date.
     
     - returns: JSON encoded from value.
     */
    public static func encodeDateArray(key: String, dateFormatter: NSDateFormatter) -> [NSDate]? -> JSON? {
        return {
            dates in
            
            if let dates = dates {
                var dateStrings: [String] = []
                
                for date in dates {
                    let dateString = dateFormatter.stringFromDate(date)
                    
                    dateStrings.append(dateString)
                }
                
                return [key : dateStrings]
            }
            
            return nil
        }
    }
    
    /**
     Encodes an ISO8601 date to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encodeDateISO8601(key: String) -> NSDate? -> JSON? {
        return Encoder.encodeDate(key, dateFormatter: GlossDateFormatterISO8601)
    }
    
    /**
     Encodes an ISO8601 date array to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encodeDateISO8601Array(key: String) -> [NSDate]? -> JSON? {
        return Encoder.encodeDateArray(key, dateFormatter: GlossDateFormatterISO8601)
    }
    
    /**
     Encodes an Encodable object to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encodeEncodable<T: Encodable>(key: String) -> T? -> JSON? {
        return {
            model in
            
            if let model = model, json = model.toJSON() {
                return [key : json]
            }
            
            return nil
        }
    }
    
    /**
     Encodes an Encodable array to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encodeEncodableArray<T: Encodable>(key: String) -> [T]? -> JSON? {
        return {
            array in
            
            if let array = array {
                var encodedArray: [JSON] = []
                
                for model in array {
                    if let json = model.toJSON() {
                        encodedArray.append(json)
                    }
                }
                
                return [key : encodedArray]
            }
            
            return nil
        }
    }
    
    /**
     Encodes a dictionary of String to Encodable to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encodeEncodableDictionary<T: Encodable>(key: String) -> [String : T]? -> JSON? {
        return {
            dictionary in
            
            guard let dictionary = dictionary else {
                return nil
            }
            
            let encoded : [String : JSON] = dictionary.flatMap { (key, value) in
                guard let json = value.toJSON() else {
                    return nil
                }
                
                return (key, json)
            }
            
            return [key : encoded]
        }
    }
    
    /**
     Encodes a dictionary of String to Encodable array to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encodeEncodableDictionary<T: Encodable>(key: String) -> [String : [T]]? -> JSON? {
        return {
            dictionary in
            
            guard let dictionary = dictionary else {
                return nil
            }
            
            let encoded : [String : [JSON]] = dictionary.flatMap {
                (key, value) in
                
                guard let jsonArray = value.toJSONArray() else {
                    return nil
                }
                
                return (key, jsonArray)
            }
            
            return [key : encoded]
        }
    }
    
    /**
     Encodes an enum value to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encodeEnum<T: RawRepresentable>(key: String) -> T? -> JSON? {
        return {
            enumValue in
            
            if let enumValue = enumValue {
                return [key : enumValue.rawValue as! AnyObject]
            }
            
            return nil
        }
    }
    
    /**
     Encodes an enum value array to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encodeEnumArray<T: RawRepresentable>(key: String) -> [T]? -> JSON? {
        return {
            enumValues in
            
            if let enumValues = enumValues {
                var rawValues: [T.RawValue] = []
                
                for enumValue in enumValues {
                    rawValues.append(enumValue.rawValue)
                }
                
                return [key : rawValues as! AnyObject]
            }
            
            return nil
        }
    }
    
    /**
     Encodes an Int32 to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encodeInt32(key: String) -> Int32? -> JSON? {
        return {
            int32 in
            
            if let int32 = int32 {
                return [key : NSNumber(int: int32)]
            }
            
            return nil
        }
    }
    
    /**
     Encodes an Int64 to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encodeInt64(key: String) -> Int64? -> JSON? {
        return {
            int64 in
            
            if let int64 = int64 {
                return [key : NSNumber(longLong: int64)]
            }
            
            return nil
        }
    }
    
    /**
     Encodes a URL to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encodeURL(key: String) -> NSURL? -> JSON? {
        return {
            url in
            
            if let url = url {
                return [key : url.absoluteString]
            }
            
            return nil
        }
    }
    
}
