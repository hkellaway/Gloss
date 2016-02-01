//
//  Dictionary.swift
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
    
    /**
    Adds entries from provided dictionary
    
    :parameter: other Dictionary to add entries from
    */
    public mutating func add(other: Dictionary) -> () {
        for (key, value) in other {
            if var previousValue = self[key] as? Dictionary, let currentValue = value as? Dictionary {
                previousValue.add(currentValue)
                self.updateValue(previousValue as! Value, forKey:key)
            } else {
                self.updateValue(value, forKey:key)
            }
        }
    }
    
    /**
     Creates a nested dictionary from the keyPath 
     components separated with '.' and set the value
     
     :parameter: val     value to set
     :parameter: keyPath keyPath of the value
     */
    mutating public func setValue(val: AnyObject, forKeyPath keyPath: String) {
        var keys = keyPath.componentsSeparatedByString(".")
        guard let first = keys.first as? Key else { print("Unable to use string as key on type: \(Key.self)"); return }
        keys.removeAtIndex(0)
        if keys.isEmpty, let settable = val as? Value {
            self[first] = settable
        } else {
            let rejoined = keys.joinWithSeparator(".")
            var subdict: [NSObject : AnyObject] = [:]
            if let sub = self[first] as? [NSObject : AnyObject] {
                subdict = sub
            }
            subdict.setValue(val, forKeyPath: rejoined)
            if let settable = subdict as? Value {
                self[first] = settable
            } else {
                print("Unable to set value: \(subdict) to dictionary of type: \(self.dynamicType)")
            }
        }
        
    }
    
    
    /**
     Parse the nested dictionary from the keyPath 
     components separated with '.' and get the value
     
     :parameter: keyPath keyPath with seperator '.'
     
     :returns: value from the nested dictionary
     */
    public func valueForKeyPath(keyPath: String) -> AnyObject? {
        var keys = keyPath.componentsSeparatedByString(".")
        guard let first = keys.first as? Key else { print("Unable to use string as key on type: \(Key.self)"); return nil }
        guard let value = self[first] as? AnyObject else { return nil }
        keys.removeAtIndex(0)
        if !keys.isEmpty, let subDict = value as? [NSObject : AnyObject] {
            let rejoined = keys.joinWithSeparator(".")
            return subDict.valueForKeyPath(rejoined)
        }
        return value
    }
    
}
