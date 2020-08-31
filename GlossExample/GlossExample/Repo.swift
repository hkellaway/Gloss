//
//  Repo.swift
//  GlossExample
//
// Copyright (c) 2020 Harlan Kellaway
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
import Gloss

struct Repo: Glossy, Codable {
    
    let repoId: Int
    let desc: String?
    let name: String
    let urlString: String?
    let owner: RepoOwner // nested model
    let primaryLanguage: Language?
    
    enum Language: String {
        case Swift = "Swift"
        case ObjectiveC = "Objective-C"
    }
}

// MARK: - Gloss

extension Repo {
    
    // MARK: JSONDecodable
    
    init?(json: JSON) {
        guard let repoId: Int = "id" <~~ json,
            let name: String = "name" <~~ json,
            let ownerJSON: JSON = json["owner"] as? JSON,
            let owner: RepoOwner = .from(decodableJSON: ownerJSON) else {
                return nil
        }
        
        self.repoId = repoId
        self.name = name
        self.desc = "description" <~~ json
        self.urlString = "html_url" <~~ json
        self.owner = owner
        self.primaryLanguage = "language" <~~ json
    }
    
    // MARK: JSONEncodable
    
    func toJSON() -> JSON? {
        var ownerJSON: JSON? = nil
        if let owner = self.owner.toEncodableJSON(jsonEncoder: .snakeCase()) {
            ownerJSON = ["owner": owner]
        }
        return jsonify([
            "id" ~~> self.repoId,
            "name" ~~> name,
            "description" ~~> self.desc,
            "html_url" ~~> self.urlString,
            ownerJSON,
            "language" ~~> self.primaryLanguage
            ])
    }
    
}

// MARK: - Migration to Codable

// MARK: Decodable

extension Repo.Language: Decodable { }

extension Repo {
    

    
    init(from decoder: Swift.Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let repoId = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let desc = try container.decode(String.self, forKey: .description)
        let urlString = try container.decode(String.self, forKey: .htmlUrl)
        let owner = try container.decode(RepoOwner.self, forKey: .owner)
        let primaryLanguage = try container.decodeIfPresent(Language.self, forKey: .language)
        self.init(repoId: repoId, desc: desc, name: name, urlString: urlString, owner: owner, primaryLanguage: primaryLanguage)
    }
    
}

// MARK: Encodable

extension Repo.Language: Encodable { }

extension Repo {
    
    fileprivate enum CodingKeys: String, CodingKey {
        case id, name, description, htmlUrl, owner, language
    }
    
    func encode(to encoder: Swift.Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.repoId, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.desc, forKey: .description)
        try container.encodeIfPresent(self.urlString, forKey: .htmlUrl)
        try container.encode(self.owner, forKey: .owner)
        try container.encodeIfPresent(self.primaryLanguage, forKey: .language)
    }
    
}
