//
//  RepoOwner.swift
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

struct RepoOwner: Glossy, Codable {
    let id: Int
    let login: String?
    let htmlUrl: String?
}

// MARK: - Gloss

extension RepoOwner {
    
    // MARK: JSONDecodable
    
    init?(json: JSON) {
        guard
            let id: Int = "id" <~~ json else {
            return nil
        }
        let login: String? = "login" <~~ json
        let htmlUrl: String? = "html_url" <~~ json
        
        self.init(id: id, login: login, htmlUrl: htmlUrl)
    }
    
    // MARK: JSONEncodable
    
    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> self.id,
            "login" ~~> self.login,
            "html_url" ~~> self.htmlUrl
        ])
    }
    
}
