//
//  TestFailableModel.swift
//  GlossExample
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

import Gloss

struct TestFailableModel: Glossy {
    
    let identifier: String
    let value: Int
    
    init?(json: JSON) {
        guard let identifier: String = "identifier" <~~ json,
            let value: Int = "value" <~~ json
            else { return nil }
        
        self.identifier = identifier
        self.value = value
    }
    
    func toJSON() -> JSON? {
        return [
            "identifier": self.identifier,
            "value": self.value,
        ]
    }
}

// Since Swift Package Manager doesn't support fixtures (i.e. stored JSON), we have to access the JSON using this method rather than reading file from Bundle.
#if SWIFT_PACKAGE
extension TestFailableModel {
    
    static var testInvalidJSON: JSON {
        return [
            "asdf": "dsafhkjdaf",
            "asjdkfhl": 203183492749,
            "asdfjhkhfsldjghi": 0.12390
        ]
    }
    
    static var testValidJSON: JSON {
        return [
            "identifier" : "unique",
            "value" : 99999
        ]
    }
}
#endif

// MARK: - Codable Migration

extension TestFailableModel: Decodable {
    
    init(from decoder: Swift.Decoder) throws {
        throw GlossError.decodableMigrationUnimplemented(context: "TestFailableModel")
    }
    
}

extension TestFailableModel: Encodable {
    
    func encode(to encoder: Swift.Encoder) throws {
        // Remove GlossError to see Codable error in console
        throw GlossError.encodableMigrationUnimplemented(context: "TestFailableModel")
    }
    
}
