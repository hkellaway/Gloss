//
//  Repo.swift
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

struct Repo: Glossy {
    
    let repoId: Int
    let desc: String?
    let name: String
    let url: NSURL
    let owner: RepoOwner // nested model
    let ownerUrl: NSURL // nested keypath
    let primaryLanguage: Language?
    
    enum Language: String {
        case Swift = "Swift"
        case ObjectiveC = "Objective-C"
    }
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        guard let repoId: Int = "id" <~~ json,
            let name: String = Decoder.decodeStringUppercase("name", json: json),
            let url: NSURL = "html_url" <~~ json,
            let owner: RepoOwner = "owner" <~~ json,
            let ownerUrl: NSURL = "owner.html_url" <~~ json else {
                return nil
        }
        
        self.repoId = repoId
        self.name = name
        self.desc = "description" <~~ json
        self.url = url
        self.owner = owner
        self.ownerUrl = ownerUrl
        self.primaryLanguage = "language" <~~ json
    }
    
    // MARK: - Serialization
    
    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> self.repoId,
            "name" ~~> Encoder.encodeStringCapitalized("name", value: self.name),
            "description" ~~> self.desc,
            "html_url" ~~> self.url,
            "owner" ~~> self.owner,
            "owner.html_url" ~~> self.ownerUrl,
            "language" ~~> self.primaryLanguage
            ])
    }
}

// MARK: - Custom transformers

extension Decoder {
    
    static func decodeStringUppercase(key: String, json: JSON) -> String? {
        if let string = json.valueForKeyPath(key) as? String {
            return string.uppercaseString
        }
        
        return nil
    }
    
}

extension Encoder {
    
    static func encodeStringCapitalized(key: String, value: String?) -> JSON? {
        if let value = value {
            return [key : value.capitalizedString]
        }
        
        return nil
    }
    
}
