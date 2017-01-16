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
    public static func encode<T>(key: String) -> (T?) -> JSON? {
        return {
            property in
            
            if let property = property {
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
    public static func encode<T>(arrayForKey key: String) -> ([T]?) -> JSON? {
        return {
            array in
            
            if let array = array {
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
    public static func encode(dateForKey key: String, dateFormatter: DateFormatter) -> (Date?) -> JSON? {
        return {
            date in
            
            if let date = date {
                return [key : dateFormatter.string(from: date)]
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
    public static func encode(dateArrayForKey key: String, dateFormatter: DateFormatter) -> ([Date]?) -> JSON? {
        return {
            dates in
            
            if let dates = dates {
                var dateStrings: [String] = []
                
                for date in dates {
                    let dateString = dateFormatter.string(from: date)
                    
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
    public static func encode(dateISO8601ForKey key: String) -> (Date?) -> JSON? {
        return Encoder.encode(dateForKey: key, dateFormatter: GlossDateFormatterISO8601)
    }
    
    /**
     Encodes an ISO8601 date array to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encode(dateISO8601ArrayForKey key: String) -> ([Date]?) -> JSON? {
        return Encoder.encode(dateArrayForKey: key, dateFormatter: GlossDateFormatterISO8601)
    }
    
    /**
     Encodes an Encodable object to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encode<T: Encodable>(encodableForKey key: String) -> (T?) -> JSON? {
        return {
            model in
            
            if let model = model, let json = model.toJSON() {
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
    public static func encode<T: Encodable>(encodableArrayForKey key: String) -> ([T]?) -> JSON? {
        return {
            array in
            
            if let array = array {
                var encodedArray: [JSON] = []
                
                for model in array {
                    guard let json = model.toJSON() else {
                        return nil
                    }
                    
                    encodedArray.append(json)
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
    public static func encode<T: Encodable>(encodableDictionaryForKey key: String) -> ([String : T]?) -> JSON? {
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
    public static func encode<T: Encodable>(encodableDictionaryForKey key: String) -> ([String : [T]]?) -> JSON? {
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
    public static func encode<T: RawRepresentable>(enumForKey key: String) -> (T?) -> JSON? {
        return {
            enumValue in
            
            if let enumValue = enumValue {
                return [key : enumValue.rawValue]
            }
            
            return nil
        }
    }
    
    /**
     Encodes an enum value array to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encode<T: RawRepresentable>(enumArrayForKey key: String) -> ([T]?) -> JSON? {
        return {
            enumValues in
            
            if let enumValues = enumValues {
                var rawValues: [T.RawValue] = []
                
                for enumValue in enumValues {
                    rawValues.append(enumValue.rawValue)
                }
                
                return [key : rawValues]
            }
            
            return nil
        }
    }
    
    /**
     Encodes an Int32 to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encode(int32ForKey key: String) -> (Int32?) -> JSON? {
        return {
            int32 in
            
            if let int32 = int32 {
                return [key : NSNumber(value: int32)]
            }
            
            return nil
        }
    }
    
    /**
     Encodes an Int32 array to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encode(int32ArrayForKey key: String) -> ([Int32]?) -> JSON? {
        return {
            int32Array in
            
            if let int32Array = int32Array {
                let numbers: [NSNumber] = int32Array.map { NSNumber(value: $0) }
                
                return [key : numbers]
            }
            
            return nil
        }
    }

	/**
	Encodes an UInt32 to JSON.

	- parameter key: Key used in JSON for decoded value.

	- returns: JSON encoded from value.
	*/
	public static func encode(uint32ForKey key: String) -> (UInt32?) -> JSON? {
		return {
			uint32 in

			if let uint32 = uint32 {
				return [key : NSNumber(value: uint32)]
			}

			return nil
		}
	}

	/**
	Encodes an UInt32 array to JSON.

	- parameter key: Key used in JSON for decoded value.

	- returns: JSON encoded from value.
	*/
	public static func encode(uint32ArrayForKey key: String) -> ([UInt32]?) -> JSON? {
		return {
			uInt32Array in

			if let uInt32Array = uInt32Array {
				let numbers: [NSNumber] = uInt32Array.map { NSNumber(value: $0) }

				return [key : numbers]
			}

			return nil
		}
	}

    /**
     Encodes an Int64 to JSON.

     - parameter key: Key used in JSON for decoded value.

     - returns: JSON encoded from value.
     */
    public static func encode(int64ForKey key: String) -> (Int64?) -> JSON? {
        return {
            int64 in
            
            if let int64 = int64 {
                return [key : NSNumber(value: int64)]
            }
            
            return nil
        }
    }
    
    /**
     Encodes an Int64 array to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encode(int64ArrayForKey key: String) -> ([Int64]?) -> JSON? {
        return {
            int64Array in
            
            if let int64Array = int64Array {
                let numbers: [NSNumber] = int64Array.map { NSNumber(value: $0) }
                
                return [key : numbers]
            }
            
            return nil
        }
    }

	/**
	Encodes an UInt64 to JSON.

	- parameter key: Key used in JSON for decoded value.

	- returns: JSON encoded from value.
	*/
	public static func encode(uint64ForKey key: String) -> (UInt64?) -> JSON? {
		return {
			uInt64 in

			if let uInt64 = uInt64 {
				return [key : NSNumber(value: uInt64)]
			}

			return nil
		}
	}

	/**
	Encodes an UInt64 array to JSON.

	- parameter key: Key used in JSON for decoded value.

	- returns: JSON encoded from value.
	*/
	public static func encode(uint64ArrayForKey key: String) -> ([UInt64]?) -> JSON? {
		return {
			uInt64Array in

			if let uInt64Array = uInt64Array {
				let numbers: [NSNumber] = uInt64Array.map { NSNumber(value: $0) }

				return [key : numbers]
			}

			return nil
		}
	}

    /**
     Encodes a URL to JSON.

     - parameter key: Key used in JSON for decoded value.

     - returns: JSON encoded from value.
     */
    public static func encode(urlForKey key: String) -> (URL?) -> JSON? {
        return {
            url in
            
            if let absoluteURLString = url?.absoluteString {
                return [key : absoluteURLString]
            }
            
            return nil
        }
    }

    /**
     Encodes a UUID to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encode(uuidForKey key: String) -> (UUID?) -> JSON? {
        return {
            uuid in
            
            if let uuidString = uuid?.uuidString {
                return [key : uuidString]
            }
            
            return nil
        }
    }
    
    /**
     Encodes a Decimal to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encode(decimalForKey key: String) -> (Decimal?) -> JSON? {
        return {
            decimal in
            
            if let decimal = decimal {
                return [key : NSDecimalNumber(decimal: decimal)]
            }
            
            return nil
        }
    }
    
    /**
     Encodes a Decimal array to JSON.
     
     - parameter key: Key used in JSON for decoded value.
     
     - returns: JSON encoded from value.
     */
    public static func encode(decimalArrayForKey key: String) -> ([Decimal]?) -> JSON? {
        return {
            decimalArray in
            
            if let decimalArray = decimalArray {
                let numbers: [NSDecimalNumber] = decimalArray.map { NSDecimalNumber(decimal: $0) }
                
                return [key : numbers]
            }
            
            return nil
        }
    }
}
