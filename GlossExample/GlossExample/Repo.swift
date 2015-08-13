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

class Repo : Glossy {
    
    let repoId: Int?
    let name: String?
    let desc: String?
    let url: NSURL?
    let owner: RepoOwner?
    let primaryLanguage: Language?
    
    enum Language: String {
        case Swift = "Swift"
        case ObjectiveC = "Objective-C"
    }
    
    // MARK: - Deserialization
    
    required init(json: JSON) {
        self.repoId = decode("id")(json)
        self.name = decode("name")(json)
        self.desc = decode("description")(json)
        self.url = Decoder.decodeURL("html_url")(json)
        self.owner = decode("owner")(json)
        self.primaryLanguage = Decoder.decodeEnum("language")(json)
        
        super.init(json: json)
    }
    
    // MARK - Serialization
    
    override func encoders() -> [JSON?] {
        return [
            encode("id")(self.repoId),
            encode("name")(self.name),
            encode("description")(self.desc),
            Encoder.encodeURL("html_url")(self.url),
            encode("owner")(self.owner),
            Encoder.encodeEnum("language")(self.primaryLanguage)
        ]
    }
    
}
