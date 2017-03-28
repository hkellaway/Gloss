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

extension Dictionary {
    
    // MARK: - Public Functions
    
    /**
     Retrieves value from dictionary given a key path delimited with
     provided delimiter to indicate a nested value.
     
     For example, a dictionary with [ "outer" : [ "inner" : "value" ] ]
     could retrive 'value' via  path "outer.inner", given a
     delimiter of ''.
     
     - parameter keyPath:   Key path delimited by delimiter.
     - parameter delimiter: Delimiter.
     - parameter logger:    Logger.
     
     - returns: Value retrieved from dic
     */
    public func valueForKeyPath(keyPath: String, withDelimiter delimiter: String = GlossKeyPathDelimiter, logger: Logger = GlossLogger()) -> Any? {
        let keys = keyPath.components(separatedBy: delimiter)
        
        guard keys.first as? Key != nil else {
            logger.log(message: "Unable to use keyPath '\(keyPath)' as key on type: \(Key.self)")
            return nil
        }
        
        return self.findValue(keys: keys)
    }
    
    // MARK: - Internal functions
    
    /**
    Creates a dictionary from a list of elements. 
     
     This allows use of map, flatMap and filter.
    
    - parameter elements: Elements to add to the new dictionary.
    */
    internal init(elements: [Element]) {
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
    internal func flatMap<KeyPrime : Hashable, ValuePrime>(_ transform: (Key, Value) throws -> (KeyPrime, ValuePrime)?) rethrows -> [KeyPrime : ValuePrime] {
        return Dictionary<KeyPrime,ValuePrime>(elements: try flatMap({ (key, value) in
            return try transform(key, value)
        }))
    }
    
    // MARK: - Private functions
    
    /**
     Retrieves value from dictionary given a key path delimited with
     provided delimiter by going down the dictionary stack tree
     
     - parameter keys: Array of keys splited by delimiter
     - parameter depthLevel: Indicates current depth level in the dictionary tree
     - returns: object retrieved from dic
     */
    private func findValue(keys: [String], depthLevel: Int = 0) -> Any? {
        if let currentKey = keys[depthLevel] as? Key {
            if depthLevel == keys.count-1 {
                return self[currentKey]
            } else if let newDict = self[currentKey] as? Dictionary {
                return newDict.findValue(keys: keys, depthLevel: depthLevel+1)
            }
        }
        return nil
    }
}
