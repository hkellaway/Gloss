//
//  TestNestedModel.swift
//  GlossExample
//
// Copyright (c) 2016 Edison Mejia
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

struct TestPartiallyDecodedModel: Glossy, ArrayPartiallyDecodable {
    
    let id: Int?
    let name: String?
    let uuid: UUID?
    let url: URL?
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        guard let id: Int = "id" <~~ json,
            let name: String = "name" <~~ json
            else { return nil }
        
        self.id = id
        self.name = name
        self.uuid = "uuid" <~~ json
        self.url = "url" <~~ json
    }
    
    // MARK: - Serialization
    
    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> self.id,
            "name" ~~> self.name,
            "uuid" ~~> self.uuid,
            "url" ~~> self.url
            ])
    }
    
}

extension TestPartiallyDecodedModel: Equatable { }

func == (lhs: TestPartiallyDecodedModel, rhs: TestPartiallyDecodedModel) -> Bool {
    return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.uuid == rhs.uuid
        && lhs.url == rhs.url
}
