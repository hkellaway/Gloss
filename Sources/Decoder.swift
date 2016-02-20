//
//  Decoder.swift
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
Set of functions used to decode JSON to objects
*/
public struct Decoder {
    
    // MARK: - Decoders
    
    /**
    Returns function to decode JSON to value type
    
    :parameter: key              JSON key used to set value
    :parameter: keyPathDelimiter Delimiter used for nested keypath keys
    
    :returns: Function decoding JSON to an optional value type
    */
    public static func decode<T>(key: String, keyPathDelimiter: String = GlossKeyPathDelimiter()) -> JSON -> T? {
        return {
            json in
            
            if let value = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? T {
                return value
            }
            
            return nil
        }
    }
    
    /**
    Returns function to decode JSON to value type
    for objects that conform to the Decodable protocol
    
    :parameter: key JSON key used to set value
    :parameter: keyPathDelimiter Delimiter used for nested keypath keys
    
    :returns: Function decoding JSON to an optional value type
    */
    public static func decodeDecodable<T: Decodable>(key: String, keyPathDelimiter: String = GlossKeyPathDelimiter()) -> JSON -> T? {
        return {
            json in
            
            if let subJSON = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? JSON {
                return T(json: subJSON)
            }
            
            return nil
            
        }
    }
    
    /**
    Returns function to decode JSON to date
    
    :parameter: key           JSON key used to set value
    :parameter: dateFormatter Formatter used to format date
    :parameter: keyPathDelimiter Delimiter used for nested keypath keys
    
    :returns: Function decoding JSON to an optional date
    */
    public static func decodeDate(key: String, dateFormatter: NSDateFormatter, keyPathDelimiter: String = GlossKeyPathDelimiter()) -> JSON -> NSDate? {
        return {
            json in
            
            if let dateString = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? String {
                return dateFormatter.dateFromString(dateString)
            }
            
            return nil
        }
    }
    
    /**
    Returns function to decode JSON to ISO8601 date
    
    :parameter: key           JSON key used to set value
    :parameter: dateFormatter Formatter with ISO8601 format
    :parameter: keyPathDelimiter Delimiter used for nested keypath keys
    
    - returns: Function decoding JSON to an optional ISO8601 date
    */
    public static func decodeDateISO8601(key: String, keyPathDelimiter: String = GlossKeyPathDelimiter()) -> JSON -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        return Decoder.decodeDate(key, dateFormatter: dateFormatter, keyPathDelimiter: keyPathDelimiter)
    }
    
    /**
    Returns function to decode JSON to enum value
    
    :parameter: key JSON key used to set value
    :parameter: keyPathDelimiter Delimiter used for nested keypath keys
    
    :returns: Function decoding JSON to an optional enum value
    */
    public static func decodeEnum<T: RawRepresentable>(key: String, keyPathDelimiter: String = GlossKeyPathDelimiter()) -> JSON -> T? {
        return {
            json in
            
            if let rawValue = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? T.RawValue {
                return T(rawValue: rawValue)
            }
            
            return nil
        }
    }
    
    /**
    Returns function to decode JSON to URL
    
    :parameter: key JSON key used to set value
    :parameter: keyPathDelimiter Delimiter used for nested keypath keys
    
    :returns: Function decoding JSON to an optional URL
    */
    public static func decodeURL(key: String, keyPathDelimiter: String = GlossKeyPathDelimiter()) -> JSON -> NSURL? {
        return {
            json in
            
            if let urlString = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? String,
                encodedString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
                    return NSURL(string: encodedString)
            }
            
            return nil
        }
    }
    
    /**
    Returns function to decode JSON to array
    for objects that conform to the Glossy protocol
    
    :parameter: key JSON key used to set value
    :parameter: keyPathDelimiter Delimiter used for nested keypath keys
    
    :returns: Function decoding JSON to an optinal array
    */
    public static func decodeDecodableArray<T: Decodable>(key: String, keyPathDelimiter: String = GlossKeyPathDelimiter()) -> JSON -> [T]? {
        return {
            json in
            
            if let jsonArray = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? [JSON] {
                var models: [T] = []
                
                for subJSON in jsonArray {
                    if let model = T(json: subJSON) {
                        models.append(model)
                    }
                }
                
                return models
            }
            
            return nil
        }
    }
    
    /**
     Returns function to decode JSON to dictionary of
     objects that conform to the Glossy protocol
     
     :parameter: key JSON key used to set value
     :parameter: keyPathDelimiter Delimiter used for nested keypath keys
     
     :returns: Function decoding JSON to an optional dictionary
     */
    public static func decodeDecodableDictionary<T:Decodable>(key: String, keyPathDelimiter: String = GlossKeyPathDelimiter()) -> JSON -> [String:T]? {
        return {
            json in
            
            guard let dictionary = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? [String : JSON] else {
                return nil
            }
            
            return dictionary.flatMap { (key, value) in
                guard let decoded = T(json: value) else {
                    return nil
                }
                
                return (key, decoded)
            }
        }
    }
    
    /**
    Returns function to decode JSON to enum array
    of enum values
    
    :parameter: key JSON key used to set value
    :parameter: keyPathDelimiter Delimiter used for nested keypath keys
    
    :returns: Function decoding JSON to an optional enum array
    */
    public static func decodeEnumArray<T: RawRepresentable>(key: String, keyPathDelimiter: String = GlossKeyPathDelimiter()) -> JSON -> [T]? {
        return {
            json in
            
            if let rawValues = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? [T.RawValue] {
                var enumValues: [T] = []
                
                for rawValue in rawValues {
                    if let enumValue = T(rawValue: rawValue) {
                        enumValues.append(enumValue)
                    }
                }
                
                return enumValues
            }
            
            return nil
        }
    }
    
    /**
     Returns function to decode JSON to date array
     
     :parameter: key           JSON key used to set value
     :parameter: dateFormatter Formatter used to format date
     :parameter: keyPathDelimiter Delimiter used for nested keypath keys
     
     :returns: Function decoding JSON to an optional date array
     */
    public static func decodeDateArray(key: String, dateFormatter: NSDateFormatter, keyPathDelimiter: String = GlossKeyPathDelimiter()) -> JSON -> [NSDate]? {
        return {
            json in
            
            if let dateStrings = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? [String] {
                var dates: [NSDate] = []
                
                for dateString in dateStrings {
                    if let date = dateFormatter.dateFromString(dateString) {
                        dates.append(date)
                    }
                }
                
                return dates
            }
            
            return nil
        }
    }
    
    /**
     Returns function to decode JSON to ISO8601 date array
     
     :parameter: key           JSON key used to set value
     :parameter: dateFormatter Formatter with ISO8601 format
     :parameter: keyPathDelimiter Delimiter used for nested keypath keys
     
     - returns: Function decoding JSON to an optional ISO8601 date array
     */
    public static func decodeDateISO8601Array(key: String, keyPathDelimiter: String = GlossKeyPathDelimiter()) -> JSON -> [NSDate]? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        return Decoder.decodeDateArray(key, dateFormatter: dateFormatter, keyPathDelimiter: keyPathDelimiter)
    }
    
    /**
     Returns function to decode JSON to URL array
     
     :parameter: key JSON key used to set value
     :parameter: keyPathDelimiter Delimiter used for nested keypath keys
     
     :returns: Function decoding JSON to an optional URL array
     */
    public static func decodeURLArray(key: String, keyPathDelimiter: String = GlossKeyPathDelimiter()) -> JSON -> [NSURL]? {
        return {
            json in
            
            if let urlStrings = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? [String] {
                var urls: [NSURL] = []
                
                for urlString in urlStrings {
                    if let url = NSURL(string: urlString) {
                        urls.append(url)
                    }
                }
                
                return urls
            }
            
            return nil
        }
    }
    
}
