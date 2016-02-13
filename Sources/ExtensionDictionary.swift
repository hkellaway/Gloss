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

public extension Dictionary {
    
    // MARK: - Public functions
    
    /**
     Parses the nested dictionary from the keyPath
     components separated with a delimiter and gets the value
     
     :parameter: keyPath   KeyPath with delimiter
     :parameter: delimiter Delimiter
     
     :returns: Value from the nested dictionary
     */
    public func valueForKeyPath(keyPath: String, withDelimiter delimiter: String = GlossKeyPathDelimiter()) -> AnyObject? {
        var keys = keyPath.componentsSeparatedByString(delimiter)
        
        guard let first = keys.first as? Key else {
            print("[Gloss] Unable to use string as key on type: \(Key.self)")
            return nil
        }
        
        guard let value = self[first] as? AnyObject else {
            return nil
        }
        
        keys.removeAtIndex(0)
        
        if !keys.isEmpty, let subDict = value as? JSON {
            let rejoined = keys.joinWithSeparator(delimiter)
            
            return subDict.valueForKeyPath(rejoined, withDelimiter: delimiter)
        }
        
        return value
    }
    
    // MARK: - Internal functions
    
    /**
    Creates a dictionary from a list of elements, this allows us to map, flatMap
     and filter dictionaries.
    
    :parameter: elements Elements to add to the new dictionary
    */
    init(elements: [Element]) {
        self.init()
        
        for (key, value) in elements {
            self[key] = value
        }
    }
    
    /**
     Flat map for dictionary.
     
     :parameter: transform Transform
     */
    func flatMap<KeyPrime : Hashable, ValuePrime>(transform: (Key, Value) throws -> (KeyPrime, ValuePrime)?) rethrows -> [KeyPrime : ValuePrime] {
        return Dictionary<KeyPrime,ValuePrime>(elements: try flatMap({ (key, value) in
            return try transform(key, value)
        }))
    }
    
    /**
     Adds entries from provided dictionary
     
     :parameter: other     Dictionary to add entries from
     :parameter: delimiter Keypath delimiter
     */
    mutating func add(other: Dictionary, delimiter: String = GlossKeyPathDelimiter()) -> () {
        for (key, value) in other {
            if let key = key as? String {
                self.setValue(valueToSet: value, forKeyPath: key, withDelimiter: delimiter)
            } else {
                self.updateValue(value, forKey:key)
            }
        }
    }
    
    // MARK: - Private functions

    /**
     Creates a nested dictionary from the keyPath 
     components separated with a delimiter and sets the value
     
     :parameter: valueToSet Value to set
     :parameter: keyPath    KeyPath of the value
     */
    private mutating func setValue(valueToSet val: Any, forKeyPath keyPath: String, withDelimiter delimiter: String = GlossKeyPathDelimiter()) {
        var keys = keyPath.componentsSeparatedByString(delimiter)
        
        guard let first = keys.first as? Key else {
            print("[Gloss] Unable to use string as key on type: \(Key.self)")
            return
        }
        
        keys.removeAtIndex(0)
        
        if keys.isEmpty, let settable = val as? Value {
            self[first] = settable
        } else {
            let rejoined = keys.joinWithSeparator(delimiter)
            var subdict: JSON = [:]
            
            if let sub = self[first] as? JSON {
                subdict = sub
            }
            
            subdict.setValue(valueToSet: val, forKeyPath: rejoined, withDelimiter: delimiter)
            
            if let settable = subdict as? Value {
                self[first] = settable
            } else {
                print("[Gloss] Unable to set value: \(subdict) to dictionary of type: \(self.dynamicType)")
            }
        }
        
    }
    
}
