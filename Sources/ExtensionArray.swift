//
//  ExtensionArray.swift
//  Gloss
//
// Copyright (c) 2016 Rahul Katariya
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

public extension Array where Element: Decodable {
    
    /**
     Returns array of new instances created from provided JSON array
     
     Note: The returned array will have only models that successfully
     decoded
     
     :parameter: json Array of JSON representations of object
     */
    static func fromJSONArray(jsonArray: [JSON]) -> [Element] {
        var models: [Element] = []
        
        for json in jsonArray {
            let model = Element(json: json)
            
            if let model = model {
                models.append(model)
            }
        }
        
        return models
    }
    
}

public extension Array where Element: Encodable {
    
    /**
     Objects encoded as JSON Array
     
     :returns: JSON array
     */
    func toJSONArray() -> [JSON]? {
        var jsonArray: [JSON] = []
        
        for json in self {
            if let json = json.toJSON() {
                jsonArray.append(json)
            }
        }
        
        return jsonArray
    }
}

