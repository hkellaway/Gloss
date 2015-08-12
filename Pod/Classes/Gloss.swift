//
//  Gloss.swift
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

public typealias JSON = [String : AnyObject]

public protocol Glossy: Decodable {
    
    /**
    Designated initializer to create new object
    from JSON representation
    
    - parameter json: JSON representation of object
    */
    init(json: JSON)
    
}

public protocol Decodable {
    
    /**
    Array of decoding functions
    */
    func decoders() -> [JSON -> ()]
    
}

public protocol Encodable {
    
    /**
    Array of encoded values as JSON
    */
    func encoders() -> [JSON?]
    
    /**
    JSON representation of object
    */
    func toJSON() -> JSON
}

public class Gloss : Glossy, Encodable {
    
    // MARK: - Initialization
    
    required public init(json: JSON) {
        applyDecoders(self.decoders())(json)
    }
    
    // MARK: - Protocol conformance
    
    // MARK: Decodable
    
    public func decoders() -> [JSON -> ()] {
        return []
    }
    
    // MARK: Encodable
    
    public func encoders() -> [JSON?] {
        return []
    }
    
    public func toJSON() -> JSON {
        var json: JSON = [:]
        
        for encoder in self.encoders() {
            if let encoder = encoder {
                json.add(encoder)
            }
        }
        
        return json
    }
    
    // MARK: - Private methods
    
    private func applyDecoders(decoders: [JSON -> ()]) -> JSON -> () {
        return {
            json in
            
            for decoder in decoders {
                decoder(json)
            }
        }
    }
    
}
