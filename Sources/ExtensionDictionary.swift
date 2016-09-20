//
//  ExtensionDictionary.swift
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

internal extension Dictionary {
    
    // MARK: - Internal functions
    
    /**
    Creates a dictionary from a list of elements. 
     
     This allows use of map, flatMap and filter.
    
    - parameter elements: Elements to add to the new dictionary.
    */
    init(elements: [Element]) {
        self.init()
        
        for (key, value) in elements {
            self[key] = value
        }
    }
    
    /**
     Flat map for dictionary.
     
     - parameter transform: Transform function.
     
     - returns: New dictionary of transformed values.
     */
    func flatMap<KeyPrime : Hashable, ValuePrime>(_ transform: (Key, Value) throws -> (KeyPrime, ValuePrime)?) rethrows -> [KeyPrime : ValuePrime] {
        return Dictionary<KeyPrime,ValuePrime>(elements: try flatMap({ (key, value) in
            return try transform(key, value)
        }))
    }
    
    /**
     Adds entries from provided dictionary to current dictionary.
     
     Note: If current dictionary and provided dictionary have the same
     key, the value from the provided dictionary overwrites current value.
     
     - parameter other:     Dictionary to add entries from
     - parameter delimiter: Key path delimiter
     */
    mutating func add(other: Dictionary) -> () {
        for (key, value) in other {
            self.updateValue(value, forKey:key)
        }
    }
    
}
