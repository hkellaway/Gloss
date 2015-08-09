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

struct Decoder {
    
    static func decode<T>(key: String) -> JSON -> T? {
        return {
            json in

            if let value = json[key] as? T {
                return value
            }

            return nil
        }
    }

    static func decode<T: Glossy>(key: String) -> JSON -> T? {
        return {
            json in

            if let value = json[key] as? JSON {
                return T(json: value)
            }
            
            return nil
            
        }
    }

    // MARK: - Custom Decoders
    
    static func decodeArray<T>(key: String) -> JSON -> [ [String : T] ]? {
        return { return $0[key] as? [ [String : T] ] }
    }
    
    static func decodeDate(key: String, dateFormatter: NSDateFormatter) -> JSON -> NSDate? {
        return {
            json in
            
            if let dateString = json[key] as? String {
                return dateFormatter.dateFromString(dateString)
            }
            
            return nil
        }
    }
    
    static func decodeDateISO8601(key: String, dateFormatter: NSDateFormatter) -> JSON -> NSDate? {
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        return Decoder.decodeDate(key, dateFormatter: dateFormatter)
    }
    
    static func decodeEnum<T: RawRepresentable>(key: String) -> JSON -> T? {
        return {
            json in
            
            if let rawValue = json[key] as? T.RawValue {
                return T(rawValue: rawValue)
            }
            
            return nil
        }
    }
    
    static func decodeURL(key: String) -> JSON -> NSURL? {
        return {
            json in

            if let urlString = json[key] as? String {
                return NSURL(string: urlString)
            }

            return nil
        }
    }
}

