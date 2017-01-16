//
//  ExtensionDecodable.swift
//  Gloss
//
// Copyright © 2017 kampro
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

import Foundation

public extension Decodable {
    
    /**
     Initializes array of model objects from provided data.
     
     - parameter data: Raw JSON data, i.e. received from server.
     
     - returns: Object or nil.
     */
    init?(data: Data) {
        if let json = (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? JSON {
            self.init(json: json)
            return
        }
        
        return nil
    }
    
    
    /**
     Initializes array of model objects from provided data.
     
     - parameter data: Raw JSON array data.
     
     - returns: Array with model objects when decoding is successful, empty otherwise.
     */
    static func from(data: Data) -> [Self] {
        if let json = (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [JSON] {
            if let array = [Self].from(jsonArray: json) {
                return array
            }
        }
        
        return [Self]()
    }
    
}
